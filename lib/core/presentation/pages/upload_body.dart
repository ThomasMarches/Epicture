import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadBody extends StatefulWidget {
  const UploadBody({Key? key}) : super(key: key);

  @override
  _UploadBodyState createState() => _UploadBodyState();
}

class _UploadBodyState extends State<UploadBody> {
  final _picker = ImagePicker();
  Image? previewImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Spacer(flex: 2),
          IconButton(
            onPressed: () async {
              final xFile =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (xFile != null) {
                setState(() {
                  previewImage = Image.file(File(xFile.path));
                });
              }
            },
            icon: const Icon(
              Icons.image,
              color: Colors.black,
              size: 40,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Press this button to search a picture from your gallery.',
            ),
          ),
          const Spacer(flex: 1),
          IconButton(
            onPressed: () async {
              final xFile = await _picker.pickImage(source: ImageSource.camera);
              if (xFile != null) {
                setState(() {
                  previewImage = Image.file(File(xFile.path));
                });
              }
            },
            icon: const Icon(
              Icons.add_a_photo_outlined,
              color: Colors.black,
              size: 40,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Press this button to take a picture with your phone.',
            ),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
