import 'package:tractian_challenge/app/modules/assets/interactor/controllers/tree_node_controller.dart';

class TreeNodeEntity {
  final String name;
  final Type type;
  final String id;
  final String? status;
  List<TreeNodeEntity> children;
  bool isLoaded;
  bool isExpanded;
  bool isChildren;

  TreeNodeEntity({
    required this.type,
    required this.name,
    required this.id,
    this.isExpanded = false,
    this.status,
    this.children = const [],
    this.isLoaded = false,  this.isChildren = false,
  });

  // Método para carregar filhos (se ainda não carregados)
  Future<void> loadChildren(TreeNodeController controller) async {
    if (!isLoaded) {
      children = await controller.loadChildrenForNode(id);
      isLoaded = true;
    }
  }
}

enum Type {
  location, asset, component;

  String get name {
    switch (this) {
      case location:
        return 'location';
      case asset:
        return 'asset';
      case component:
        return 'component';
    }
  }


}