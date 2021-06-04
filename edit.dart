import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
void main() {
  runApp(edit());
}
class edit extends StatefulWidget {
  DocumentSnapshot docToEdit;
  edit({this.docToEdit});
  @override
  _editState createState() => _editState(docToEdit);
}

class _editState extends State<edit> {
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  final ref = FirebaseFirestore.instance.collection('notes');

  _editState(DocumentSnapshot docToEdit);  //here is collection we have
  @override
  void initState() {
    title = TextEditingController(text: widget.docToEdit['title']);
    content = TextEditingController(text: widget.docToEdit['content']);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton(
              onPressed: () {
                widget.docToEdit.reference.update({
                  'title': title.text,
                  'content': content.text,
                }).whenComplete(() => Navigator.pop(context));
              },
              child: Text('SAVE')),
          FlatButton(
              onPressed: () {
                widget.docToEdit.reference.delete().whenComplete(() => Navigator.pop(context));
              },
              child: Text('Delete')),
        ],
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(border: Border.all()),
              child: TextField(
                controller: title,
                decoration: InputDecoration(hintText: 'Title'),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(border: Border.all()),
                child: TextField(
                  controller: content,
                  maxLines: null,
                  expands: true,
                  decoration: InputDecoration(hintText: 'Content'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

