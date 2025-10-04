import 'package:dartz/dartz.dart';
import '../entities/asteroid_parameters.dart';
import '../entities/impact_result.dart';
import '../repositories/impact_calculator_repository.dart';

class CalculateImpact {
  final ImpactCalculatorRepository repository;

  CalculateImpact(this.repository);

  Future<Either<String, ImpactResult>> call(
    AsteroidParameters parameters,
  ) async {
    if (!parameters.isValid) {
      return const Left('Invalid parameters');
    }
    return await repository.calculateImpact(parameters);
  }
}
