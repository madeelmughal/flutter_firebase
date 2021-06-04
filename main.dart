import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'addNote.dart';
import 'edit.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home:home(),
    );
  }
}
class home extends StatelessWidget {
  final ref = FirebaseFirestore.instance.collection('Notes');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Home"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
         Navigator.push(context, MaterialPageRoute(builder: (_) => add()));
        },
      ),
      body: StreamBuilder(
          stream: ref.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.hasData ? snapshot.data.docs.length : 0,
                itemBuilder: (_, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => edit(
                                docToEdit: snapshot.data.docs[index],
                              )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      height: 150,
                      color: Colors.grey[100],
                      child: Column(
                        children: [
                          Text(snapshot.data.docs[index]['title']),
                          Text(snapshot.data.docs[index]['content']),
                        ],
                      ),
                    ),
                  );
                });
          }),
    );
  }
}
