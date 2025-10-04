import 'dart:math';

import '../../domain/entities/impact_result.dart';

class ImpactResultModel extends ImpactResult {
  const ImpactResultModel({
    required super.impactEnergy,
    required super.craterSize,
    required super.damageRadius,
    required super.showTsunami,
    required super.severityLevel,
  });

  factory ImpactResultModel.fromCalculation({
    required double mass,
    required double velocity,
    required bool isOcean,
  }) {
    // Kinetic Energy (Joules)
    final kineticEnergy = 0.5 * mass * (velocity * 1000) * (velocity * 1000);
    
    // TNT Equivalent
    final tntEquivalent = kineticEnergy / 4.184e9;
    final megatons = tntEquivalent / 1e9;
    
    // Crater Diameter
    final craterDiameter = pow(kineticEnergy / 1e15, 0.25) * 100;
    
    // Damage Radius
    final damageRadius = sqrt(megatons) * 5;
    
    // Severity Level
    final severity = _calculateSeverity(megatons);

    return ImpactResultModel(
      impactEnergy: megatons,
      craterSize: craterDiameter.toDouble(),
      damageRadius: damageRadius,
      showTsunami: isOcean,
      severityLevel: severity,
    );
  }

  static SeverityLevel _calculateSeverity(double megatons) {
    if (megatons > 1000) return SeverityLevel.extinction;
    if (megatons > 100) return SeverityLevel.regional;
    if (megatons > 10) return SeverityLevel.major;
    if (megatons > 1) return SeverityLevel.city;
    return SeverityLevel.local;
  }
}