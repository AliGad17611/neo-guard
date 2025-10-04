import '../../domain/entities/neo_feed_entity.dart';
import 'neo_model.dart';

class NeoFeedModel extends NeoFeedEntity {
  const NeoFeedModel({
    required super.elementCount,
    required super.nearEarthObjects,
  });

  factory NeoFeedModel.fromJson(Map<String, dynamic> json) {
    final nearEarthObjectsJson =
        json['near_earth_objects'] as Map<String, dynamic>;

    final Map<String, List<NeoModel>> nearEarthObjects = {};

    nearEarthObjectsJson.forEach((date, neos) {
      nearEarthObjects[date] = (neos as List)
          .map((neo) => NeoModel.fromJson(neo as Map<String, dynamic>))
          .toList();
    });

    return NeoFeedModel(
      elementCount: json['element_count'] as int,
      nearEarthObjects: nearEarthObjects,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> nearEarthObjectsJson = {};

    nearEarthObjects.forEach((date, neos) {
      nearEarthObjectsJson[date] = neos
          .map((neo) => (neo as NeoModel).toJson())
          .toList();
    });

    return {
      'element_count': elementCount,
      'near_earth_objects': nearEarthObjectsJson,
    };
  }
}
