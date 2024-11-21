class CarBrandModel {
  CarBrandModel({
    required this.code,
    required this.name,
  });

  factory CarBrandModel.fromJson(Map<String, dynamic> json) {
    return CarBrandModel(
      code: int.parse(json['code'] as String),
      name: json['name'] as String,
    );
  }

  final int code;
  final String name;
}
