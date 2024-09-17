import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/errors/failures.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/repositories/I_assets_repository.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/assets_state.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/companie_state.dart';

class AssetsController extends ChangeNotifier {

  final IAssetsRepository _repository;

  AssetsController(this._repository);


CompaniesState companiesState = InitialCompaniesState();

void setCompaniesStae(CompaniesState value ){
  companiesState = value;
  notifyListeners();
}

AssetsState assetsState = InitialState();

void setAssetsState(AssetsState value){
  assetsState = value;
  notifyListeners();
}


Future getCompanies() async{
  setCompaniesStae(LoadingCompaniesState());
  final result = await _repository.getCompanies();
  setCompaniesStae(result);
}


Future getAssets({required companyId}) async{
  if(companyId == null){
    setAssetsState(ErrorState(exception: ParametersEmptyError(message: 'Company ID is required')));
    return;
  }
  setAssetsState(LoadingState());
  final result = await _repository.getAssets(companyId: companyId);
  setAssetsState(result);
}

}