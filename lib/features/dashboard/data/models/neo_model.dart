import '../../domain/entities/neo_entity.dart';

class NeoModel extends NeoEntity {
  const NeoModel({
    required super.id,
    required super.name,
    required super.nasaJplUrl,
    required super.absoluteMagnitude,
    required super.estimatedDiameter,
    required super.isPotentiallyHazardous,
    required super.closeApproachData,
    required super.isSentryObject,
  });

  factory NeoModel.fromJson(Map<String, dynamic> json) {
    return NeoModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nasaJplUrl: json['nasa_jpl_url'] as String,
      absoluteMagnitude: (json['absolute_magnitude_h'] as num).toDouble(),
      estimatedDiameter: EstimatedDiameterModel.fromJson(
        json['estimated_diameter'] as Map<String, dynamic>,
      ),
      isPotentiallyHazardous: json['is_potentially_hazardous_asteroid'] as bool,
      closeApproachData: (json['close_approach_data'] as List)
          .map(
            (e) => CloseApproachDataModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
      isSentryObject: json['is_sentry_object'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nasa_jpl_url': nasaJplUrl,
      'absolute_magnitude_h': absoluteMagnitude,
      'estimated_diameter': (estimatedDiameter as EstimatedDiameterModel)
          .toJson(),
      'is_potentially_hazardous_asteroid': isPotentiallyHazardous,
      'close_approach_data': closeApproachData
          .map((e) => (e as CloseApproachDataModel).toJson())
          .toList(),
      'is_sentry_object': isSentryObject,
    };
  }
}

class EstimatedDiameterModel extends EstimatedDiameter {
  const EstimatedDiameterModel({
    required super.kilometers,
    required super.meters,
    required super.miles,
    required super.feet,
  });

  factory EstimatedDiameterModel.fromJson(Map<String, dynamic> json) {
    return EstimatedDiameterModel(
      kilometers: DiameterRangeModel.fromJson(
        json['kilometers'] as Map<String, dynamic>,
      ),
      meters: DiameterRangeModel.fromJson(
        json['meters'] as Map<String, dynamic>,
      ),
      miles: DiameterRangeModel.fromJson(json['miles'] as Map<String, dynamic>),
      feet: DiameterRangeModel.fromJson(json['feet'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kilometers': (kilometers as DiameterRangeModel).toJson(),
      'meters': (meters as DiameterRangeModel).toJson(),
      'miles': (miles as DiameterRangeModel).toJson(),
      'feet': (feet as DiameterRangeModel).toJson(),
    };
  }
}

class DiameterRangeModel extends DiameterRange {
  const DiameterRangeModel({required super.min, required super.max});

  factory DiameterRangeModel.fromJson(Map<String, dynamic> json) {
    return DiameterRangeModel(
      min: (json['estimated_diameter_min'] as num).toDouble(),
      max: (json['estimated_diameter_max'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'estimated_diameter_min': min, 'estimated_diameter_max': max};
  }
}

class CloseApproachDataModel extends CloseApproachData {
  const CloseApproachDataModel({
    required super.closeApproachDate,
    required super.closeApproachDateFull,
    required super.epochDateCloseApproach,
    required super.relativeVelocity,
    required super.missDistance,
    required super.orbitingBody,
  });

  factory CloseApproachDataModel.fromJson(Map<String, dynamic> json) {
    return CloseApproachDataModel(
      closeApproachDate: json['close_approach_date'] as String,
      closeApproachDateFull: json['close_approach_date_full'] as String,
      epochDateCloseApproach: json['epoch_date_close_approach'] as int,
      relativeVelocity: RelativeVelocityModel.fromJson(
        json['relative_velocity'] as Map<String, dynamic>,
      ),
      missDistance: MissDistanceModel.fromJson(
        json['miss_distance'] as Map<String, dynamic>,
      ),
      orbitingBody: json['orbiting_body'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'close_approach_date': closeApproachDate,
      'close_approach_date_full': closeApproachDateFull,
      'epoch_date_close_approach': epochDateCloseApproach,
      'relative_velocity': (relativeVelocity as RelativeVelocityModel).toJson(),
      'miss_distance': (missDistance as MissDistanceModel).toJson(),
      'orbiting_body': orbitingBody,
    };
  }
}

class RelativeVelocityModel extends RelativeVelocity {
  const RelativeVelocityModel({
    required super.kilometersPerSecond,
    required super.kilometersPerHour,
    required super.milesPerHour,
  });

  factory RelativeVelocityModel.fromJson(Map<String, dynamic> json) {
    return RelativeVelocityModel(
      kilometersPerSecond: json['kilometers_per_second'] as String,
      kilometersPerHour: json['kilometers_per_hour'] as String,
      milesPerHour: json['miles_per_hour'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'kilometers_per_second': kilometersPerSecond,
      'kilometers_per_hour': kilometersPerHour,
      'miles_per_hour': milesPerHour,
    };
  }
}

class MissDistanceModel extends MissDistance {
  const MissDistanceModel({
    required super.astronomical,
    required super.lunar,
    required super.kilometers,
    required super.miles,
  });

  factory MissDistanceModel.fromJson(Map<String, dynamic> json) {
    return MissDistanceModel(
      astronomical: json['astronomical'] as String,
      lunar: json['lunar'] as String,
      kilometers: json['kilometers'] as String,
      miles: json['miles'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'astronomical': astronomical,
      'lunar': lunar,
      'kilometers': kilometers,
      'miles': miles,
    };
  }
}
