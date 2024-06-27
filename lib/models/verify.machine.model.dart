class VerifyMachineModel {
  String? machineCode;
  int? latitude;
  int? longitude;
  String? bssid;

  VerifyMachineModel({
    this.machineCode,
    this.latitude,
    this.longitude,
    this.bssid,
  });

  factory VerifyMachineModel.fromJson(Map<String, dynamic> json) =>
      VerifyMachineModel(
        machineCode: json["machineCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        bssid: json["bssid"],
      );

  Map<String, dynamic> toJson() => {
        "machineCode": machineCode,
        "latitude": latitude,
        "longitude": longitude,
        "bssid": bssid,
      };
}
