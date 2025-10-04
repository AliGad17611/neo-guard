import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neo_guard/core/di/service_locator.dart';
import '../cubit/dashboard_cubit.dart';
import '../cubit/dashboard_state.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/neo_stats_cards.dart';
import '../widgets/neo_list_view.dart';
import '../widgets/dashboard_error_view.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<DashboardCubit>()..loadTodayData(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFF0A0E27),
              const Color(0xFF1A1F3A),
              Colors.black.withValues(alpha: 0.95),
            ],
          ),
        ),
        child: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              if (state is DashboardLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.cyanAccent),
                );
              }

              if (state is DashboardError) {
                return DashboardErrorView(
                  message: state.message,
                  onRetry: () => context.read<DashboardCubit>().retry(),
                );
              }

              if (state is DashboardLoaded) {
                return RefreshIndicator(
                  onRefresh: () =>
                      context.read<DashboardCubit>().loadTodayData(),
                  color: Colors.cyanAccent,
                  backgroundColor: const Color(0xFF1A1F3A),
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(child: DashboardHeader()),
                      SliverToBoxAdapter(
                        child: NeoStatsCards(neoFeed: state.neoFeed),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16),
                        sliver: NeoListView(neoFeed: state.neoFeed),
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}
