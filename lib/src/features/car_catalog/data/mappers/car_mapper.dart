// ignore_for_file: public_member_api_docs

import 'package:minicore_arch_example/minicore_arch_example.dart';

class CarMapper {
  static CarEntity fromJsonToEntity(Map<String, dynamic> json) {
    return CarEntity(
      code: json['codigo'] as String? ?? '',
      name: json['nome'] as String? ?? '',
    );
  }
}
