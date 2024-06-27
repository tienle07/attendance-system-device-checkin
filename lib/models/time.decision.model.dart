class TimeDecisionModel {
  int? employeeShiftHistoryId;
  DateTime? checkIn;
  DateTime? checkOut;
  String? totalWorkTime;
  String? message;
  int? status;

  TimeDecisionModel({
    this.employeeShiftHistoryId,
    this.checkIn,
    this.checkOut,
    this.totalWorkTime,
    this.message,
    this.status,
  });

  factory TimeDecisionModel.fromJson(Map<String, dynamic> json) {
    return TimeDecisionModel(
      employeeShiftHistoryId: json["EmployeeShiftHistoryId"],
      checkIn: json["CheckIn"] != null ? DateTime.parse(json["CheckIn"]) : null,
      checkOut:
          json["CheckOut"] != null ? DateTime.parse(json["CheckOut"]) : null,
      totalWorkTime: json["TotalWorkTime"],
      message: json["Message"],
      status: json["Status"],
    );
  }

  Map<String, dynamic> toJson() => {
        "employeeShiftHistoryId": employeeShiftHistoryId,
        "CheckIn": checkIn?.toIso8601String(),
        "CheckOut": checkOut?.toIso8601String(),
        "TotalWorkTime": totalWorkTime,
        "message": message,
        "status": status,
      };
}
