class ReciveDataModel {
  int index;
  dynamic value;
  ReciveDataModel({
    required this.index,
    required this.value,
  });

  factory ReciveDataModel.fromJson(Map<String, dynamic> json) {
    return ReciveDataModel(
        index: json['index'] ?? 0, value: json["value"] ?? "no data");
  }
  Map<dynamic, dynamic> toJson() => {
        'index': index,
        'value': value,
      };
}
