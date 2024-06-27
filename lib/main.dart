import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:staras_checkin/controllers/location_controller.dart';
import 'dependency_injection.dart';
import 'package:face_camera/face_camera.dart';
import 'package:staras_checkin/view/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); //Add this
  DependencyInjection.init();
  await FaceCamera.initialize(); //Add this
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LocationController locationController = LocationController();

  try {
    await locationController.getCurrentLocation();
  } catch (e) {
    print("Error getting location: $e");
    // Handle the error as needed
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        pageTransitionsTheme: const PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
        }),
      ),
      title: 'STARAS',
      home: const SplashScreen(),
    );
  }
}
