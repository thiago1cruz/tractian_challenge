import 'package:flutter/material.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/tree_node_controller.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/tree_node_entity.dart';

class TreeNodeWidget extends StatefulWidget {
  final TreeNodeEntity node;
  final TreeNodeController treeNodeController;
  const TreeNodeWidget({super.key, required this.node, required this.treeNodeController});

  @override
  State<TreeNodeWidget> createState() => _TreeNodeWidgetState();
}

class _TreeNodeWidgetState extends State<TreeNodeWidget> {
  bool _isExpanded = false;
  bool _isLoading = false;
  late final TreeNodeEntity _node;
  late final TreeNodeController _treeController;

  @override
  void initState() {
    super.initState();
    _treeController = widget.treeNodeController;
    _node = widget.node;
    _isExpanded = _node.isExpanded;
    _isLoading = _node.isLoaded;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () async {
              if (!_isLoading) {
                setState(() {
                  _isLoading = true;
                });
                List<TreeNodeEntity> children = await _treeController.loadChildrenForNode(_node.id);
                setState(() {
                  _node.children = children;
                  _isExpanded = !_isExpanded;
                  _isLoading = false;
                });
              } else {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Row(
                children: [
                  if (_node.isChildren || _node.children.isNotEmpty)
                    Icon(
                      _isExpanded ? Icons.expand_less : Icons.expand_more,
                      size: 16,
                    ),
                  const SizedBox(width: 8),
                  Image.asset('assets/icons/${_node.type.name}.png', width: 18),
                  const SizedBox(width: 8),
                  Text(_node.name, style: textTheme.titleSmall,),
                  const SizedBox(width: 8),
                  if (_node.status != null)
                    _getIconStatus(_node.status!),
                ],
              ),
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _node.children.length,
                itemBuilder: (context, index) {
                  return TreeNodeWidget(
                    node: _node.children[index],
                    treeNodeController: _treeController,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _getIconStatus(String status) {
    return switch (status) {
      'operating' => Image.asset( 'assets/icons/bolt_01.png',),      
      'alert' => Image.asset( 'assets/icons/elipse.png',),
      _ => const SizedBox(),
    };
  }
}