import 'package:equatable/equatable.dart';

enum SeverityLevel {
  local,
  city,
  major,
  regional,
  extinction,
}

class ImpactResult extends Equatable {
  final double impactEnergy; // Megatons TNT
  final double craterSize; // meters
  final double damageRadius; // km
  final bool showTsunami;
  final SeverityLevel severityLevel;

  const ImpactResult({
    required this.impactEnergy,
    required this.craterSize,
    required this.damageRadius,
    required this.showTsunami,
    required this.severityLevel,
  });

  @override
  List<Object?> get props => [
        impactEnergy,
        craterSize,
        damageRadius,
        showTsunami,
        severityLevel,
      ];

  String get severityText {
    switch (severityLevel) {
      case SeverityLevel.extinction:
        return 'EXTINCTION LEVEL';
      case SeverityLevel.regional:
        return 'REGIONAL CATASTROPHE';
      case SeverityLevel.major:
        return 'MAJOR DISASTER';
      case SeverityLevel.city:
        return 'CITY DESTRUCTION';
      case SeverityLevel.local:
        return 'LOCAL DAMAGE';
    }
  }
}