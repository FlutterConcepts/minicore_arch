import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarMapper {
  static CarBrandEntity fromJsonToBrand(Map<String, dynamic> json) {
    return CarBrandEntity(
      code: int.parse(json['codigo'] as String),
      name: json['nome'] as String,
    );
  }

  static CarModelEntity fromJsonToModel(Map<String, dynamic> json) {
    return CarModelEntity(
      code: int.parse(json['code'] as String),
      name: json['name'] as String,
    );
  }
}
