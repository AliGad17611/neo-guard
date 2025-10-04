import 'package:dartz/dartz.dart';
import '../entities/neo_feed_entity.dart';

/// Repository interface for NEO data
abstract class NeoRepository {
  /// Fetch NEO feed data for a date range
  ///
  /// [startDate] - Start date in format YYYY-MM-DD
  /// [endDate] - End date in format YYYY-MM-DD (max 7 days from start)
  Future<Either<String, NeoFeedEntity>> getNeoFeed({
    required String startDate,
    required String endDate,
  });
}
