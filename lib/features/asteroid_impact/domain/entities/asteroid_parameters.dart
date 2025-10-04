import 'package:equatable/equatable.dart';

enum ImpactLocation { land, ocean }

class AsteroidParameters extends Equatable {
  final double diameter; // meters
  final double velocity; // km/s
  final ImpactLocation location;

  const AsteroidParameters({
    required this.diameter,
    required this.velocity,
    required this.location,
  });

  bool get isValid => diameter > 0 && velocity > 0;

  @override
  List<Object?> get props => [diameter, velocity, location];

  AsteroidParameters copyWith({
    double? diameter,
    double? velocity,
    ImpactLocation? location,
  }) {
    return AsteroidParameters(
      diameter: diameter ?? this.diameter,
      velocity: velocity ?? this.velocity,
      location: location ?? this.location,
    );
  }
}