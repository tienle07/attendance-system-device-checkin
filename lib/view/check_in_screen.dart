// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:staras_checkin/constants/constant.dart';
import 'package:staras_checkin/models/store.info.response.model.dart';
import 'package:staras_checkin/models/time.decision.model.dart';
import 'package:staras_checkin/view/camera.dart';
import 'package:one_clock/one_clock.dart';

class CheckInPage extends StatefulWidget {
  final bool isCheckIn;
  final String? employeeCode;
  final int? employeeShiftHistoryId;
  final String? employeeName;
  final StoreInfoResponseModel? storeInfoResponse;
  final TimeDecisionModel? timeDecision;
  const CheckInPage({
    Key? key,
    required this.isCheckIn,
    this.employeeCode,
    this.employeeShiftHistoryId,
    this.employeeName,
    this.storeInfoResponse,
    this.timeDecision,
  }) : super(key: key);

  @override
  _CheckInPageState createState() => _CheckInPageState();
}

class _CheckInPageState extends State<CheckInPage> {
  DateTime dateTime = DateTime.now();
  // bool isOffice = true;
  late bool _isCheckIn;

  @override
  void initState() {
    super.initState();
    _isCheckIn = widget.isCheckIn; // Initialize the mutable variable
  }

  void navigateToCameraView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CameraView(
          storeInfoResponse: widget.storeInfoResponse,
          isCheckIn: widget.isCheckIn,
          employeeCode: widget.employeeCode!,
          employeeShiftHistoryId: widget.employeeShiftHistoryId!,
          employeeName: widget.employeeName!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Check Attendance',
          maxLines: 2,
          style: kTextStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Colors.white.withOpacity(0.1),
              ),
              child: const Icon(
                Icons.history,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Container(
              width: context.width(),
              height: 760,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
                color: kBgColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Widget for location and check button
                  Container(
                    width: context.width(),
                    padding: const EdgeInsets.all(14.0),
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Text(
                              'Please, Click',
                              style: kTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 4.0),
                            Text(
                              ' button Check to start',
                              style: kTextStyle.copyWith(
                                color: kGreyTextColor,
                              ),
                            ),
                            const Spacer(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Choose attendance mode
                  Container(
                    width: context.width(),
                    padding: const EdgeInsets.all(30.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Choose your Attendance mode',
                          style:
                              kTextStyle.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          padding: const EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            color: kMainColor,
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: _isCheckIn ? Colors.white : kMainColor,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: kMainColor,
                                      child: Icon(
                                        Icons.check,
                                        color: _isCheckIn
                                            ? Colors.white
                                            : kMainColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      'Check In',
                                      style: kTextStyle.copyWith(
                                        color: _isCheckIn
                                            ? kTitleColor
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12.0,
                                    ),
                                  ],
                                ),
                              ).onTap(() {
                                setState(() {});
                              }),
                              Container(
                                padding: const EdgeInsets.all(4.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  color:
                                      !_isCheckIn ? Colors.white : kMainColor,
                                ),
                                child: Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: kMainColor,
                                      child: Icon(
                                        Icons.check,
                                        color: !_isCheckIn
                                            ? Colors.white
                                            : kMainColor,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4.0,
                                    ),
                                    Text(
                                      'Check Out ',
                                      style: kTextStyle.copyWith(
                                        color: !_isCheckIn
                                            ? kTitleColor
                                            : Colors.white,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 12.0,
                                    ),
                                  ],
                                ),
                              ).onTap(() {
                                setState(() {});
                              }),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30.0,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          DateFormat.yMMMMEEEEd().format(DateTime.now()),
                          style: kTextStyle.copyWith(color: kGreyTextColor),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        DigitalClock.light(
                          isLive: true,
                          datetime: dateTime,
                          textScaleFactor: 1.3,
                        ),
                        const SizedBox(
                          height: 15.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            navigateToCameraView();
                          },
                          child: Container(
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100.0),
                              color: _isCheckIn
                                  ? kGreenColor.withOpacity(0.1)
                                  : kAlertColor.withOpacity(0.1),
                            ),
                            child: CircleAvatar(
                              radius: 80.0,
                              backgroundColor:
                                  _isCheckIn ? kGreenColor : kAlertColor,
                              child: Text(
                                _isCheckIn ? 'Check In' : 'Check Out',
                                style: kTextStyle.copyWith(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 35.0),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(Icons.access_alarm_outlined),
                                Icon(Icons.access_alarm_outlined),
                                Icon(Icons.access_time),
                              ],
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            // Hàng 1: Chứa ba trường "Check In", "Check Out", "Total Time"
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Trường "Check In"
                                Column(
                                  children: [
                                    Text(
                                      'Check In',
                                      style: kTextStyle.copyWith(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // Trường "Check Out"
                                Column(
                                  children: [
                                    Text(
                                      'Check Out',
                                      style: kTextStyle.copyWith(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                // Trường "Total Time"
                                Column(
                                  children: [
                                    Text(
                                      'Total Time',
                                      style: kTextStyle.copyWith(
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Giá trị cho trường "Check In"
                                Column(
                                  children: [
                                    Text(
                                      widget.timeDecision?.checkIn != null
                                          ? DateFormat('hh:mm a').format(
                                              widget.timeDecision!.checkIn!)
                                          : 'Not Yet',
                                      style:
                                          kTextStyle.copyWith(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                                // Giá trị cho trường "Check Out"
                                Column(
                                  children: [
                                    Text(
                                      widget.timeDecision?.checkOut != null
                                          ? DateFormat('hh:mm a').format(
                                              widget.timeDecision!.checkOut!)
                                          : 'Not Yet',
                                      style:
                                          kTextStyle.copyWith(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                                // Giá trị cho trường "Total Time"
                                Column(
                                  children: [
                                    Text(
                                      widget.timeDecision?.totalWorkTime ??
                                          'Not Yet',
                                      style:
                                          kTextStyle.copyWith(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
