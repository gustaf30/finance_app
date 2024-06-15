import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CameraScreen extends StatefulWidget {
  final ValueChanged<File> onCapture;

  const CameraScreen({Key? key, required this.onCapture}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // Inicializa a câmera
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.medium);
    _initializeControllerFuture = _controller.initialize();

    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera'),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera),
        backgroundColor: Colors.blue,
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            XFile file = await _controller.takePicture();
            if (file != null) {
              widget.onCapture(File(file.path));
              Navigator.pop(context); // Volta para a tela anterior após captura
            }
          } catch (e) {
            print('Erro ao capturar imagem: $e');
          }
        },
      ),
    );
  }
}
