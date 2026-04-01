import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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

  @override
  void initState() {
    super.initState();
    if (widget.cameras.isEmpty) return;

    _controller = CameraController(widget.cameras.first, ResolutionPreset.high);
    _controller.setFlashMode(.off);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() async {
    super.dispose();

    if (widget.cameras.isEmpty) return;
    await _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
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
    );
  }
}
