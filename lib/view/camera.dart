// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:face_camera/face_camera.dart';
import 'package:staras_checkin/common/toast.dart';
import 'package:staras_checkin/models/store.info.response.model.dart';
import 'package:staras_checkin/view/employee_in_store.dart';

class CameraView extends StatefulWidget {
  final String? employeeCode;
  final String? employeeName;
  final int? employeeShiftHistoryId;
  final bool isCheckIn;
  final StoreInfoResponseModel? storeInfoResponse;

  const CameraView({
    Key? key,
    this.employeeCode,
    this.employeeName,
    this.employeeShiftHistoryId,
    required this.isCheckIn,
    this.storeInfoResponse,
  }) : super(key: key);

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  File? _capturedImage;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final deviceInfoPlugin = DeviceInfoPlugin();
  bool showCaptureAgainButton = false;

  String deviceId = "Not Found";

  @override
  void initState() {
    super.initState();
    _initControllers();
    _getDeviceInfo();
  }

  Future<void> _getDeviceInfo() async {
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
        deviceId = info.id;
      } else if (Platform.isIOS) {
        IosDeviceInfo info = await deviceInfoPlugin.iosInfo;
        deviceId = info.identifierForVendor!;
      }
    } catch (e) {
      print('Error getting device info: $e');
    }
  }

  Future<void> checkIn() async {
    onLoading(context);
    var apiUrl = 'http://159.223.36.82:2500/check-in';

    // Request body
    final Map<String, dynamic> requestBody = {
      "Code": widget.employeeCode!,
      "EmployeeShiftHistoryId": widget.employeeShiftHistoryId!,
      "MachineCode": deviceId,
    };

    print('RequestBody: ${requestBody}');

    try {
      // Making the API POST request
      final http.Response response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      Navigator.pop(context);

      if (response.statusCode == 201) {
        print('Data Check In Response : ${response.body}');

        showToast(
          context: context,
          msg: response.body,
          color: Color.fromARGB(255, 128, 249, 16),
          icon: const Icon(Icons.done),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeInStorePage(
              storeInfoResponse: widget.storeInfoResponse,
            ),
          ),
          (route) => false, // This prevents going back to the CheckInPage
        );

        setState(() {
          showCaptureAgainButton = false;
        });

        print('Check In  Successful');
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        setState(() {
          showCaptureAgainButton = true;
        });
        print('Error: ${response.statusCode} - ${response.body}');

        showToast(
          context: context,
          msg: response.body,
          color: Colors.red,
          icon: const Icon(Icons.error),
        );
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
    }
  }

  Future<void> checkOut() async {
    onLoading(context);
    var apiUrl = 'http://159.223.36.82:2500/check-out';

    // Request body
    final Map<String, dynamic> requestBody = {
      "Code": widget.employeeCode!,
      "EmployeeShiftHistoryId": widget.employeeShiftHistoryId!,
      "MachineCode": deviceId,
    };

    print('RequestBody: ${requestBody}');

    try {
      // Making the API POST request
      final http.Response response = await http.put(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      Navigator.pop(context);
      if (response.statusCode == 200) {
        print('Data response : ${response.body}');

        setState(() {
          showCaptureAgainButton = false;
        });

        showToast(
          context: context,
          msg: response.body,
          color: Color.fromARGB(255, 128, 249, 16),
          icon: const Icon(Icons.done),
        );

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => EmployeeInStorePage(
              storeInfoResponse: widget.storeInfoResponse,
            ),
          ),
          (route) => false,
        );

        print('Check Out Success');
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        setState(() {
          showCaptureAgainButton = true;
        });

        print('Error: ${response.statusCode} - ${response.body}');

        showToast(
          context: context,
          msg: response.body,
          color: Colors.red,
          icon: const Icon(Icons.error),
        );
      } else {
        print('Error: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      // Handle exceptions
      print('Error: $error');
    }
  }

  Future<void> _initControllers() async {
    print('Device ID: $deviceId');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Builder(builder: (context) {
        if (_capturedImage != null) {
          return Center(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.file(
                  _capturedImage!,
                  width: double.maxFinite,
                  fit: BoxFit.fitWidth,
                ),
                if (showCaptureAgainButton)
                  ElevatedButton(
                    onPressed: () => setState(() => _capturedImage = null),
                    child: const Text(
                      'Capture Again',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
                    ),
                  ),
              ],
            ),
          );
        }
        return SmartFaceCamera(
            autoCapture: true,
            defaultCameraLens: CameraLens.front,
            showCameraLensControl: false,
            showControls: false,
            showFlashControl: false,
            imageResolution: ImageResolution.high,
            indicatorShape: IndicatorShape.square,
            onCapture: (File? image) {
              setState(() => _capturedImage = image);
              if (_capturedImage != null) {
                uploadImageToFirebase(_capturedImage!);
              }
            },
            onFaceDetected: (Face? face) {
              //Do something
            },
            messageBuilder: (context, face) {
              if (face == null) {
                return _message(
                  'Place your face in the camera',
                );
              }
              if (!face.wellPositioned) {
                return _message('Center your face in the square');
              }
              return const SizedBox.shrink();
            });
      })),
    );
  }

  void uploadImageToFirebase(File imageFile) async {
    try {
      String? employeeCode = widget.employeeCode;
      String? employeeName = widget.employeeName;
      int? employeeShiftHistoryId = widget.employeeShiftHistoryId;

      if (employeeCode != null &&
          employeeName != null &&
          employeeShiftHistoryId != null) {
        String filePath = 'TempUploadImages/$employeeCode/$employeeName.jpg';
        Reference storageReference = _storage.ref().child(filePath);
        UploadTask uploadTask = storageReference.putFile(imageFile);

        TaskSnapshot snapshot = await uploadTask.whenComplete(() {});
        String downloadURL = await snapshot.ref.getDownloadURL();

        print('Download URL: $downloadURL');
        if (widget.isCheckIn) {
          checkIn();
        } else {
          checkOut();
        }
      } else {
        print('Error: One or more required values are null.');
      }
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  Widget _message(String msg) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 55, vertical: 15),
        child: Text(msg,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 14, height: 1.5, fontWeight: FontWeight.w400)),
      );
}
