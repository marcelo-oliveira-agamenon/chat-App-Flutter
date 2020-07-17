import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("users")
        .where("name", isEqualTo: username)
        .getDocuments();
  }

  getUserByUserEmail(String email) async {
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
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

  addConversationsMessages(String chatRoomId, messageMap) {
    Firestore.instance
        .collection("conversations")
        .document(chatRoomId)
        .collection("listChats")
        .add(messageMap);
  }

  getConversationsMessages(String chatRoomId) async {
    return await Firestore.instance
        .collection("conversations")
        .document(chatRoomId)
        .collection("listChats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRooms(String username) async {
    return await Firestore.instance
        .collection("conversations")
        .where("users", arrayContains: username)
        .snapshots();
  }
}
