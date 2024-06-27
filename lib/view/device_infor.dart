import 'package:flutter/material.dart';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:flutter/services.dart';
import 'package:staras_checkin/constants/constant.dart';
import 'package:unique_identifier/unique_identifier.dart';

class DeviceInformation extends StatefulWidget {
  const DeviceInformation({super.key});

  @override
  State<DeviceInformation> createState() => _DeviceInformationState();
}

class _DeviceInformationState extends State<DeviceInformation> {
  final deviceInfoPlugin = DeviceInfoPlugin();

  String _identifier = 'Unknown';

  @override
  void initState() {
    super.initState();
    initUniqueIdentifierState();
  }

  Future<void> initUniqueIdentifierState() async {
    String identifier;
    try {
      identifier = (await UniqueIdentifier.serial)!;
    } on PlatformException {
      identifier = 'Failed to get Unique Identifier';
    }

    if (!mounted) return;

    setState(() {
      _identifier = identifier;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Device Info",
          style: kTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20, color: kDarkWhite),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: Platform.isAndroid
          ? showDeviceInfoCard(showAndroidInfo())
          : Platform.isIOS
              ? showDeviceInfoCard(showIOSInfo())
              : Container(),
    );
  }

  Widget showDeviceInfoCard(Widget infoWidget) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: infoWidget,
      ),
    );
  }

  Widget showAndroidInfo() {
    return FutureBuilder(
      future: deviceInfoPlugin.androidInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          AndroidDeviceInfo info = snapshot.data!;
          return Column(
            children: [
              // Text('Identifier IMEI: $_identifier',
              //     style: kTextStyle.copyWith(fontSize: 16)),
              item('AndroidId', info.id),
              item('Android Model', info.model),
              item('Android Brand', info.brand),
              item('Android Device', info.device),
              item('Android Hardware', info.hardware),
              item('Android SDK Int', info.version.sdkInt.toString()),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget showIOSInfo() {
    return FutureBuilder(
      future: deviceInfoPlugin.iosInfo,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        } else if (snapshot.hasData) {
          IosDeviceInfo info = snapshot.data!;
          return Column(
            children: [
              item('Device Model', info.model),
              item('Device Name', info.name),
              item('System Name', info.systemName),
              item('System Version', info.systemVersion),
              item(
                'Device Is Physical',
                info.isPhysicalDevice.toString(),
              ),
            ],
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget item(String name, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SelectableText(
              name,
              style: kTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            SelectableText(
              value,
              style: kTextStyle.copyWith(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
