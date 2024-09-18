import 'dart:io';
import 'package:tractian_challenge/app/core/client/i_client_http.dart';
import 'package:tractian_challenge/app/core/constants/api_routes.dart';
import 'package:tractian_challenge/app/core/errors/failures.dart';
import 'package:tractian_challenge/app/modules/assets/data/repositories/adapters/assets_adapter.dart';
import 'package:tractian_challenge/app/modules/assets/data/repositories/adapters/companies_adpter.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/repositories/I_assets_repository.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/assets_state.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/companie_state.dart';

class TractianAssetsRepositoryImpl implements IAssetsRepository {
  final IClientHttp _clientHttp;

  TractianAssetsRepositoryImpl(this._clientHttp);

  @override
  Future<AssetsState> getAssets({required String companyId}) async {
    final locationsUrl = '/companies/$companyId$locations';
    final assetsUrl = '/companies/$companyId$assets';

    try {
      final result = await Future.wait(
          [_clientHttp.get(locationsUrl), _clientHttp.get(assetsUrl)]);

      final dataResilt = result.where(
        (result) => result.statusCode != HttpStatus.ok,
      );

      if (result[0].statusCode == HttpStatus.ok &&
          result[1].statusCode == HttpStatus.ok) {
        final assetsData = List<Map<String, dynamic>>.from(result[1].data);
        final locationData = List<Map<String, dynamic>>.from(result[0].data);

        final data = AssetsAdapter.fromJson(assetsData, locationData);
        return SuccessState(data: data);
      } else if (dataResilt.first.statusCode ==
          HttpStatus.internalServerError) {
        return ErrorState(
            exception: ServerException(
                message: dataResilt.first.data['message'] ??
                    'Desculpe, houve uma falha em nossos serviços'));
      }

      return ErrorState(
          exception: ServerException(
              message: dataResilt.first.data['message'] ??
                  'Desculpe, tente novamente mais tarde!'));
    } catch (e) {
      return ErrorState(
          exception: ServerException(
              message:
                  'Desculpe, houve uma falha interna em nossos serviços, contacte o suporte!'));
    }
  }

  @override
  Future<CompaniesState> getCompanies() async {
    try {
      final result = await _clientHttp.get(companies);

      if (result.statusCode == HttpStatus.ok) {
        final jsonData = result.data as List;
        final data =
            jsonData.map((map) => CompaniesAdpter.fromJson(map)).toList();
        return SuccessCompaniesState(data: data);
      } else if (result.statusCode == HttpStatus.internalServerError) {
        return ErrorCompaniesState(
            exception: ServerException(
                message: result.data['message'] ??
                    'Desculpe, houve uma falha em nossos serviços'));
      }

      return ErrorCompaniesState(
          exception: ServerException(
              message: result.data['message'] ??
                  'Desculpe, tente novamente mais tarde!'));
    } catch (e) {
      return ErrorCompaniesState(
          exception: ServerException(
              message:
                  'Desculpe, houve uma falha interna em nossos serviços, contacte o suporte!'));
    }
  }
}
