import 'package:chat_app/widgets/chat/messagebubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
      builder: (ctx, chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return ListView.builder(
              reverse: true,
              itemCount: chatSnapshot.data.documents.length,
              itemBuilder: (ctx, index) => MessageBubble(
                    chatSnapshot.data.documents[index].data()['text'],
                    chatSnapshot.data.documents[index].data()['userName'],
                    chatSnapshot.data.documents[index].data()['userImage'],
                    chatSnapshot.data.documents[index].data()['userId'] ==
                        FirebaseAuth.instance.currentUser.uid,
                    key:
                        ValueKey(chatSnapshot.data.documents[index].documentID),
                  )
              // Text(chatSnapshot.data.documents[index].data()['text']),
              );
        }
      },
    );
  }
}
