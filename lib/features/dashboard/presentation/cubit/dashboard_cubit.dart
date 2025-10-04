import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_neo_feed.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final GetNeoFeed getNeoFeed;

  DashboardCubit(this.getNeoFeed) : super(DashboardInitial());

  /// Load NEO data for today
  Future<void> loadTodayData() async {
    emit(DashboardLoading());

    final result = await getNeoFeed.getToday();

    result.fold(
      (error) => emit(DashboardError(error)),
      (neoFeed) => emit(DashboardLoaded(neoFeed)),
    );
  }

  /// Load NEO data for the week
  Future<void> loadWeekData() async {
    emit(DashboardLoading());

    final result = await getNeoFeed.getWeek();

    result.fold(
      (error) => emit(DashboardError(error)),
      (neoFeed) => emit(DashboardLoaded(neoFeed)),
    );
  }

  /// Load NEO data for custom date range
  Future<void> loadCustomRange(String startDate, String endDate) async {
    emit(DashboardLoading());

    final result = await getNeoFeed(startDate: startDate, endDate: endDate);

    result.fold(
      (error) => emit(DashboardError(error)),
      (neoFeed) => emit(DashboardLoaded(neoFeed)),
    );
  }

  /// Retry last request
  void retry() {
    loadTodayData();
  }
}
