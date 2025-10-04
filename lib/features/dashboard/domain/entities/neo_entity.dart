import 'package:equatable/equatable.dart';

/// Near Earth Object (NEO) entity representing an asteroid
class NeoEntity extends Equatable {
  final String id;
  final String name;
  final String nasaJplUrl;
  final double absoluteMagnitude;
  final EstimatedDiameter estimatedDiameter;
  final bool isPotentiallyHazardous;
  final List<CloseApproachData> closeApproachData;
  final bool isSentryObject;

  const NeoEntity({
    required this.id,
    required this.name,
    required this.nasaJplUrl,
    required this.absoluteMagnitude,
    required this.estimatedDiameter,
    required this.isPotentiallyHazardous,
    required this.closeApproachData,
    required this.isSentryObject,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    nasaJplUrl,
    absoluteMagnitude,
    estimatedDiameter,
    isPotentiallyHazardous,
    closeApproachData,
    isSentryObject,
  ];
}

class EstimatedDiameter extends Equatable {
  final DiameterRange kilometers;
  final DiameterRange meters;
  final DiameterRange miles;
  final DiameterRange feet;

  const EstimatedDiameter({
    required this.kilometers,
    required this.meters,
    required this.miles,
    required this.feet,
  });

  @override
  List<Object?> get props => [kilometers, meters, miles, feet];
}

class DiameterRange extends Equatable {
  final double min;
  final double max;

  const DiameterRange({required this.min, required this.max});

  @override
  List<Object?> get props => [min, max];
}

class CloseApproachData extends Equatable {
  final String closeApproachDate;
  final String closeApproachDateFull;
  final int epochDateCloseApproach;
  final RelativeVelocity relativeVelocity;
  final MissDistance missDistance;
  final String orbitingBody;

  const CloseApproachData({
    required this.closeApproachDate,
    required this.closeApproachDateFull,
    required this.epochDateCloseApproach,
    required this.relativeVelocity,
    required this.missDistance,
    required this.orbitingBody,
  });

  @override
  List<Object?> get props => [
    closeApproachDate,
    closeApproachDateFull,
    epochDateCloseApproach,
    relativeVelocity,
    missDistance,
    orbitingBody,
  ];
}

class RelativeVelocity extends Equatable {
  final String kilometersPerSecond;
  final String kilometersPerHour;
  final String milesPerHour;

  const RelativeVelocity({
    required this.kilometersPerSecond,
    required this.kilometersPerHour,
    required this.milesPerHour,
  });

  @override
  List<Object?> get props => [
    kilometersPerSecond,
    kilometersPerHour,
    milesPerHour,
  ];
}

class MissDistance extends Equatable {
  final String astronomical;
  final String lunar;
  final String kilometers;
  final String miles;

  const MissDistance({
    required this.astronomical,
    required this.lunar,
    required this.kilometers,
    required this.miles,
  });

  @override
  List<Object?> get props => [astronomical, lunar, kilometers, miles];
}
