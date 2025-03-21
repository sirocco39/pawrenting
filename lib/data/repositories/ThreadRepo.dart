import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pawrentingreborn/features/community/models/thread_comment.dart';
import 'package:pawrentingreborn/features/community/models/thread_message.dart';

class ThreadRepo extends GetxController {
  static ThreadRepo get instance => Get.find();
  final _db = FirebaseFirestore.instance;

  /// Fetch thread dari Firestore
  Future<List<ThreadMessage>> fetchThread() async {
    try {
      final snapshot = await _db.collection('threads').orderBy('createdAt', descending: true).get();
      
      if (snapshot.docs.isEmpty) {
        print("No threads found"); // Debugging
        return [];
      }

      return snapshot.docs.map((e) {
        try {
          return ThreadMessage.fromSnapshot(e);
        } catch (error) {
          print("Error parsing document: $error");
          return null;
        }
      }).where((thread) => thread != null).cast<ThreadMessage>().toList();

    } catch (e) {
      print("Error fetching threads: $e");
      return [];
    }
  }

  /// Menambahkan thread baru ke Firestore
  Future<void> createThread(ThreadMessage thread) async {
    try {
      await _db.collection('threads').add(thread.toJson());
      print("Thread berhasil ditambahkan!");
    } catch (e) {
      print("Error creating thread: $e");
    }
  }

  /// Mengupdate thread di Firestore
  Future<void> updateThread(ThreadMessage message) async {
    try {
      await _db.collection('threads').where('id', isEqualTo: message.id).get().then((snapshot) {
        for (DocumentSnapshot ds in snapshot.docs) {
          ds.reference.update(message.toJson());
        }
      });
      print('Product updated successfully');
    } catch (e) {
      print('Error updating product: $e');
    }
  }


  //Mencari thread dengan searchbar
  Future<List<ThreadMessage>> searchThreads(String keyword) async {
  try {
    final snapshot = await _db
        .collection('threads')
        .where('text', isGreaterThanOrEqualTo: keyword) // Mencari berdasarkan text
        .where('text', isLessThanOrEqualTo: keyword + '\uf8ff') // Batasan pencarian
        .get();

    if (snapshot.docs.isEmpty) {
      print("No matching threads found");
      return [];
    }

    return snapshot.docs.map((e) => ThreadMessage.fromSnapshot(e)).toList();
  } catch (e) {
    print("Error searching threads: $e");
    return [];
  }
}

}
