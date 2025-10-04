import 'package:dartz/dartz.dart';
import '../../domain/entities/neo_feed_entity.dart';
import '../../domain/repositories/neo_repository.dart';
import '../datasources/neo_remote_data_source.dart';

class NeoRepositoryImpl implements NeoRepository {
  final NeoRemoteDataSource remoteDataSource;

  NeoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, NeoFeedEntity>> getNeoFeed({
    required String startDate,
    required String endDate,
  }) async {
    try {
      final neoFeed = await remoteDataSource.getNeoFeed(
        startDate: startDate,
        endDate: endDate,
      );
      return Right(neoFeed);
    } catch (e) {
      return Left(e.toString().replaceAll('Exception: ', ''));
    }
  }
}
