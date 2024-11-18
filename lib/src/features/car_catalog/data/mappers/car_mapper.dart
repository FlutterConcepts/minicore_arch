import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarMapper {
  static CarBrandEntity fromJsonToBrand(Map<String, dynamic> json) =>
      CarBrandEntity(
        code: int.parse(json['code'] as String),
        name: json['name'] as String,
      );

  static CarModelEntity fromJsonToModel(Map<String, dynamic> json) =>
      CarModelEntity(
        code: int.parse(json['code'] as String),
        name: json['name'] as String,
      );
}
