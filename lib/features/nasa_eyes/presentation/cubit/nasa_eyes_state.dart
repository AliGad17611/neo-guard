import 'package:equatable/equatable.dart';

abstract class NasaEyesState extends Equatable {
  const NasaEyesState();

  @override
  List<Object?> get props => [];
}

class NasaEyesInitial extends NasaEyesState {}

class NasaEyesLoading extends NasaEyesState {}

class NasaEyesLoaded extends NasaEyesState {}

class NasaEyesError extends NasaEyesState {
  final String message;

  const NasaEyesError(this.message);

  @override
  List<Object?> get props => [message];
}
