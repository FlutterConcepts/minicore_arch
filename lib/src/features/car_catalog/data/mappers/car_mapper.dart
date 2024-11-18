import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarMapper {
  static CarBrandEntity fromJsonToBrand(Map<String, dynamic> json) {
    return CarBrandEntity(
      code: json['codigo'] as String? ?? '',
      name: json['nome'] as String? ?? '',
    );
  }
}
