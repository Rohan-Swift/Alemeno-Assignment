import 'dart:io';

import 'package:alemeno_task/final_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:camera/camera.dart';

class Click extends StatefulWidget {
  const Click({Key? key}) : super(key: key);

  @override
  State<Click> createState() => _ClickState();
}

class _ClickState extends State<Click> {
  late CameraController _cameraController;
  XFile? _capturedImage; // Store the captured image file
  bool _showPreview = true; // Control whether to show the camera preview
  String _currentIcon = "assets/camerabutton.png";
  String text = "Click your meal";

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    _cameraController = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );
    await _cameraController.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Image.asset(
                "assets/backarrow.png",
              ),
            ],
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(width: 300, child: Image.asset("assets/animal.png")),
          Container(
            width: double.infinity,
            height: 394,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                color: Colors.grey[200]),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 50,
                    ),
                    Image.asset(
                      "assets/fork.png",
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Stack(
                      children: [
                        Image.asset(
                          "assets/corners.png",
                        ),
                        Positioned(
                          top: 10,
                          left: 20,
                          child: Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.transparent,
                                width: 2.0,
                              ),
                            ),
                            child: Center(
                              child: _showPreview
                                  ? ClipOval(
                                      child: AspectRatio(
                                        aspectRatio:
                                            _cameraController.value.aspectRatio,
                                        child: CameraPreview(_cameraController),
                                      ),
                                    )
                                  : _capturedImage != null
                                      ? ClipOval(
                                          child: Image.file(
                                            File(_capturedImage!.path),
                                            fit: BoxFit.cover,
                                            width: 300,
                                            height: double.infinity,
                                          ),
                                        )
                                      : Container(),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Image.asset(
                      "assets/spoon.png",
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  text,
                  style: GoogleFonts.andika(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    if (_currentIcon == "assets/yes.png") {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FinalPage(),
                      ));
                    } else {
                      setState(() {
                        _takePhoto();
                        _currentIcon = "assets/yes.png";
                        text = "Will you eat this?";
                      });
                    }
                  },
                  child: Image.asset(_currentIcon),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _takePhoto() async {
    if (!_cameraController.value.isInitialized) {
      return;
    }

    try {
      final XFile imageFile = await _cameraController.takePicture();
      // Update the captured image and hide the camera preview
      setState(() {
        _capturedImage = imageFile;
        _showPreview = false;
      });

      // Now you have the captured image in 'imageFile', you can use it as needed
      if (kDebugMode) {
        print('Image captured at ${imageFile.path}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error taking picture: $e');
      }
    }
  }
}
