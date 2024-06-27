import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:staras_checkin/constants/constant.dart';

class StoreInformationScreen extends StatefulWidget {
  const StoreInformationScreen({Key? key}) : super(key: key);

  @override
  State<StoreInformationScreen> createState() => _StoreInformationScreenState();
}

class _StoreInformationScreenState extends State<StoreInformationScreen> {
  Future<String?> getWifiBSSID() async {
    NetworkInfo networkInfo = NetworkInfo();
    try {
      return await networkInfo.getWifiBSSID();
    } catch (e) {
      return 'Not Found';
    }
  }

  Future<Position?> getCurrentLocation() async {
    try {
      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Config Information",
          style: kTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20, color: kDarkWhite),
        ),
        centerTitle: true,
        backgroundColor: kMainColor,
      ),
      body: FutureBuilder<String?>(
        future: getWifiBSSID(),
        builder: (context, wifiSnapshot) {
          return FutureBuilder<Position?>(
            future: getCurrentLocation(),
            builder: (context, locationSnapshot) {
              if (wifiSnapshot.connectionState == ConnectionState.waiting ||
                  locationSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                String wifiBSSID = wifiSnapshot.data ?? 'Not Found';
                double latitude = locationSnapshot.data?.latitude ?? 0.0;
                double longitude = locationSnapshot.data?.longitude ?? 0.0;

                return Center(
                  child: Card(
                    elevation: 5,
                    margin: EdgeInsets.all(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SelectableText(
                            'Wi-Fi BSSID: ',
                            style: kTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          SelectableText(
                            wifiBSSID,
                            style: kTextStyle.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          SelectableText(
                            'Address Info: ',
                            style: kTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 8),
                          SelectableText(
                            'Latitude: ${latitude.toStringAsFixed(6)}',
                            style: kTextStyle.copyWith(fontSize: 16),
                          ),
                          SizedBox(height: 8),
                          SelectableText(
                            'Longitude: ${longitude.toStringAsFixed(6)}',
                            style: kTextStyle.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
