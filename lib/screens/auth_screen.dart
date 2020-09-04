import 'package:chat_app/widgets/auth/auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final instance = FirebaseAuth.instance;
  var isLoading = false;
  void _submitAuthForm(String email, String password, String userName,
      bool isLogin, BuildContext ctx) async {
    UserCredential result;
    if (mounted)
      setState(() {
        isLoading = true;
      });
    try {
      if (isLogin) {
        result = await instance.signInWithEmailAndPassword(
            email: email, password: password);
      } else {
        result = await instance.createUserWithEmailAndPassword(
            email: email, password: password);
      }
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(result.user.uid)
          .set({'userName': userName, 'email': email});
    } on PlatformException catch (err) {
      var errormsz = 'Could not validate your credentials';
      if (err.message != null) {
        errormsz = err.message;
      }
      print('shiv');
      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(errormsz),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      if (mounted)
        setState(() {
          isLoading = false;
        });
    } catch (err) {
      print(err);
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(err.message),
        backgroundColor: Theme.of(context).errorColor,
      ));
    }
    if (mounted)
      setState(() {
        isLoading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm, isLoading),
    );
  }
}
