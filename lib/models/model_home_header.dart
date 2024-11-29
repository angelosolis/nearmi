enum HeaderType {
  basic,
  minimal,
}

final mapHeaderType = {
  'basic': HeaderType.basic,
  'minimal': HeaderType.minimal,
};

class HomeHeaderModel {
  final HeaderType type;
  final dynamic data;

  HomeHeaderModel({
    required this.type,
    required this.data,
  });

  factory HomeHeaderModel.fromJson(Map<String, dynamic> json) {
    return HomeHeaderModel(
      type: mapHeaderType[json["type"]] ?? HeaderType.minimal,
      data: json['data'].cast<String>(),
    );
  }
}
