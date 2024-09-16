import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/app/modules/assets/ui/pages/assets_page.dart';

class AssetsModule extends Module {

  
  @override
  void routes(RouteManager r) {
    r.child('/', child: (context) => const AssetsPage());
    super.routes(r);
  }

}