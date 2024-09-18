import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/app/core/core_module.dart';
import 'package:tractian_challenge/app/modules/assets/data/repositories/tractian_assets_repository_impl.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/repositories/I_assets_repository.dart';
import 'package:tractian_challenge/app/modules/assets/ui/pages/assets_page.dart';
import 'package:tractian_challenge/app/modules/assets/ui/pages/choose_company_page.dart';

import 'interactor/controllers/assets_controller.dart';

class AssetsModule extends Module {

  @override
  void binds(Injector i) {
    i.add(AssetsController.new, config: BindConfig(onDispose: (AssetsController c) => c.dispose()));
    i.add<IAssetsRepository>(TractianAssetsRepositoryImpl.new);
    super.binds(i);
  }

  @override
  List<Module> get imports => [CoreModule()];

  
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) =>  ChooseCompanyPage(controller: Modular.get<AssetsController>()));
    r.child('/assets', child: (context) => AssetsPage(controller: Modular.get<AssetsController>(), companyId: r.args.data,));
    super.routes(r);
  }

}