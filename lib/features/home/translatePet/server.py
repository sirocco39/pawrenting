from flask import Flask
from flask_socketio import SocketIO
import cv2
import numpy as np
import base64
from ultralytics import YOLO
import os

app = Flask(__name__)
socketio = SocketIO(app, cors_allowed_origins="*")

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

# Load model dengan path yang benar
models = {
    "dog": {
        "detection": YOLO(os.path.join(BASE_DIR, "model", "dog_detection.pt")),
        "emotion": YOLO(os.path.join(BASE_DIR, "model", "dog_emotion.pt")),
    },
    "cat": {
        "detection": YOLO(os.path.join(BASE_DIR, "model", "cat_detection.pt")),
        "emotion": YOLO(os.path.join(BASE_DIR, "model", "cat_emotion.pt")),
    }
}

@app.route("/")
def home():
    return "Pawrenting API is running on port 8080!", 200

@socketio.on("message")
def handle_frame(json_data):
    try:
        animal_type = json_data.get("animal", "").lower()  # Pastikan lowercase untuk validasi
        frame_data = json_data.get("frame", "")

        if not frame_data:
            print("[ERROR] No frame data received!")  # 🔍 Debug jika tidak ada gambar
            socketio.emit("response", {"error": "No frame data"})
            return

        if animal_type not in models:
            print(f"[ERROR] Invalid animal type: {animal_type}")  # 🔍 Debug jika tipe hewan salah
            socketio.emit("response", {"error": "Invalid Animal"})
            return

        print(f"[INFO] Processing frame for {animal_type}...")  # 🔍 Log masuk

        # Decode base64 ke gambar
        try:
            img_bytes = base64.b64decode(frame_data)
            np_img = np.frombuffer(img_bytes, np.uint8)
            frame = cv2.imdecode(np_img, cv2.IMREAD_COLOR)
            if frame is None:
                raise ValueError("Decoded frame is None")
        except Exception as e:
            print(f"[ERROR] Frame decoding failed: {e}")  # 🔍 Debug jika decoding gagal
            socketio.emit("response", {"error": "Frame decoding failed"})
            return

        # Deteksi hewan
        results = models[animal_type]["detection"](frame)
        detected = False
        emotion_label = "Not Detected"

        for box in results[0].boxes:
            x1, y1, x2, y2 = map(int, box.xyxy[0])
            confidence = box.conf[0].item()

            if confidence >= 0.7:
                detected = True
                face = frame[y1:y2, x1:x2]
                print(f"[INFO] {animal_type.capitalize()} detected with confidence: {confidence}")  # 🔍 Log deteksi

                # Prediksi emosi
                emotion_results = models[animal_type]["emotion"](face)
                for e_result in emotion_results:
                    for e_box in e_result.boxes:
                        temp_label = e_result.names[int(e_box.cls[0])]
                        if e_box.conf[0].item() >= 0.3:
                            emotion_label = temp_label
                            print(f"[INFO] Detected Emotion: {emotion_label}")  # 🔍 Log emosi
                            break

        # Encode hasil frame
        _, buffer = cv2.imencode(".jpg", frame)
        encoded_frame = base64.b64encode(buffer).decode("utf-8")

        # Kirim ke Flutter
        socketio.emit("response", {"frame": encoded_frame, "emotion": emotion_label})
        print(f"[INFO] Sent Emotion: {emotion_label}")  # 🔍 Log hasil akhir

    except Exception as e:
        print(f"[ERROR] {e}")
        socketio.emit("response", {"error": str(e)})

if __name__ == "__main__":
    socketio.run(app, host="0.0.0.0", port=8080, debug=True)
