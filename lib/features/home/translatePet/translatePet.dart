import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pawrentingreborn/common/widgets/navbar.dart';
import 'package:pawrentingreborn/navigationMenu.dart';
import 'package:web_socket_channel/io.dart';

import '../../mypets/controllers/navbarcontroller.dart';

class TranslatePet extends StatefulWidget {
  const TranslatePet({super.key});

  @override
  _TranslatePetState createState() => _TranslatePetState();
}

class _TranslatePetState extends State<TranslatePet> {
  NavBarController controller = Get.find();
  NavigationController navcontroller = Get.find();
  CameraController? _controller;
  IOWebSocketChannel? _channel;
  Uint8List? _processedImage;
  String _emojiPath = "";
  bool _isDogSelected = true;
  bool _isCapturing = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
    _connectWebSocket();
  }

  void _connectWebSocket() {
    try {
      _channel = IOWebSocketChannel.connect("ws://174.139.116.20:8080");

      _channel!.stream.listen(
        (message) {
          final responseData = jsonDecode(message);
          print("Received Data from Server: $responseData");

          if (responseData.containsKey("frame")) {
            setState(() {
              _processedImage = base64Decode(responseData["frame"]);
              _emojiPath = responseData["emotion"];
            });
            print("Updated Emotion: $_emojiPath");
          }
        },
        onError: (error) {
          print("WebSocket Error: $error");
          Future.delayed(Duration(seconds: 5), () {
            print("Reconnecting WebSocket...");
            _connectWebSocket();
          });
        },
        onDone: () {
          print("WebSocket closed. Reconnecting...");
          Future.delayed(Duration(seconds: 5), () {
            _connectWebSocket();
          });
        },
      );
    } catch (e) {
      print("WebSocket Connection Failed: $e");
    }
  }

  Future<void> _initializeCamera() async {
    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) return;

      _controller = CameraController(cameras[0], ResolutionPreset.medium);
      await _controller!.initialize();
      await _controller!.setFlashMode(FlashMode.off);
      _startStreaming();

      setState(() {});
    } catch (e) {
      print("Error initializing camera: $e");
    }
  }

  void _startStreaming() {
    if (_controller == null || !_controller!.value.isInitialized) return;

    _controller!.startImageStream((CameraImage image) async {
      if (!_isCapturing) {
        _isCapturing = true;

        // Convert image ke base64
        final bytes = image.planes[0].bytes;
        String base64Image = base64Encode(Uint8List.fromList(bytes));

        _channel!.sink.add(jsonEncode({
          "animal": _isDogSelected ? "dog" : "cat",
          "frame": base64Image,
        }));

        await Future.delayed(Duration(milliseconds: 500));
        _isCapturing = false;
      }
    });
  }

  @override
  void dispose() {
    _controller?.dispose();
    _channel?.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Translate Pet")),
      bottomNavigationBar: InsideNavBar(
        controller: controller,
        navcontroller: navcontroller,
      ),
      body: Stack(
        children: [
          if (_controller == null || !_controller!.value.isInitialized)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  Text("Loading camera..."),
                ],
              ),
            )
          else
            Positioned.fill(child: CameraPreview(_controller!)),
          if (_processedImage == null)
            Center(child: CircularProgressIndicator())
          else
            Positioned.fill(
              child: Image.memory(_processedImage!, fit: BoxFit.cover),
            ),
          if (_emojiPath.isNotEmpty)
            Positioned(
              top: 50,
              left: MediaQuery.of(context).size.width / 2 - 50,
              child: Column(
                children: [
                  Image.asset("assets/$_emojiPath.png", width: 80, height: 80),
                  Text(
                    _emojiPath.toUpperCase(),
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          Positioned(
            bottom: 80,
            left: MediaQuery.of(context).size.width / 2 - 35,
            child: FloatingActionButton(
              onPressed: () {
                setState(() {
                  _isDogSelected = !_isDogSelected;
                });
              },
              child: Icon(
                _isDogSelected ? Icons.pets : Icons.add_alert_rounded,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
