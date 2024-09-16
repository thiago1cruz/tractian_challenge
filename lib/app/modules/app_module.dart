import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/app/core/core_module.dart';
import 'package:tractian_challenge/app/core/ui/pages/splash_screen.dart';
import 'package:tractian_challenge/app/modules/assets/assets_module.dart';

class AppModule extends Module  {

  @override
  List<Module> get imports => [CoreModule()];

  @override
  void routes(r) {
    r.child('/', child: (context) => const SpalshScreen());
    r.module('/assts', module: AssetsModule());   
  }

}