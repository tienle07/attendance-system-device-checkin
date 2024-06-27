class LocationInfo {
  double? latitude;
  double? longitude;

  LocationInfo({
    this.latitude,
    this.longitude,
  });

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
