import 'package:dartz/dartz.dart';
import '../entities/neo_feed_entity.dart';
import '../repositories/neo_repository.dart';

/// Use case for fetching NEO feed data
class GetNeoFeed {
  final NeoRepository repository;

  GetNeoFeed(this.repository);

  Future<Either<String, NeoFeedEntity>> call({
    required String startDate,
    required String endDate,
  }) async {
    return await repository.getNeoFeed(startDate: startDate, endDate: endDate);
  }

  /// Get NEO feed for today
  Future<Either<String, NeoFeedEntity>> getToday() async {
    final today = DateTime.now();
    final startDate = _formatDate(today);
    final endDate = _formatDate(today.add(const Duration(days: 1)));

    return await repository.getNeoFeed(startDate: startDate, endDate: endDate);
  }

  /// Get NEO feed for the current week
  Future<Either<String, NeoFeedEntity>> getWeek() async {
    final today = DateTime.now();
    final startDate = _formatDate(today);
    final endDate = _formatDate(today.add(const Duration(days: 7)));

    return await repository.getNeoFeed(startDate: startDate, endDate: endDate);
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
