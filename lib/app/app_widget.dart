import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'core/ui/themes/thme_ligth.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

   @override
  Widget build(BuildContext context) {   
    return MaterialApp.router(       
        title: 'Traction Challenge',
        routerConfig: Modular.routerConfig,
        theme: lightTheme(context),       
        );
  }
}
