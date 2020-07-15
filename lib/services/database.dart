import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  uploadUserInfo(usermap) {
    Firestore.instance.collection("users").add(usermap);
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("conversations")
        .document(chatRoomId)
        .setData(chatRoomMap);
  }
}
