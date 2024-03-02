import 'package:flutter/material.dart';

class Comment {
  final String authorName = 'Tirtesh Vishal Kolhe';
  final String content;

  Comment({required this.content});
}

class CommentScreen extends StatefulWidget {
  const CommentScreen({super.key});

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();
  List<Comment> comments = [];

  void addComment() {
    if (_commentController.text.isNotEmpty) {
      setState(() {
        comments.add(
          Comment(
            // You can replace it with the actual user name if available
            content: _commentController.text,
          ),
        );
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(comments[index].authorName),
                  subtitle: Text(comments[index].content),
                );
              },
            ),
          ),
          const Divider(height: 1.0),
          ListTile(
            title: TextFormField(
              controller: _commentController,
              decoration:
                  const InputDecoration(labelText: 'Write a comment...'),
            ),
            trailing: OutlinedButton(
              onPressed: addComment,
              child: const Text("Post"),
            ),
          ),
        ],
      ),
    );
  }
}
