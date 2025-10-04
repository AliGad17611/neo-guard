import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:neo_guard/features/asteroid_impact/data/datasources/impact_calculation_service.dart';
import 'package:neo_guard/features/asteroid_impact/data/repositories/impact_calculator_repository_impl.dart';
import 'package:neo_guard/features/asteroid_impact/domain/repositories/impact_calculator_repository.dart';
import 'package:neo_guard/features/asteroid_impact/domain/usecases/calculate_impact.dart';
import 'package:neo_guard/features/asteroid_impact/presentation/cubit/impact_calculator_cubit.dart';
import 'package:neo_guard/features/dashboard/data/datasources/neo_remote_data_source.dart';
import 'package:neo_guard/features/dashboard/data/repositories/neo_repository_impl.dart';
import 'package:neo_guard/features/dashboard/domain/repositories/neo_repository.dart';
import 'package:neo_guard/features/dashboard/domain/usecases/get_neo_feed.dart';
import 'package:neo_guard/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:neo_guard/features/nasa_eyes/presentation/cubit/nasa_eyes_cubit.dart';
import 'package:neo_guard/features/meteor_madness/presentation/cubit/meteor_madness_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => ImpactCalculatorCubit(sl()));

  sl.registerFactory(() => NasaEyesCubit());

  sl.registerFactory(() => MeteorMadnessCubit());

  sl.registerFactory(() => DashboardCubit(sl()));

  // Use cases
  sl.registerLazySingleton(() => CalculateImpact(sl()));

  sl.registerLazySingleton(() => GetNeoFeed(sl()));

  // Repository
  sl.registerLazySingleton<ImpactCalculatorRepository>(
    () => ImpactCalculatorRepositoryImpl(sl()),
  );

  sl.registerLazySingleton<NeoRepository>(() => NeoRepositoryImpl(sl()));

  // Data sources
  sl.registerLazySingleton(() => ImpactCalculationService());

  sl.registerLazySingleton(() => NeoRemoteDataSource(client: sl()));

  // External
  sl.registerLazySingleton(() => http.Client());
}
