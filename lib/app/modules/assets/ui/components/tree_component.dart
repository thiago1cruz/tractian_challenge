import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/core/constants/app_dimensions.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/tree_node_entity.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/tree_node_state.dart';
import 'package:tractian_challenge/app/modules/assets/ui/widgets/tree_node_widget.dart';

import '../../interactor/controllers/tree_node_controller.dart';

class TreeComponent extends StatefulWidget {
  final TreeNodeController treeController;
  const TreeComponent({super.key, required this.treeController});

  @override
  State<TreeComponent> createState() => _TreeComponentState();
}

class _TreeComponentState extends State<TreeComponent> {
  String? selectedStatus;
  late Future<List<TreeNodeEntity>> futureTreeData;
  @override
  void initState() {
    super.initState();
     widget.treeController.loadTreeData();
    widget.treeController.addListener(updateState);
  }

  @override
  void dispose() {
   widget.treeController.removeListener(updateState);
    super.dispose();
  }


  void updateState(){
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.treeController.state;
    return switch(state){
      LoadingTreeNodeState() => const Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: AppDimensions.defaultPadding),
              Text('Construindo arvore...'),
            ],
          )),

        ErrorTreeNodeState(exception: final e) => Center(child: Text('Error: ${e.message}')),

        SuccessTreeNodeState(data: final d) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: d
                  .map((e) => TreeNodeWidget(
                      node: e, treeNodeController: widget.treeController))
                  .toList(),
            ),
          ),

          _ => Container()
    };        
   
  }
}
