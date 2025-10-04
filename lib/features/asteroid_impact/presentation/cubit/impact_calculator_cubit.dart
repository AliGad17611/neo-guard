import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/asteroid_parameters.dart';
import '../../domain/usecases/calculate_impact.dart';
import 'impact_calculator_state.dart';

class ImpactCalculatorCubit extends Cubit<ImpactCalculatorState> {
  final CalculateImpact calculateImpactUseCase;
  AsteroidParameters? _currentParameters;

  ImpactCalculatorCubit(this.calculateImpactUseCase)
      : super(ImpactCalculatorInitial());

  void updateParameters(AsteroidParameters parameters) async {
    _currentParameters = parameters;

    if (parameters.isValid) {
      final result = await calculateImpactUseCase(parameters);
      result.fold(
        (error) => emit(ImpactCalculatorError(error)),
        (impactResult) => emit(ImpactCalculatorPreview(
          result: impactResult,
          parameters: parameters,
        )),
      );
    } else {
      emit(ImpactCalculatorInitial());
    }
  }

  void launchImpact() async {
    if (_currentParameters == null || !_currentParameters!.isValid) {
      emit(const ImpactCalculatorError('Invalid parameters'));
      return;
    }

    // Generate random impact position
    final random = Random();
    final impactPosition = Offset(
      0.3 + random.nextDouble() * 0.4,
      0.3 + random.nextDouble() * 0.4,
    );

    emit(ImpactCalculatorCalculating(
      impactPosition: impactPosition,
      parameters: _currentParameters!,
    ));

    // Simulate impact animation duration
    await Future.delayed(const Duration(milliseconds: 2000));

    final result = await calculateImpactUseCase(_currentParameters!);
    result.fold(
      (error) => emit(ImpactCalculatorError(error)),
      (impactResult) => emit(ImpactCalculatorSuccess(
        result: impactResult,
        impactPosition: impactPosition,
        parameters: _currentParameters!,
      )),
    );
  }

  void reset() {
    _currentParameters = null;
    emit(ImpactCalculatorInitial());
  }
}