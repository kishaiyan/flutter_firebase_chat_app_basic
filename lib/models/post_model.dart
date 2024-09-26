import 'package:cloud_firestore/cloud_firestore.dart';

class PostDetails {
  final String message;
  final String userEmail;
  final Timestamp timestamp;
  PostDetails({
    required this.message,
    required this.userEmail,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      'postMessage': message,
      'owner': userEmail,
      'timestamp': timestamp,
    };
  }
}
