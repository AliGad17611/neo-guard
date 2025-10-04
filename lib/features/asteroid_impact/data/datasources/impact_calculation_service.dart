import 'dart:math';
import '../../domain/entities/asteroid_parameters.dart';
import '../models/impact_result_model.dart';

class ImpactCalculationService {
  static const double asteroidDensity = 2500; // kg/m³

  Future<ImpactResultModel> calculate(AsteroidParameters parameters) async {
    // Simulate calculation delay for animation
    await Future.delayed(const Duration(milliseconds: 100));

    // Calculate mass (assuming spherical asteroid)
    final radius = parameters.diameter / 2;
    final volume = (4 / 3) * pi * pow(radius, 3);
    final mass = volume * asteroidDensity;

    return ImpactResultModel.fromCalculation(
      mass: mass,
      velocity: parameters.velocity,
      isOcean: parameters.location == ImpactLocation.ocean,
    );
  }
}