import 'package:dartz/dartz.dart';
import '../../domain/entities/asteroid_parameters.dart';
import '../../domain/entities/impact_result.dart';
import '../../domain/repositories/impact_calculator_repository.dart';
import '../datasources/impact_calculation_service.dart';

class ImpactCalculatorRepositoryImpl implements ImpactCalculatorRepository {
  final ImpactCalculationService calculationService;

  ImpactCalculatorRepositoryImpl(this.calculationService);

  @override
  Future<Either<String, ImpactResult>> calculateImpact(
    AsteroidParameters parameters,
  ) async {
    try {
      final result = await calculationService.calculate(parameters);
      return Right(result);
    } catch (e) {
      return Left('Calculation error: ${e.toString()}');
    }
  }
}