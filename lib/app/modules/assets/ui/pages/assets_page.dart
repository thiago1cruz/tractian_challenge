import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/assets_controller.dart';

class AssetsPage extends StatefulWidget {
   final AssetsController controller;
   final String? idCompany;
   
  const AssetsPage({super.key, required this.controller, required this.idCompany});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late final AssetsController controller;
   late final String idCompany;

   @override
  void initState() {    
    super.initState();
    controller = widget.controller;
    idCompany = widget.idCompany ?? '';
  }
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}