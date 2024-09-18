import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/constants/app_dimensions.dart';
import 'package:tractian_challenge/app/core/ui/themes/thme_ligth.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/assets_controller.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/tree_node_controller.dart';
import 'package:tractian_challenge/app/modules/assets/ui/components/filter.dart';
import 'package:tractian_challenge/app/modules/assets/ui/components/tree_component.dart';
import '../../interactor/states/assets_state.dart';

class AssetsPage extends StatefulWidget {
  final AssetsController controller;
  final String? companyId;

  const AssetsPage(
      {super.key, required this.controller, required this.companyId});

  @override
  State<AssetsPage> createState() => _AssetsPageState();
}

class _AssetsPageState extends State<AssetsPage> {
  late final AssetsController controller;
  late final String idCompany;
  TreeNodeController? treeController;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;
    idCompany = widget.companyId ?? '';
    controller.getAssets(companyId: idCompany);
    controller.addListener(updateState);
  }

  @override
  void dispose() {
    controller.removeListener(updateState);
    super.dispose();
  }

  updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final color = TractianColors.of(context);
    final state = controller.assetsState;
    if (state is SuccessState){
      treeController = TreeNodeController(locations: state.data.locations, assets:  state.data.assets);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Assets',
            style: textTheme.titleLarge!
                .copyWith(color: color.white, fontWeight: FontWeight.w400)),
      ),
      body: Column(
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.defaultPadding),
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(color: color.grey, width: 0.3))),
                child: Filter(
                  controller: treeController,                
                ),
              ),
            ],
          ),
          if (state is LoadingState)
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(
                    height: AppDimensions.defaultPadding,
                  ),
                  Text('Buscando Ativos...'),
                ],
              ),
            ),
          if (state is ErrorState)
            Expanded(
                child: Center(
                    child: Padding(
              padding: const EdgeInsets.all(AppDimensions.extraLargePadding),
              child: Text(state.exception.message),
            ))),
          if (state is SuccessState)
            Expanded(child: Builder(
              builder: (context) {                 
                return TreeComponent(treeController: treeController!);
              }
            ))
        ],
      ),
    );
  }
}
