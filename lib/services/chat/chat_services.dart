import 'package:authenticatio_samplen/models/message_model.dart';
import 'package:authenticatio_samplen/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatService {
  AuthService _authService = AuthService();
  //get instance of the database
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //get user stream
  Stream<List<Map<String, dynamic>>> getUserStream() {
    return _firestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final user = doc.data();

        return user;
      }).toList();
    });
  }

  //send messages
  Future<void> sendMessage(String receiverId, String message) async {
    //fetch current UserId
    final String currentUserId = _authService.getCurrentUser()!.uid;
    final String currentUserEmail = _authService.getCurrentUser()!.email!;
    final Timestamp timestamp = Timestamp.now();

    //create a new message
    Message newMessage = Message(
        senderEmail: currentUserEmail,
        message: message,
        receiverId: receiverId,
        timestamp: timestamp,
        senderId: currentUserId);
    //Create a new chatroom
    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoom = ids.join("_");

    //add new message to the database
    await _firestore
        .collection("chatrooms")
        .doc(chatRoom)
        .collection('messages')
        .add(newMessage.toMap());
  }

  //Get the messages
  Stream<QuerySnapshot> getMesages(String userId, otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoom = ids.join("_");

    return _firestore
        .collection("chatrooms")
        .doc(chatRoom)
        .collection("messages")
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
