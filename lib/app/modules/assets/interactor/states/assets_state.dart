import 'package:tractian_challenge/app/core/errors/failures.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/assets.dart';

sealed  class AssetsState {}

class InitialState implements AssetsState {}

class LoadingState implements AssetsState {}

class SuccessState implements AssetsState {
  const SuccessState({
    required this.data,
  });

  final Assets data;
}

class ErrorState implements AssetsState {
  const ErrorState({
    required this.exception,
  });

  final Failure exception;
}