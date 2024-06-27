class WifiInfo {
  String? wifiBSSID;

  WifiInfo({
    this.wifiBSSID,
  });

  Map<String, dynamic> toJson() => {
        "wifiBSSID": wifiBSSID,
      };
}
