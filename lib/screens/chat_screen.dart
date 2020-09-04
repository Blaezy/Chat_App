import 'package:chat_app/widgets/chat/messages.dart';
import 'package:chat_app/widgets/chat/newmessage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('hello');

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Chat'),
        actions: [
          DropdownButton(
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') FirebaseAuth.instance.signOut();
              })
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage()
          ],
        ),
      ),
      // StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection('chats/TgW7GNGusQUvGUGbbPUY/messages')
      //         .snapshots(),
      //     builder: (ctx, streamSnapshot) {
      //       if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //         return CircularProgressIndicator();
      //       }
      //       final documents = streamSnapshot.data.documents;
      //       return ListView.builder(
      //           itemCount: documents.length,
      //           itemBuilder: (ctx, index) => Container(
      //                 padding: EdgeInsets.all(8),
      //                 child: Text(documents[index].data()['text']),
      //               ));
      // //     }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     //await Firebase.initializeApp();
      //     FirebaseFirestore.instance
      //         .collection('chats/TgW7GNGusQUvGUGbbPUY/messages')
      //         .add({'text': 'This was added by clicking the button!'});
      //   },
      //   child: Icon(Icons.add),
      // ),
    );
  }
}
