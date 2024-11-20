import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:intl/intl.dart';

class Reqpage extends StatefulWidget {
  const Reqpage({super.key});

  @override
  _ReqpageState createState() => _ReqpageState();
}

class _ReqpageState extends State<Reqpage> {
  File? _profileImage;
  File? _idFrontImage;
  File? _idBackImage;
  bool _isEditing = true;

  final _emailController = TextEditingController();
  // final _certificationController = TextEditingController();
  final _idNumberController = TextEditingController();

  String? _selectedGender;
  DateTime? _selectedBirthdate;
  String? _selectedIDType;

  Future<void> _pickImage(Function(File?) onImagePicked,
      {bool fromCamera = false}) async {
    final pickedImage = await ImagePicker().pickImage(
      source: fromCamera ? ImageSource.camera : ImageSource.gallery,
    );
    if (pickedImage != null) {
      setState(() {
        onImagePicked(File(pickedImage.path));
      });
      // Automatically populate ID field upon successful picture
      if (onImagePicked == (file) => _idFrontImage = file) {
        _idNumberController.text =
            "Auto-generated ID number"; // Placeholder logic
      }
    }
  }

  Future<void> _pickBirthdate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _selectedBirthdate = pickedDate;
      });
    }
  }

  void _saveProfile() {
    setState(() {
      _isEditing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check, color: Colors.white),
            SizedBox(width: 8),
            Text("Updated successfully"),
          ],
        ),
        backgroundColor: Colors.deepPurple,
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Information',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        backgroundColor: Colors.deepPurple,
        actions: [
          TextButton(
            onPressed: _saveProfile,
            child: const Text(
              'Confirm',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 55,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage('assets/images/default_user.png')
                          as ImageProvider,
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => _pickImage((file) => _profileImage = file),
                    child: const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.deepPurple,
                      child: Icon(Icons.edit, color: Colors.white, size: 18),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            _buildProfileField(
              label: 'Email',
              controller: _emailController,
              enabled: _isEditing,
            ),
            const SizedBox(height: 20),
            _buildGenderField(),
            const SizedBox(height: 20),
            _buildBirthdateField(),
            const SizedBox(height: 20),
            _buildIDTypeField(),
            const SizedBox(height: 20),
            _buildIDNumberField(), // ID number field
            const SizedBox(height: 20),
            _buildIDUploadSection(),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderField() {
    return DropdownButtonFormField<String>(
      value: _selectedGender,
      items: ['Male', 'Female', 'Prefer not to say']
          .map((gender) => DropdownMenuItem(value: gender, child: Text(gender)))
          .toList(),
      onChanged: _isEditing
          ? (value) => setState(() => _selectedGender = value)
          : null,
      decoration: InputDecoration(
        labelText: 'Gender',
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildBirthdateField() {
    return GestureDetector(
      onTap: _isEditing ? _pickBirthdate : null,
      child: AbsorbPointer(
        child: TextFormField(
          controller: TextEditingController(
            text: _selectedBirthdate != null
                ? DateFormat('MMMM dd, yyyy').format(_selectedBirthdate!)
                : '',
          ),
          decoration: InputDecoration(
            labelText: 'Birthdate',
            labelStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            suffixIcon: const Icon(Icons.calendar_today, color: Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildIDTypeField() {
    return DropdownButtonFormField<String>(
      value: _selectedIDType,
      items: [
        'National ID',
        'Driver\'s License',
        'Passport',
        'SSS ID',
        'PhilHealth ID',
        'Postal ID',
        'Voter\'s ID'
      ]
          .map((idType) => DropdownMenuItem(value: idType, child: Text(idType)))
          .toList(),
      onChanged: _isEditing
          ? (value) => setState(() => _selectedIDType = value)
          : null,
      decoration: InputDecoration(
        labelText: 'Valid ID',
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildIDNumberField() {
    return TextFormField(
      controller: _idNumberController,
      enabled: _isEditing,
      decoration: InputDecoration(
        labelText: 'ID Number',
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  Widget _buildIDUploadSection() {
    return Column(
      children: [
        const Text('Upload ID',
            style: TextStyle(fontSize: 16, fontFamily: 'Poppins')),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildIDImageSection(
              label: 'Front',
              image: _idFrontImage,
              onTap: () =>
                  _pickImage((file) => _idFrontImage = file, fromCamera: true),
            ),
            _buildIDImageSection(
              label: 'Back',
              image: _idBackImage,
              onTap: () =>
                  _pickImage((file) => _idBackImage = file, fromCamera: true),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIDImageSection({
    required String label,
    required File? image,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 100,
            width: 150,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
              image: image != null
                  ? DecorationImage(
                      image: FileImage(image),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: image == null
                ? const Center(
                    child: Icon(Icons.camera_alt, color: Colors.grey))
                : null,
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(fontFamily: 'Poppins')),
        ],
      ),
    );
  }

  Widget _buildProfileField({
    required String label,
    required TextEditingController controller,
    bool enabled = false,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      maxLines: maxLines,
      style: const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
