class CarSpecModel {
  CarSpecModel({
    required this.code,
    required this.name,
  });

  factory CarSpecModel.fromJson(Map<String, dynamic> json) {
    return CarSpecModel(
      code: int.parse(json['code'] as String),
      name: json['name'] as String,
    );
  }

  final int code;
  final String name;
}
