import 'package:authenticatio_samplen/components/text_field.dart';
import 'package:authenticatio_samplen/services/social_post/post_service.dart';
import 'package:flutter/material.dart';

class WallPage extends StatelessWidget {
  WallPage({super.key});
  final postController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    PostService _postService = PostService();
    void postMessage() {
      if (postController.text.isNotEmpty) {
        _postService.sendPost(postController.text);
        postController.clear();
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("WALL"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: MyTextField(
                        controller: postController,
                        hintText: "Tell Something",
                        obscure: false),
                  ),
                  IconButton(
                      onPressed: postMessage,
                      icon: Icon(
                        Icons.send_sharp,
                        size: 32,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ))
                ],
              ),
              StreamBuilder(
                  stream: _postService.getPosts(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    final post = snapshots.data!.docs;
                    if (snapshots.data == null || post.isEmpty) {
                      return Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: Text("No Posts"),
                        ),
                      );
                    }

                    return Expanded(
                      child: ListView.builder(
                          itemCount: post.length,
                          itemBuilder: (context, index) {
                            final userPost = post[index];

                            return ListTile(
                              title: Text(userPost['postMessage']),
                              subtitle: Text(userPost['owner']),
                            );
                          }),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
