import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class UploadBody extends StatefulWidget {
  const UploadBody({Key? key}) : super(key: key);

  static const routeName = '/uploadpage';

  @override
  _UploadBodyState createState() => _UploadBodyState();
}

class _UploadBodyState extends State<UploadBody> {
  List<CameraDescription> cameras = [];
  late CameraController _controller; //To control the camera
  bool isReady = false;
  late Future<void>
      _initializeControllerFuture; //Future to wait until camera initializes
  int selectedCamera = 0;
  List<File> capturedImages = [];

  @override
  void initState() {
    super.initState();
    _setupCamera();
  }

  Future<void> _setupCamera() async {
    try {
      cameras = await availableCameras();
      initializeCamera(selectedCamera); //Initially selectedCamera = 0
    } on CameraException catch (_) {
      debugPrint("Some error occured on _setupCamra() !");
    }

    if (!mounted) {
      return;
    }

    setState(() {
      isReady = true;
    });
  }

  dynamic initializeCamera(int cameraIndex) async {
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      cameras[cameraIndex],
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    if (cameras.length > 1) {
                      setState(() {
                        selectedCamera = selectedCamera == 0 ? 1 : 0;
                        initializeCamera(selectedCamera);
                      });
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('No secondary camera found'),
                        duration: Duration(seconds: 2),
                      ));
                    }
                  },
                  icon: const Icon(
                    Icons.switch_camera_rounded,
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    await _initializeControllerFuture;
                    var xFile = await _controller.takePicture();
                    setState(() {
                      capturedImages.add(File(xFile.path));
                    });
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
