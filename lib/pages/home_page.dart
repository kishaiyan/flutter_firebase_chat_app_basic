import 'package:authenticatio_samplen/components/drawer_custom.dart';
import 'package:authenticatio_samplen/components/user_tile.dart';
import 'package:authenticatio_samplen/pages/chat_page.dart';
import 'package:authenticatio_samplen/services/auth/auth_service.dart';
import 'package:authenticatio_samplen/services/chat/chat_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("welcome"),
      ),
      drawer: const MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: buildUserList(),
      ),
    );
  }

  Widget buildUserList() {
    return StreamBuilder(
        stream: _chatService.getUserStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading . .");
          }
          return ListView(
            children: snapshot.data!
                .map<Widget>((userData) => buildUserTile(userData, context))
                .toList(),
          );
        });
  }

  Widget buildUserTile(Map<String, dynamic> userData, BuildContext context) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        name: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        useremail: userData["email"],
                        receiverId: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
