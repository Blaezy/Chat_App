import 'dart:io';

import 'package:chat_app/widgets/pickers/image_picker.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(String email, String password, String userName,
      bool isLogin, File foto, BuildContext ctx) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userName = '';
  var _emailId = '';
  var _passWord = '';
  File _imagePicked;

  void imagePickedByUser(File image) {
    _imagePicked = image;
  }

  void _tosubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_imagePicked == null && !_isLogin) {
      print(_imagePicked);
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please Pick an Image'),
        backgroundColor: Theme.of(context).errorColor,
      ));
      return;
    }

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(_emailId.trim(), _passWord.trim(), _userName.trim(),
          _isLogin, _imagePicked, context);
    }
    print(_userName);
    print(_emailId);
    print(_passWord);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!_isLogin) UserImagepicker(imagePickedByUser),
                    TextFormField(
                      key: ValueKey('email'),
                      onSaved: (value) {
                        _emailId = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || !value.contains('@')) {
                          return 'Please enter a valid Email Address';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(labelText: 'Email Address'),
                    ),
                    if (!_isLogin)
                      TextFormField(
                        key: ValueKey('userName'),
                        onSaved: (value) {
                          _userName = value;
                        },
                        validator: (value) {
                          if (value.isEmpty || value.length < 4) {
                            return 'UserName length must be at least 4 characters long';
                          }
                          return null;
                        },
                        decoration: InputDecoration(labelText: 'User Name'),
                      ),
                    TextFormField(
                      key: ValueKey('password'),
                      onSaved: (value) {
                        _passWord = value;
                      },
                      validator: (value) {
                        if (value.isEmpty || value.length < 7) {
                          return 'Password must be atleast 7 characters long';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(labelText: 'Password'),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (widget.isLoading) CircularProgressIndicator(),
                    if (!widget.isLoading)
                      RaisedButton(
                        onPressed: _tosubmit,
                        child: Text(_isLogin ? 'Login' : 'Signup'),
                      ),
                    if (!widget.isLoading)
                      FlatButton(
                        onPressed: () {
                          setState(() {
                            _isLogin = !_isLogin;
                          });
                        },
                        child: Text(_isLogin
                            ? 'Create New Account'
                            : 'Already have an account'),
                        textColor: Theme.of(context).primaryColor,
                      )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}
