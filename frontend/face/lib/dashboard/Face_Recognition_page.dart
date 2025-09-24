import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FaceRecognitionPage extends StatefulWidget {
  const FaceRecognitionPage({super.key});

  @override
  State<FaceRecognitionPage> createState() => _FaceRecognitionPageState();
}

class _FaceRecognitionPageState extends State<FaceRecognitionPage> {
  File? _capturedImage;
  bool isScanning = false;
  bool? isMatched;

  final ImagePicker _picker = ImagePicker();

  Future<void> _scanFace() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _capturedImage = File(photo.path);
        isScanning = true;
        isMatched = null;
      });

      // TODO: send image to backend for recognition
      await Future.delayed(const Duration(seconds: 2));

      // Fake match result
      bool matched = DateTime.now().second % 2 == 0;

      setState(() {
        isScanning = false;
        isMatched = matched;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Face Recognition")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _capturedImage != null
                ? Image.file(_capturedImage!, height: 250, fit: BoxFit.cover)
                : Container(
                    height: 250,
                    color: Colors.grey[300],
                    child: const Center(child: Text("No Face Captured")),
                  ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: isScanning ? null : _scanFace,
              icon: const Icon(Icons.camera_alt),
              label: Text(isScanning ? "Scanning..." : "Scan Face"),
            ),
            const SizedBox(height: 20),
            if (isMatched != null)
              Text(
                isMatched!
                    ? "✅ Face Matched - Attendance Marked"
                    : "❌ Face Not Recognized",
                style: TextStyle(
                  fontSize: 18,
                  color: isMatched! ? Colors.green : Colors.red,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
