import 'package:equatable/equatable.dart';
import 'neo_entity.dart';

/// Entity representing the NEO Feed response
class NeoFeedEntity extends Equatable {
  final int elementCount;
  final Map<String, List<NeoEntity>> nearEarthObjects;

  const NeoFeedEntity({
    required this.elementCount,
    required this.nearEarthObjects,
  });

  /// Get all NEOs as a flat list
  List<NeoEntity> get allNeos {
    return nearEarthObjects.values.expand((list) => list).toList();
  }

  /// Get only potentially hazardous asteroids
  List<NeoEntity> get hazardousNeos {
    return allNeos.where((neo) => neo.isPotentiallyHazardous).toList();
  }

  /// Get NEOs sorted by size (diameter)
  List<NeoEntity> get neosSortedBySize {
    final neos = List<NeoEntity>.from(allNeos);
    neos.sort(
      (a, b) => b.estimatedDiameter.kilometers.max.compareTo(
        a.estimatedDiameter.kilometers.max,
      ),
    );
    return neos;
  }

  /// Get NEOs sorted by velocity
  List<NeoEntity> get neosSortedByVelocity {
    final neos = List<NeoEntity>.from(allNeos);
    neos.sort((a, b) {
      if (a.closeApproachData.isEmpty || b.closeApproachData.isEmpty) {
        return 0;
      }
      final velocityA = double.parse(
        a.closeApproachData.first.relativeVelocity.kilometersPerHour,
      );
      final velocityB = double.parse(
        b.closeApproachData.first.relativeVelocity.kilometersPerHour,
      );
      return velocityB.compareTo(velocityA);
    });
    return neos;
  }

  @override
  List<Object?> get props => [elementCount, nearEarthObjects];
}
