import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staras_checkin/constants/constant.dart';

class SupportProblemScreen extends StatefulWidget {
  const SupportProblemScreen({Key? key}) : super(key: key);

  @override
  State<SupportProblemScreen> createState() => _SupportProblemScreenState();
}

class _SupportProblemScreenState extends State<SupportProblemScreen> {
  TextEditingController _problemController = TextEditingController();
  List<File> selectedImages = [];

  Future<File?> _captureImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<List<File>> _pickImages() async {
    final picker = ImagePicker();
    List<XFile>? images = await picker.pickMultiImage();
    if (images != null) {
      return images.map((image) => File(image.path)).toList();
    }
    return [];
  }

  void _showImageDialog(File image) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                Container(
                  padding: EdgeInsets.all(16),
                  child: Image.file(image),
                ),
                Padding(
                  padding: EdgeInsets.all(15),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 30,
                      weight: 30.0,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Support Problem Screen",
          style: kTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: kDarkWhite,
          ),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Describe the Problem:',
              style: kTextStyle.copyWith(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                controller: _problemController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Type your problem here...',
                  hintStyle: kTextStyle.copyWith(fontSize: 15),
                  border: InputBorder.none,
                ),
                style: TextStyle(fontSize: 16),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    File? image = await _captureImage();
                    if (image != null) {
                      setState(() {
                        selectedImages.add(image);
                      });
                    }
                    print('Capture Image');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: kMainColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  icon: Icon(Icons.camera_alt),
                  label: Text(
                    'Capture Image',
                    style: kTextStyle.copyWith(fontSize: 12, color: kDarkWhite),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    List<File> images = await _pickImages();
                    if (images.isNotEmpty) {
                      setState(() {
                        selectedImages.addAll(images);
                      });
                    }
                    print('Choose Image');
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: kMainColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 5,
                  ),
                  icon: Icon(Icons.image),
                  label: Text(
                    'Choose Image',
                    style: kTextStyle.copyWith(fontSize: 12, color: kDarkWhite),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (selectedImages.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Text(
                    'Selected Images:',
                    style: kTextStyle.copyWith(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 200, // Adjust the height as needed
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: selectedImages.length,
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showImageDialog(selectedImages[index]);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.file(
                                    selectedImages[index],
                                    height: 200,
                                    width: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    size: 25,
                                    weight: 30.0,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      selectedImages.removeAt(index);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton.icon(
            onPressed: () {
              // Process or send the problem description
              String problemDescription = _problemController.text;
              // Add your logic here
              print('Problem Description: $problemDescription');
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: kMainColor, // Text color
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 5,
            ),
            icon: Icon(Icons.cloud_upload_outlined), // Icon on the left
            label: Text(
              'Submit',
              style: kTextStyle.copyWith(
                fontSize: 14,
                color: kDarkWhite,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _problemController.dispose();
    super.dispose();
  }
}
