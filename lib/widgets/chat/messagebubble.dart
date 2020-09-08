import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final String userName;
  final String userImage;
  final bool isMe;
  final Key key;
  MessageBubble(this.message, this.userName, this.userImage, this.isMe,
      {this.key});

  // Stream<DocumentSnapshot> provideDocumentFielDStream() {
  //   return FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(userId)
  //       .snapshots();
  // }

  // String getUserName(String userId) {
  //   return FirebaseFirestore.instance
  //       .collection('Users')
  //       .doc(userId)
  //       .set(data)
  //       .toString();
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: isMe
                          ? Colors.blueGrey[300]
                          : Theme.of(context).accentColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft:
                              !isMe ? Radius.circular(0) : Radius.circular(12),
                          bottomRight:
                              isMe ? Radius.circular(0) : Radius.circular(12))),
                  width: 140,
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        userName,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      // StreamBuilder(
                      //     stream: FirebaseFirestore.instance
                      //         .collection('Users')
                      //         .snapshots(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.hasData) {
                      //         final user = snapshot.data.documents.where((f) {
                      //           return f.documentID == userId;
                      //         }).toList();
                      //         return Text(user.);
                      //       }
                      //       return Text('Loading...');
                      //     }),
                      Text(
                        message,
                        textAlign: isMe ? TextAlign.end : TextAlign.start,
                        style: TextStyle(
                            color: isMe ? Colors.black : Colors.white),
                      ),
                    ],
                  )),
            ]),
        Positioned(
          child: CircleAvatar(
            backgroundImage: NetworkImage(userImage),
          ),
          top: 0,
          left: !isMe ? 120 : null,
          right: !isMe ? null : 120,
        ),
      ],
    );
  }
}
