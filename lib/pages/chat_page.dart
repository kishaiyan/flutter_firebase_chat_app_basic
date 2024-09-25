import 'package:authenticatio_samplen/services/auth/auth_service.dart';
import 'package:authenticatio_samplen/services/chat/chat_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String useremail;
  final String receiverId;

  ChatPage({super.key, required this.useremail, required this.receiverId});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  //text Controller
  final TextEditingController messageController = TextEditingController();

  //chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //focusNode
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
      }
    });

    Future.delayed(const Duration(milliseconds: 500), () => scrollDown());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();
    messageController.dispose();
    super.dispose();
  }

  ScrollController scrollController = ScrollController();
  void scrollDown() {
    scrollController.animateTo(scrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 1), curve: Curves.easeOutQuad);
  }

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(widget.receiverId, messageController.text);

      messageController.clear();
    }
    scrollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(
            widget.useremail,
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              // Display the messages
              Expanded(child: _buildMessageList()),
              // Text Area to send
              _buildSenderText(),
            ],
          ),
        ));
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMesages(widget.receiverId, senderId),
        builder: (context, snapshot) {
          //error
          if (snapshot.hasError) {
            return const Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Loading");
          }

          //return a tile
          return ListView(
            controller: scrollController,
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == _authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Align(
      alignment: alignment,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
            color: isCurrentUser ? Colors.green : Colors.grey,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          children: [
            Text(data["message"]),
          ],
        ),
      ),
    );
  }

  Widget _buildSenderText() {
    return Row(
      children: [
        // Expanded widget allows TextField to fill available space in the Row
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: TextField(
              focusNode: focusNode,
              controller: messageController,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 68, 228, 73)),
                ),
                hintText: "Type your message ..",
              ),
            ),
          ),
        ),
        // Add a clickable icon for sending the message
        IconButton(
          icon: const Icon(
            Icons.send,
            size: 40,
            color: Color.fromARGB(255, 68, 228, 73),
          ),
          onPressed: sendMessage, // Add the sendMessage function to handle taps
        ),
      ],
    );
  }
}
