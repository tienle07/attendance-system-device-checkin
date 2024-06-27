class DeviceInfoModel {
  String? id;

  DeviceInfoModel({
    this.id,
  });

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
