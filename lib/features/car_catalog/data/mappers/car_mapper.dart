import 'package:minicore_arch_example/features/car_catalog/interactor/entities/car_entity.dart';

class CarMapper {
  static CarEntity fromJsonToEntity(Map<String, dynamic> json) {
    return CarEntity(
      code: json['codigo'],
      name: json['nome'],
    );
  }
}
