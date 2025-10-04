import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'nasa_eyes_state.dart';

class NasaEyesCubit extends Cubit<NasaEyesState> {
  late final WebViewController _controller;

  NasaEyesCubit() : super(NasaEyesInitial()) {
    _initializeWebView();
  }

  WebViewController get controller => _controller;

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.black)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Progress tracking
          },
          onPageStarted: (String url) {
            emit(NasaEyesLoading());
          },
          onPageFinished: (String url) {
            emit(NasaEyesLoaded());
          },
          onWebResourceError: (WebResourceError error) {
            emit(NasaEyesError('Failed to load: ${error.description}'));
          },
        ),
      )
      ..loadRequest(Uri.parse('https://eyes.nasa.gov/apps/asteroids/#/home'));
  }

  void reload() {
    _controller.reload();
    emit(NasaEyesLoading());
  }

  void retry() {
    emit(NasaEyesLoading());
    _controller.reload();
  }
}
