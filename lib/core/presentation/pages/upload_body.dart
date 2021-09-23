import 'dart:io';

import 'package:epicture/core/data/sources/imgur_data_source.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadBody extends StatefulWidget {
  const UploadBody({Key? key}) : super(key: key);

  @override
  _UploadBodyState createState() => _UploadBodyState();
}

class _UploadBodyState extends State<UploadBody> {
  final _picker = ImagePicker();
  File? previewImage;

  @override
  Widget build(BuildContext context) {
    return previewImage == null
        ? Center(
            child: Column(
              children: [
                const Spacer(flex: 2),
                IconButton(
                  onPressed: () async {
                    final xFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                    if (xFile != null) {
                      setState(() {
                        previewImage = File(xFile.path);
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
                    final xFile =
                        await _picker.pickImage(source: ImageSource.camera);
                    if (xFile != null) {
                      setState(() {
                        previewImage = File(xFile.path);
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
          )
        : ImagePreview(previewImage: previewImage!);
  }
}

class ImagePreview extends StatefulWidget {
  const ImagePreview({
    Key? key,
    required this.previewImage,
  }) : super(key: key);

  final File previewImage;

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  String? imageTitle;
  String? imageDescription;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.file(
            widget.previewImage,
            width: 300,
            height: 300,
            fit: BoxFit.fill,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              IconButton(
                onPressed: () async {},
                icon: const Icon(
                  Icons.delete,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
              const Spacer(),
              IconButton(
                onPressed: () async {
                  ImgurDataSource.uploadImage(context, imageTitle,
                      imageDescription, widget.previewImage);
                },
                icon: const Icon(
                  Icons.upload,
                  color: Colors.grey,
                  size: 40,
                ),
              ),
              const Spacer(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (String input) {
                imageTitle = input;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image title',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onSubmitted: (String input) {
                imageDescription = input;
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Image description',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
