import 'package:equatable/equatable.dart';
import '../../domain/entities/neo_feed_entity.dart';

abstract class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final NeoFeedEntity neoFeed;

  const DashboardLoaded(this.neoFeed);

  @override
  List<Object?> get props => [neoFeed];
}

class DashboardError extends DashboardState {
  final String message;

  const DashboardError(this.message);

  @override
  List<Object?> get props => [message];
}
