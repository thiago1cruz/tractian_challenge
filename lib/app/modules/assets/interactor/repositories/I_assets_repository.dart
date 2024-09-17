
import '../states/assets_state.dart';
import '../states/companie_state.dart';

abstract interface class IAssetsRepository {

  Future<CompaniesState> getCompanies();

  Future<AssetsState> getAssets({required String companyId});

}