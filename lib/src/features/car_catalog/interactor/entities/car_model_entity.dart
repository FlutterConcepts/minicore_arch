/// Represents a car entity with a unique code and a name.
class CarModelEntity {
  /// Creates a [CarModelEntity] with the specified [code] and [name].
  ///
  /// The [code] is a unique identifier for the car.
  /// The [name] is the descriptive name of the car.
  CarModelEntity({
    required this.code,
    required this.name,
  });

  /// The unique identifier for the car.
  final int code;

  /// The descriptive name of the car.
  final String name;
}
