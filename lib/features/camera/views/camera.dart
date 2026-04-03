import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum CameraType { video, photo }

class CameraView extends StatefulWidget {
  const CameraView({super.key, required this.type, required this.cameras});

  final CameraType type;
  final List<CameraDescription> cameras;

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int _selectedCameraIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isEmpty) return;
    _initCamera(_selectedCameraIndex);
  }

  void _initCamera(int index) {
    _controller = CameraController(
      widget.cameras[index],
      ResolutionPreset.high,
    );
    _initializeControllerFuture = _controller.initialize().then((_) {
      _controller.setFlashMode(FlashMode.off);
    });
  }

  void _flipCamera() async {
    if (widget.cameras.isEmpty || widget.cameras.length < 2) return;

    final oldController = _controller;
    _selectedCameraIndex = (_selectedCameraIndex + 1) % widget.cameras.length;
    _initCamera(_selectedCameraIndex);

    await oldController.dispose();
  }

  @override
  void dispose() {
    if (widget.cameras.isNotEmpty) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview.
            return Stack(
              fit: StackFit.expand,
              children: [
                CameraPreview(_controller),
                CameraActions(
                  controller: _controller,
                  onFlipCamera: _flipCamera,
                  onFlashToggled: () {},
                ),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

class CameraActions extends StatelessWidget {
  const CameraActions({
    super.key,
    required this.controller,
    required this.onFlipCamera,
    required this.onFlashToggled,
  });

  final CameraController controller;
  final VoidCallback onFlipCamera;
  final VoidCallback onFlashToggled;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: .bottomCenter,
        child: Padding(
          padding: .symmetric(horizontal: 20.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .center,
                  children: [
                    IconButton(
                      iconSize: 24,
                      icon: const Icon(Icons.close, color: Colors.white),
                      onPressed: () => Get.back(),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.black.withValues(alpha: 0.25),
                        ),
                      ),
                    ),

                    IconButton(
                      icon: Icon(
                        controller.value.flashMode == FlashMode.off
                            ? Icons.flash_off
                            : Icons.flash_on,
                        color: controller.value.flashMode == FlashMode.off
                            ? Colors.black
                            : Colors.white,
                        size: 24,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          controller.value.flashMode == FlashMode.off
                              ? Colors.white
                              : Colors.black.withValues(alpha: 0.5),
                        ),
                      ),
                      onPressed: () async {
                        if (controller.value.flashMode == FlashMode.off) {
                          await controller.setFlashMode(FlashMode.always);
                        } else {
                          await controller.setFlashMode(FlashMode.off);
                        }
                        onFlashToggled();
                      },
                    ),
                  ],
                ),
              ),

              GestureDetector(
                onTap: () async {
                  try {
                    final image = await controller.takePicture();
                    Get.back(result: image);
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: .circle,
                    border: .all(color: Colors.white, width: 4),
                  ),
                  child: Center(
                    child: Container(
                      width: 64,
                      height: 64,
                      decoration: const BoxDecoration(
                        shape: .circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.mic_off_rounded,
                        color: Colors.black,
                        size: 24,
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white),
                      ),
                      onPressed: () async {},
                    ),

                    IconButton(
                      iconSize: 24,
                      icon: const Icon(
                        Icons.flip_camera_android,
                        color: Colors.white,
                      ),
                      onPressed: onFlipCamera,
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.black.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
