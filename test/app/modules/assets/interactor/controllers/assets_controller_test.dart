import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/app/core/errors/failures.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/assets_controller.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/assets.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/company_entity.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/repositories/I_assets_repository.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/assets_state.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/companie_state.dart';


class AssetsRepositoryMock extends Mock implements IAssetsRepository {}

void main() {
  late AssetsRepositoryMock repository;
  late AssetsController controller;

  setUp(() {
    repository = AssetsRepositoryMock();
    controller = AssetsController(repository);
  });

  group('AssetsController', () {
    test('should get companies', () async {
        when(() => repository.getCompanies()).thenAnswer((_) async => const SuccessCompaniesState(data: <Company>[]));
        await controller.getCompanies();
        expect(controller.companiesState, isA<SuccessCompaniesState>());
    });

    test('should return error when get companies', () async {
      when(() => repository.getCompanies()).thenAnswer((_) async =>  ErrorCompaniesState(exception: ServerException(message: 'Erro na consulta')));
      await controller.getCompanies();
      expect(controller.companiesState, isA<ErrorCompaniesState>());    
      expect((controller.companiesState as ErrorCompaniesState).exception, isA<ServerException>());
    });

    test('should verify the stages of CompanyState: initial, loading, success', () async {
        when(() => repository.getCompanies()).thenAnswer((_) async => const SuccessCompaniesState(data: <Company>[]));
      expect(controller.companiesState, isA<InitialCompaniesState>());
      
     final future = controller.getCompanies();
      
      expect(controller.companiesState, isA<LoadingCompaniesState>());
      
      await future;
      
      expect(controller.companiesState, isA<SuccessCompaniesState>());
    });

    test('should verify the stages of CompanyState: initial, loading, error', () async {
      when(() => repository.getCompanies()).thenAnswer((_) async => ErrorCompaniesState(exception: ServerException(message: 'Erro na consulta')));
      
      expect(controller.companiesState, isA<InitialCompaniesState>());
      
      final future = controller.getCompanies();
      
      expect(controller.companiesState, isA<LoadingCompaniesState>());
      
      await future;
      
      expect(controller.companiesState, isA<ErrorCompaniesState>());
    });

    test('should get assets', () async {
      when(() => repository.getAssets(companyId: '1')).thenAnswer((_) async => SuccessState(data: Assets(assets: [], locations: [])));
      await controller.getAssets(companyId: '1');
      expect(controller.assetsState, isA<SuccessState>());
    });

    test('should return error when company id is empty', () async {
      await controller.getAssets(companyId: '');
      expect(controller.assetsState, isA<ErrorState>());
    });

    test('should return error when get assets', () async {
      when(() => repository.getAssets(companyId: '1')).thenAnswer((_) async => ErrorState(exception: ServerException(message: 'Erro na consulta')));
      await controller.getAssets(companyId: '1');
      expect(controller.assetsState, isA<ErrorState>());
      expect((controller.assetsState as ErrorState).exception, isA<ServerException>());
      expect((controller.assetsState as ErrorState).exception.message, 'Erro na consulta');
    });
 
  });
}