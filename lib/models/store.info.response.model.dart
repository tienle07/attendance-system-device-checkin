class StoreInfoResponseModel {
  StoreResponseModel? storeResponseModel;
  List<EmployeeInStoreResponseModel>? employeeInStoreResponseModels;

  StoreInfoResponseModel({
    this.storeResponseModel,
    this.employeeInStoreResponseModels,
  });

  factory StoreInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      StoreInfoResponseModel(
        storeResponseModel:
            StoreResponseModel.fromJson(json["storeResponseModel"]),
        employeeInStoreResponseModels: List<EmployeeInStoreResponseModel>.from(
            json["employeeInStoreResponseModels"]
                .map((x) => EmployeeInStoreResponseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "storeResponseModel": storeResponseModel?.toJson(),
        "employeeInStoreResponseModels": List<dynamic>.from(
            employeeInStoreResponseModels!.map((x) => x.toJson())),
      };
}

class EmployeeInStoreResponseModel {
  int? id;
  int? storeId;
  String? storeName;
  int? employeeId;
  String? employeeCode;
  String? employeeName;
  String? profileImage;
  int? positionId;
  String? positionName;
  int? typeId;
  String? typeName;
  DateTime? assignedDate;
  int? status;

  EmployeeInStoreResponseModel({
    this.id,
    this.storeId,
    this.storeName,
    this.employeeId,
    this.employeeCode,
    this.employeeName,
    this.profileImage,
    this.positionId,
    this.positionName,
    this.typeId,
    this.typeName,
    this.assignedDate,
    this.status,
  });

  factory EmployeeInStoreResponseModel.fromJson(Map<String, dynamic> json) =>
      EmployeeInStoreResponseModel(
        id: json["id"],
        storeId: json["storeId"],
        storeName: json["storeName"],
        employeeId: json["employeeId"],
        employeeCode: json["employeeCode"],
        employeeName: json["employeeName"],
        profileImage: json["profileImage"],
        positionId: json["positionId"],
        positionName: json["positionName"],
        typeId: json["typeId"],
        typeName: json["typeName"],
        assignedDate: DateTime.parse(json["assignedDate"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "storeId": storeId,
        "storeName": storeName,
        "employeeId": employeeId,
        "employeeCode": employeeCode,
        "employeeName": employeeName,
        "profileImage": profileImage,
        "positionId": positionId,
        "positionName": positionName,
        "typeId": typeId,
        "typeName": typeName,
        "assignedDate": assignedDate?.toIso8601String(),
        "status": status,
      };
}

class StoreResponseModel {
  int? id;
  int? brandId;
  String? storeName;
  String? storeManager;
  DateTime? createDate;
  String? address;
  double? latitude;
  double? longitude;
  String? openTime;
  String? closeTime;
  String? bssid;
  bool? active;

  StoreResponseModel({
    this.id,
    this.brandId,
    this.storeName,
    this.storeManager,
    this.createDate,
    this.address,
    this.latitude,
    this.longitude,
    this.openTime,
    this.closeTime,
    this.bssid,
    this.active,
  });

  factory StoreResponseModel.fromJson(Map<String, dynamic> json) =>
      StoreResponseModel(
        id: json["id"],
        brandId: json["brandId"],
        storeName: json["storeName"],
        storeManager: json["storeManager"],
        createDate: DateTime.parse(json["createDate"]),
        address: json["address"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        bssid: json["bssid"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "brandId": brandId,
        "storeName": storeName,
        "storeManager": storeManager,
        "createDate": createDate?.toIso8601String(),
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "openTime": openTime,
        "closeTime": closeTime,
        "bssid": bssid,
        "active": active,
      };
}
