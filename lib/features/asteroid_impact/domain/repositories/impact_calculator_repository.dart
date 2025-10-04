import 'package:dartz/dartz.dart';
import '../entities/asteroid_parameters.dart';
import '../entities/impact_result.dart';

abstract class ImpactCalculatorRepository {
  Future<Either<String, ImpactResult>> calculateImpact(
    AsteroidParameters parameters,
  );
}