import 'package:minicore_arch_example/minicore_arch_example.dart';

/// A utility class for mapping JSON data to [CarEntity] objects.
///
/// This class provides methods to convert raw JSON data into strongly typed
/// [CarEntity] instances.
class CarMapper {
  /// Converts a JSON object into a [CarEntity].
  ///
  /// Accepts a [json] map containing the car data with keys `codigo` and `nome`.
  /// Returns a [CarEntity] instance with the mapped data.
  ///
  /// If the `codigo` or `nome` fields are missing or `null`, they default to an
  /// empty string.
  ///
  /// Example JSON:
  /// ```json
  /// {
  ///   "codigo": "001",
  ///   "nome": "Car Name"
  /// }
  /// ```
  static CarEntity fromJsonToEntity(Map<String, dynamic> json) {
    return CarEntity(
      code: json['codigo'] as String? ?? '',
      name: json['nome'] as String? ?? '',
    );
  }
}
