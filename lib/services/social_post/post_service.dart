import 'package:authenticatio_samplen/models/post_model.dart';
import 'package:authenticatio_samplen/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostService {
  AuthService _authService = AuthService();
  final _postService = FirebaseFirestore.instance.collection('Posts');

  void sendPost(String post) {
    final user = _authService.getCurrentUser()!.email!;
    final newPost =
        PostDetails(message: post, userEmail: user, timestamp: Timestamp.now());

    _postService.add(newPost.toMap());
  }

  Stream<QuerySnapshot> getPosts() {
    return _postService.orderBy('timestamp', descending: true).snapshots();
  }
}
