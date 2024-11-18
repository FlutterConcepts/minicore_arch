import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarMapper {
  static CarBrandEntity fromJsonToBrand(Map<String, dynamic> json) {
    return CarBrandEntity(
      code: int.tryParse(json['codigo'].toString()) ?? 0,
      name: json['nome'] as String? ?? '',
    );
  }

  static CarModelEntity fromJsonToModel(Map<String, dynamic> json) {
    return CarModelEntity(
      code: int.tryParse(json['code'].toString()) ?? 0,
      name: json['name'] as String? ?? '',
    );
  }
}
