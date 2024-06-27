// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:staras_checkin/constants/constant.dart';
import 'package:staras_checkin/models/store.info.response.model.dart';
import 'package:staras_checkin/view/employee_in_store.dart';

class StoreInfoResponsePage extends StatefulWidget {
  final StoreInfoResponseModel storeInfoResponse;
  const StoreInfoResponsePage({Key? key, required this.storeInfoResponse})
      : super(key: key);

  @override
  _StoreInfoResponsePageState createState() => _StoreInfoResponsePageState();
}

class _StoreInfoResponsePageState extends State<StoreInfoResponsePage> {
  StoreResponseModel? storeInfo;
  @override
  void initState() {
    super.initState();
    storeInfo = widget.storeInfoResponse.storeResponseModel;
  }

  @override
  Widget build(BuildContext context) {
    StoreResponseModel? storeInfo = widget.storeInfoResponse.storeResponseModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Text(
            'Store Info Response',
            maxLines: 2,
            style: kTextStyle.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20.0,
            ),
            Container(
              width: context.width(),
              height: context.height(),
              padding: const EdgeInsets.all(20.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigate to EmployeeInStorePage
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmployeeInStorePage(
                              storeInfoResponse: widget.storeInfoResponse,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 120),
                        child: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: const Icon(
                                    Icons.store_rounded,
                                    color: kMainColor,
                                  ),
                                  title: Text(
                                    storeInfo?.storeName ?? "",
                                    style: kTextStyle.copyWith(
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    storeInfo?.active == true
                                        ? 'Active'
                                        : 'Not Active',
                                    style: kTextStyle.copyWith(
                                      color: storeInfo?.active == true
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: kBorderColorTextField.withOpacity(0.2),
                                  thickness: 1,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Open time:     ${storeInfo?.openTime ?? ""}',
                                  style: kTextStyle.copyWith(
                                      color: kGreyTextColor),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Close time:     ${storeInfo?.closeTime ?? ""}',
                                  style: kTextStyle.copyWith(
                                      color: kGreyTextColor),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Create date: ${DateFormat('dd-MM-yyyy').format(storeInfo?.createDate ?? DateTime.now())}',
                                  style: kTextStyle.copyWith(
                                      color: kGreyTextColor),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  'Address:         ${storeInfo?.address ?? ""}',
                                  maxLines: 5,
                                  style: kTextStyle.copyWith(
                                      color: kGreyTextColor),
                                ),
                                const SizedBox(
                                  height: 2.0,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
