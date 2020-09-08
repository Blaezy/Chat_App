import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagepicker extends StatefulWidget {
  final void Function(File pickedimage) imagePickerForUser;
  UserImagepicker(this.imagePickerForUser);
  @override
  _UserImagepickerState createState() => _UserImagepickerState();
}

class _UserImagepickerState extends State<UserImagepicker> {
  File pickedImage;
  void imagePicker() async {
    final _picker = ImagePicker();
    final imagefile = await _picker.getImage(
        source: ImageSource.camera, imageQuality: 50, maxWidth: 120);
    setState(() {
      pickedImage = File(imagefile.path);
    });
    widget.imagePickerForUser(File(imagefile.path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: pickedImage == null ? null : FileImage(pickedImage),
        ),
        FlatButton.icon(
          onPressed: imagePicker,
          icon: Icon(Icons.image),
          label: Text('Add Photo'),
          textColor: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
