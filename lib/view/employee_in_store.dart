// ignore_for_file: depend_on_referenced_packages, library_private_types_in_public_api, use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:http/http.dart' as http;
import 'package:staras_checkin/common/toast.dart';
import 'package:staras_checkin/constants/constant.dart';
import 'package:staras_checkin/models/store.info.response.model.dart';
import 'package:staras_checkin/models/time.decision.model.dart';
import 'package:staras_checkin/view/check_in_screen.dart';

class EmployeeInStorePage extends StatefulWidget {
  final StoreInfoResponseModel? storeInfoResponse;
  const EmployeeInStorePage({Key? key, this.storeInfoResponse})
      : super(key: key);

  @override
  _EmployeeInStorePageState createState() => _EmployeeInStorePageState();
}

class _EmployeeInStorePageState extends State<EmployeeInStorePage> {
  TextEditingController _searchController = TextEditingController();
  List<EmployeeInStoreResponseModel>? filteredEmployees;

  @override
  void initState() {
    super.initState();
    filteredEmployees = widget.storeInfoResponse?.employeeInStoreResponseModels;
  }

  void _filterEmployees(String searchText) {
    setState(() {
      if (searchText.isEmpty) {
        filteredEmployees =
            widget.storeInfoResponse?.employeeInStoreResponseModels;
      } else {
        filteredEmployees = widget
            .storeInfoResponse?.employeeInStoreResponseModels
            ?.where((employee) =>
                employee.employeeCode!
                    .toLowerCase()
                    .contains(searchText.toLowerCase()) ||
                employee.employeeName!
                    .toLowerCase()
                    .contains(searchText.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<EmployeeInStoreResponseModel>? employees =
        widget.storeInfoResponse?.employeeInStoreResponseModels;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: kMainColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        elevation: 0.0,
        titleSpacing: 0.0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Padding(
          padding: EdgeInsets.all(40),
          child: Text(
            'Employee',
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
            Container(
              width: context.width(),
              height: 1000,
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
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search Employees',
                          hintStyle: kTextStyle.copyWith(fontSize: 14),
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        onChanged: (text) {
                          _filterEmployees(text);
                        },
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    const SizedBox(height: 40.0),
                    employees != null && employees.isNotEmpty
                        ? ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: (filteredEmployees!.length / 3).ceil(),
                            itemBuilder: (context, rowIndex) {
                              final startIndex = rowIndex * 3;
                              return _buildEmployeeRow(
                                  filteredEmployees!, startIndex);
                            },
                          )
                        : Container(
                            alignment: Alignment.center,
                            child: Text(
                              'No Employees In Store',
                              style: kTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
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

  Widget _buildEmployeeRow(
    List<EmployeeInStoreResponseModel> employees,
    int startIndex,
  ) {
    return Column(
      children: [
        SizedBox(height: 20), // Khoảng trắng giữa các hàng
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            3,
            (index) {
              final employeeIndex = startIndex + index;
              if (employeeIndex < employees.length) {
                final employee = employees[employeeIndex];
                return Expanded(
                  child: _buildEmployeeCircle(employee),
                );
              } else {
                // Placeholder for empty space in the last row
                return SizedBox(
                    width: 100); // Điều chỉnh chiều rộng theo nhu cầu
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildEmployeeCircle(EmployeeInStoreResponseModel employee) {
    return GestureDetector(
      onTap: () {
        _fetchTimeDecision(employee);
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 45,
            backgroundImage: NetworkImage(employee.profileImage ?? ""),
          ),
          SizedBox(height: 8),
          Text(
            ' ${employee.employeeCode}',
            style: kTextStyle.copyWith(fontSize: 10.0),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _fetchTimeDecision(EmployeeInStoreResponseModel employee) async {
    final url =
        'http://159.223.36.82:2500/time-decision/${employee.employeeId}?storeId=${employee.storeId}';
    print(url);

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        try {
          final Map<String, dynamic> jsonMap = json.decode(response.body);
          print("ResponseBody: ${response.body}");
          TimeDecisionModel timeDecision = TimeDecisionModel.fromJson(jsonMap);

          print(response.statusCode);

          String employeeCode = employee.employeeCode ?? "";
          String employeeName = employee.employeeName ?? "";

          if (timeDecision.status == 1) {
            // Handle status 1
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckInPage(
                  storeInfoResponse: widget.storeInfoResponse,
                  employeeName: employeeName,
                  employeeCode: employeeCode,
                  employeeShiftHistoryId: timeDecision.employeeShiftHistoryId!,
                  isCheckIn: true,
                  timeDecision: timeDecision,
                ),
              ),
            );
          } else if (timeDecision.status == 0) {
            // Handle status 0
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CheckInPage(
                  storeInfoResponse: widget.storeInfoResponse,
                  employeeName: employeeName,
                  employeeCode: employeeCode,
                  employeeShiftHistoryId: timeDecision.employeeShiftHistoryId!,
                  isCheckIn: false,
                  timeDecision: timeDecision,
                ),
              ),
            );
          }

          showToast(
            context: context,
            msg: timeDecision.message ?? "Please Check Attendance",
            color: Color.fromARGB(255, 128, 249, 16),
            icon: const Icon(Icons.done),
          );
        } catch (e) {
          print('Error parsing response: $e');
          showToast(
            context: context,
            msg: 'Error parsing response',
            color: Colors.red,
            icon: const Icon(Icons.error),
          );
        }
      } else if (response.statusCode >= 400 && response.statusCode <= 500) {
        // Handle status code 400-500
        print(
            'Failed to fetch time decision. Status code: ${response.statusCode} - ${response.body}');

        final Map<String, dynamic> jsonMap = json.decode(response.body);
        TimeDecisionModel errorModel = TimeDecisionModel.fromJson(jsonMap);

        showToast(
          context: context,
          msg: errorModel.message ?? "Unknown error occurred",
          color: Colors.red,
          icon: const Icon(Icons.error),
        );
      }
    } catch (error) {
      print('Error fetching time decision: $error');
    }
  }
}
