import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../domain/entities/asteroid_parameters.dart';
import '../../domain/entities/impact_result.dart';

abstract class ImpactCalculatorState extends Equatable {
  const ImpactCalculatorState();

  @override
  List<Object?> get props => [];
}

class ImpactCalculatorInitial extends ImpactCalculatorState {}

class ImpactCalculatorPreview extends ImpactCalculatorState {
  final ImpactResult result;
  final AsteroidParameters parameters;

  const ImpactCalculatorPreview({
    required this.result,
    required this.parameters,
  });

  @override
  List<Object?> get props => [result, parameters];
}

class ImpactCalculatorCalculating extends ImpactCalculatorState {
  final Offset impactPosition;
  final AsteroidParameters parameters;

  const ImpactCalculatorCalculating({
    required this.impactPosition,
    required this.parameters,
  });

  @override
  List<Object?> get props => [impactPosition, parameters];
}

class ImpactCalculatorSuccess extends ImpactCalculatorState {
  final ImpactResult result;
  final Offset impactPosition;
  final AsteroidParameters parameters;

  const ImpactCalculatorSuccess({
    required this.result,
    required this.impactPosition,
    required this.parameters,
  });

  @override
  List<Object?> get props => [result, impactPosition, parameters];
}

class ImpactCalculatorError extends ImpactCalculatorState {
  final String message;

  const ImpactCalculatorError(this.message);

  @override
  List<Object?> get props => [message];
}