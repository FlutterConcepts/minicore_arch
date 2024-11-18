/// Represents a car entity with a unique code and a name.
class CarBrandEntity {
  /// Creates a [CarBrandEntity] with the specified [code] and [name].
  ///
  /// The [code] is a unique identifier for the car.
  /// The [name] is the descriptive name of the car.
  CarBrandEntity({
    required this.code,
    required this.name,
  });

  /// The unique identifier for the car.
  final String code;

  /// The descriptive name of the car.
  final String name;
}
