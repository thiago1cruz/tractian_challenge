import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/tree_node_entity.dart';
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
    futureTreeData = widget.treeController.loadTreeData();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TreeNodeEntity>>(
      future: futureTreeData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: snapshot.data!
                  .map((e) => TreeNodeWidget(
                      node: e, treeNodeController: widget.treeController))
                  .toList(),
            ),
          );
        }
      },
    );
  }
}
