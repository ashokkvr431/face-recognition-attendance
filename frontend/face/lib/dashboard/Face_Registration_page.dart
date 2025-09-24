import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FaceRegistrationPage extends StatefulWidget {
  const FaceRegistrationPage({super.key});

  @override
  State<FaceRegistrationPage> createState() => _FaceRegistrationPageState();
}

class _FaceRegistrationPageState extends State<FaceRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _studentNoController = TextEditingController();

  File? _capturedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
    if (photo != null) {
      setState(() {
        _capturedImage = File(photo.path);
      });
    }
  }

  void _registerFace() async {
    if (_formKey.currentState!.validate() && _capturedImage != null) {
      // TODO: send name, studentNo, and image to backend via API
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Face registered successfully!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter details and capture face")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Face Registration")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Full Name"),
                validator: (value) =>
                    value!.isEmpty ? "Enter student name" : null,
              ),
              TextFormField(
                controller: _studentNoController,
                decoration: const InputDecoration(labelText: "Student Number"),
                validator: (value) =>
                    value!.isEmpty ? "Enter student number" : null,
              ),
              const SizedBox(height: 20),
              _capturedImage != null
                  ? Image.file(_capturedImage!, height: 200, fit: BoxFit.cover)
                  : Container(
                      height: 200,
                      color: Colors.grey[300],
                      child: const Center(child: Text("No Image Captured")),
                    ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture Face"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerFace,
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
