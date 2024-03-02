import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DocumentRetrieval extends StatefulWidget {
  final String clubId;
  const DocumentRetrieval({super.key, required this.clubId});

  @override
  _DocumentRetrievalState createState() => _DocumentRetrievalState();
}

class _DocumentRetrievalState extends State<DocumentRetrieval> {
  List<String> documentNames = [];

  Future<void> fetchClubDocuments() async {
    final firestoreInstance = FirebaseFirestore.instance;
    final documentsSnapshot = await firestoreInstance
        .collection('clubs')
        .doc(widget.clubId)
        .collection('documents')
        .get();

    setState(() {
      documentNames = documentsSnapshot.docs.map((doc) => doc.id).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchClubDocuments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Club Documents')),
      body: Center(
        child: ListView.builder(
          itemCount: documentNames.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(documentNames[index]),
            );
          },
        ),
      ),
    );
  }
}
