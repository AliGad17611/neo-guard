import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../cubit/nasa_eyes_cubit.dart';
import '../cubit/nasa_eyes_state.dart';
import '../widgets/error_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/webview_actions.dart';

class NasaEyesPage extends StatelessWidget {
  const NasaEyesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('NASA Eyes on Asteroids'),
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          WebViewActions(
            onRefresh: () {
              context.read<NasaEyesCubit>().reload();
            },
          ),
        ],
      ),
      body: BlocBuilder<NasaEyesCubit, NasaEyesState>(
        builder: (context, state) {
          return Stack(
            children: [
              if (state is NasaEyesError)
                ErrorView(
                  message: state.message,
                  onRetry: () {
                    context.read<NasaEyesCubit>().retry();
                  },
                )
              else
                WebViewWidget(
                  controller: context.read<NasaEyesCubit>().controller,
                ),
              if (state is NasaEyesLoading || state is NasaEyesInitial)
                const LoadingView(),
            ],
          );
        },
      ),
    );
  }
}
