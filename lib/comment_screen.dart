import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Comment {
  final String id;
  final String content;
  final String author;
  final Timestamp timestamp;
  final String postId;

  Comment({
    required this.id,
    required this.content,
    required this.author,
    required this.timestamp,
    required this.postId,
  });

  factory Comment.fromDocument(DocumentSnapshot doc) {
    return Comment(
      id: doc.id,
      content: doc['content'],
      author: doc['author'],
      timestamp: doc['timestamp'],
      postId: doc['postId'],
    );
  }
}

class CommentScreen extends StatefulWidget {
  final DocumentSnapshot post;

  const CommentScreen({Key? key, required this.post}) : super(key: key);

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  void addComment() async {
    User? user = FirebaseAuth.instance.currentUser;
    String user_id = user!.uid;
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(user_id).get();

    if (!userDoc.exists) {
      // Handle the case where the user document does not exist
      print('User document does not exist');
      return;
    }

    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    if (userData == null || !userData.containsKey('fullName')) {
      // Handle the case where the user document does not have a 'fullName' field
      print('User document does not have a fullName field');
      return;
    }

    String fullName = userData['fullName'];
    await FirebaseFirestore.instance.collection('comments').add({
      'authorId': user_id,
      'authorName': fullName,
      'postId': widget.post.id,
      'content': _commentController.text,
      'timestamp': Timestamp.now(),
    });
    _commentController.clear();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Comment added')));
  }

  void deleteComment(String commentId) async {
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(commentId)
        .delete();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Comment deleted')));
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
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('comments')
                  .where('postId', isEqualTo: widget.post.id)
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                List<DocumentSnapshot> docs = snapshot.data!.docs;
                List<Widget> comments =
                    docs.map((doc) => buildItem(doc)).toList();

                return ListView(
                  children: comments,
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

  Widget buildItem(DocumentSnapshot document) {
    return ListTile(
      title: Text(document['authorName']),
      subtitle: Text(document['content']),
      trailing: document['authorId'] == FirebaseAuth.instance.currentUser!.uid
          ? PopupMenuButton<int>(
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 1,
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('Delete'),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  _commentController.text = document['content'];
                  updateComment(document.id);
                } else if (value == 2) {
                  deleteComment(document.id);
                }
              },
            )
          : null,
    );
  }

  void updateComment(String commentId) async {
    await FirebaseFirestore.instance
        .collection('comments')
        .doc(commentId)
        .update({'content': _commentController.text});
    _commentController.clear();
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Comment updated')));
  }
}
