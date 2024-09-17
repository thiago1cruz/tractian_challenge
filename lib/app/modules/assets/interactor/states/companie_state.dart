import 'package:tractian_challenge/app/core/errors/failures.dart';

import '../entities/company_entity.dart';

sealed  class CompaniesState {}

class InitialCompaniesState implements CompaniesState {}

class LoadingCompaniesState implements CompaniesState {}

class SuccessCompaniesState implements CompaniesState {
  const SuccessCompaniesState({
    required this.data,
  });
  final List<Company> data;
}

class ErrorCompaniesState implements CompaniesState {
  const ErrorCompaniesState({
    required this.exception,
  });

  final Failure exception;
}