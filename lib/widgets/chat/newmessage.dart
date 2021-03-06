import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  void sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .get();
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('chat').add({
      'text': _entered,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'userName': userData.data()['userName'],
      'userImage': userData.data()['image_url'],
    });
    _controller.clear();
  }

  var _entered = '';
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 8),
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(labelText: 'Your Message'),
                onChanged: (value) {
                  setState(() {
                    _entered = value;
                  });
                },
              ),
            ),
            IconButton(
                icon: Icon(Icons.send),
                color: Theme.of(context).primaryColor,
                onPressed: _entered.trim().isEmpty ? null : sendMessage)
          ],
        ));
  }
}
