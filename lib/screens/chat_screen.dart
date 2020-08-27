import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('hello');

    return Scaffold(
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text('This Works'),
              )),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            //await Firebase.initializeApp();
            FirebaseFirestore.instance
                .collection('chats/TgW7GNGusQUvGUGbbPUY/messages')
                .snapshots()
                .listen((data) {
              data.docs.forEach((element) {
                print(element.data()['text']);
              });
            });
          },
          child: Icon(Icons.add)),
    );
  }
}
