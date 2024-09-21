import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tractian_challenge/app/core/client/i_client_http.dart';
import 'package:tractian_challenge/app/core/errors/failures.dart';
import 'package:tractian_challenge/app/modules/assets/data/repositories/tractian_assets_repository_impl.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/assets.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/repositories/I_assets_repository.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/assets_state.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/companie_state.dart';

import 'mocks/assets.dart';
import 'mocks/companies.dart';
import 'mocks/location.dart';



class IClientHttpMock extends Mock implements IClientHttp{}

void main() {
  late IAssetsRepository repository;
  late IClientHttpMock clientHttp;
  const companyId = '662fd0ee639069143a8fc387';

  setUp(() {
    clientHttp = IClientHttpMock();
    repository = TractianAssetsRepositoryImpl(clientHttp);
    
  });


  group('TractianAssetsRepositoryImpl get Assets', () {  
  

    // const locationsUrl = '/companies/$companyId$locations';
    // const assetsUrl = '/companies/$companyId$assets';

    test('should return success when get assets', () async { 

        when(() => clientHttp.get('/companies/$companyId/assets')).thenAnswer((_) async => Response(statusCode: HttpStatus.ok, headers: {}, data: assetsJson));
        when(() => clientHttp.get('/companies/$companyId/locations')).thenAnswer((_) async => Response(statusCode: HttpStatus.ok, headers: {}, data: locationJson));   

      final result = await repository.getAssets(companyId: '662fd0ee639069143a8fc387');

      expect(result, isA<SuccessState>());
      expect((result as SuccessState).data, isA<Assets>());
    });

    test('should return an error when the server fails to get the assets', () async {
      when(() => clientHttp.get(any())).thenAnswer((_) async => Response(statusCode: HttpStatus.internalServerError, headers: {}, data: {'message': 'Falha no servidor 123456'}));
      final result = await repository.getAssets(companyId: '662fd0ee639069143a8fc387');
      expect((result as ErrorState).exception, isA<ServerException>());
      expect((result).exception.message, 'Falha no servidor 123456');
    });
    
   group('should return fail when at least one request fails', (){
        test('should return an error when the location request fails', () async {
          //Should fail Request Location 
          when(() => clientHttp.get('/companies/$companyId/locations')).thenAnswer((_) async => Response(statusCode: HttpStatus.internalServerError, headers: {}, data: {'message': 'Fail to get locations'}));
          //Request Assets should be ok
          when(() => clientHttp.get('/companies/$companyId/assets')).thenAnswer((_) async => Response(statusCode: HttpStatus.ok, headers: {}, data: assetsJson));

          final result = await repository.getAssets(companyId: '662fd0ee639069143a8fc387');
          expect((result as ErrorState).exception, isA<ServerException>());
          expect((result).exception.message, 'Fail to get locations');
        });

        test('should return an error when the assets request fails', () async {
          //Request Location should be ok
          when(() => clientHttp.get('/companies/$companyId/locations')).thenAnswer((_) async => Response(statusCode: HttpStatus.ok, headers: {}, data: assetsJson));      
          
          //Should fail Request Assets 
          when(() => clientHttp.get('/companies/$companyId/assets')).thenAnswer((_) async => Response(statusCode: HttpStatus.internalServerError, headers: {}, data: {'message': 'Fail to get assets'}));;

          final result = await repository.getAssets(companyId: '662fd0ee639069143a8fc387');
          expect((result as ErrorState).exception, isA<ServerException>());
          expect((result).exception.message, 'Fail to get assets');
        });
   });

    test('should return error when get assets, when exception is unknow', () async {
      when(() => clientHttp.get(any())).thenThrow(Exception());
      final result = await repository.getAssets(companyId: '662fd0ee639069143a8fc387');
      expect(result, isA<ErrorState>());
      expect((result as ErrorState).exception.message, 'Desculpe, houve uma falha interna em nossos serviços, contacte o suporte!');
    });

    test('should return error when trying to get assets but the id is empty', () async {
      when(() => clientHttp.get(any())).thenAnswer((_) async => Response(statusCode: HttpStatus.notFound, headers: {}, data: {'message':'Ohhh no. Theres nothing here...'}));   
      final result = await repository.getAssets(companyId: '');
      expect(result, isA<ErrorState>());
    });

  });




  group('TractianAssetsRepositoryImpl get Companies', () {  


    test('should return success when get companies', () async {
      when(() => clientHttp.get('/companies')).thenAnswer((_) async => Response(statusCode: HttpStatus.ok, headers: {}, data: companiesJson));
      final result = await repository.getCompanies();
      expect(result, isA<SuccessCompaniesState>());
    });

    test('should return an error when the server fails to get the companies', () async {
      when(() => clientHttp.get('/companies')).thenAnswer((_) async => Response(statusCode: HttpStatus.internalServerError, headers: {}, data: {'message': 'Falha no servidor 123456'}));
      final result = await repository.getCompanies();
      expect((result as ErrorCompaniesState).exception, isA<ServerException>());
      expect((result).exception.message, 'Falha no servidor 123456');
    });

    test('should return error when get companies, when exception is unknow', () async {
      when(() => clientHttp.get(any())).thenThrow(Exception());
      final result = await repository.getCompanies();
      expect(result, isA<ErrorCompaniesState>());
      expect((result as ErrorCompaniesState).exception.message, 'Desculpe, houve uma falha interna em nossos serviços, contacte o suporte!');
    });

  });



}