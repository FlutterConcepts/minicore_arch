class CarSpecModel {
  CarSpecModel({
    required this.code,
    required this.name,
  });

  factory CarSpecModel.fromJson(Map<String, dynamic> json) {
    return CarSpecModel(
      code: json['code'] as int,
      name: json['name'] as String,
    );
  }

  final int code;
  final String name;
}
