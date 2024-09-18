import 'package:tractian_challenge/app/modules/assets/interactor/entities/tree_node_entity.dart';
import '../entities/asset_entity.dart';
import '../entities/location_entity.dart';
import 'package:async/async.dart';

class TreeNodeController {
  TreeNodeController(
      {required List<LocationEntity> locations,
      required List<AssetEntity> assets}) {
    _locations = locations;
    _assets = assets;
    _initialize();
  }

  late List<LocationEntity> _locations;
  late List<AssetEntity> _assets;

  late TreeBuilder _treeBuilder;

  Future<void> _initialize() async {
    _treeBuilder = TreeBuilder(locations: _locations, assets: _assets);
    _treeBuilder.buildTree();
  }

  CancelableOperation<List<AssetEntity>>? _cancellableOperation;

  Future<List<TreeNodeEntity>> loadTreeData() async {
    List<TreeNodeEntity> rootNodes = [
      ..._locations.where((e) => e.parentId == null).map(_convertToTreeNode),
      ..._treeBuilder.orphanAssets.map(_convertToTreeNodeFromAsset),
    ];

    return rootNodes;
  }

  Future<List<TreeNodeEntity>> loadChildrenForNode(String nodeId) async {
    LocationEntity? parentLocation = _treeBuilder.getLocationById(nodeId);
    AssetEntity? parentAsset = _treeBuilder.getAssetById(nodeId);

    List<TreeNodeEntity> children = [
      ...parentLocation?.subLocations.map(_convertToTreeNode) ?? [],
      ...parentLocation?.assets.map(_convertToTreeNodeFromAsset) ?? [],
      ...parentAsset?.subAssets.map(_convertToTreeNodeFromAsset) ?? [],
    ];

    return children;
  }

  Future<List<TreeNodeEntity>> loadChildrenForFilteredAssets(
      List<AssetEntity> filteredAssets) async {
    final Map<String, TreeNodeEntity> nodeMap = {};

    void buildTreeRecursively(AssetEntity asset) {
      if (nodeMap.containsKey(asset.id)) return;

      var leafNode = _convertToTreeNodeFromAsset(asset);
      nodeMap[asset.id] = leafNode;

      if (asset.parentId != null) {
        if (_treeBuilder.getAssetById(asset.parentId!) != null) {
          var parentAsset = _treeBuilder.getAssetById(asset.parentId!)!;
          buildTreeRecursively(parentAsset);
          nodeMap[parentAsset.id]!.children.add(leafNode);
        } else if (_treeBuilder.getLocationById(asset.parentId!) != null) {
          var parentLocation = _treeBuilder.getLocationById(asset.parentId!)!;
          if (!nodeMap.containsKey(parentLocation.id)) {
            nodeMap[parentLocation.id] = _convertToTreeNode(parentLocation);
          }
          nodeMap[parentLocation.id]!.children.add(leafNode);
        }
      } else if (asset.locationId != null) {
        var location = _treeBuilder.getLocationById(asset.locationId!);
        if (location != null) {
          if (!nodeMap.containsKey(location.id)) {
            nodeMap[location.id] = _convertToTreeNode(location);
          }
          nodeMap[location.id]!.children.add(leafNode);
        }
      }
    }

    for (var asset in filteredAssets) {
      buildTreeRecursively(asset);
    }

    for (var node in nodeMap.values) {
      node.isLoaded = true;
      node.isExpanded = true;
    }

    List<TreeNodeEntity> rootNodes = nodeMap.values
        .where((node) =>
            nodeMap.values.every((parent) => !parent.children.contains(node)))
        .toList();

    return rootNodes;
  }

  TreeNodeEntity _convertToTreeNode(LocationEntity item) {
    return TreeNodeEntity(
      type: Type.location,
      status: item.status,
      name: item.name,
      children: [],
      isChildren: item.subLocations.isNotEmpty || item.assets.isNotEmpty,
      isLoaded: false,
      isExpanded: false,
      id: item.id,
    );
  }

  TreeNodeEntity _convertToTreeNodeFromAsset(AssetEntity asset) {
    return TreeNodeEntity(
      name: asset.name,
      status: asset.status,
      type: asset.subAssets.isNotEmpty ? Type.asset : Type.component,
      children: [],
      isLoaded: false,
      isExpanded: false,
      isChildren: asset.subAssets.isNotEmpty,
      id: asset.id,
    );
  }
}

class TreeBuilder {
  final List<LocationEntity> locations;
  final List<AssetEntity> assets;
  late Map<String, LocationEntity> locationMap;
  late Map<String, AssetEntity> assetMap;
  final List<AssetEntity> orphanAssets = [];

  TreeBuilder({
    required this.locations,
    required this.assets,
  });

  void buildTree() {
    locationMap = {for (var loc in locations) loc.id: loc};
    assetMap = {for (var asset in assets) asset.id: asset};

    for (var location in locationMap.values) {
      location.subLocations = [];
      location.assets = [];
    }

    for (var asset in assetMap.values) {
      if (asset.locationId != null) {
        locationMap[asset.locationId]?.assets.add(asset);
      } else if (asset.parentId != null) {
        assetMap[asset.parentId]?.subAssets.add(asset);
      } else {
        orphanAssets.add(asset);
      }
    }

    for (var location in locationMap.values) {
      if (location.parentId != null) {
        locationMap[location.parentId]?.subLocations.add(location);
      }
    }
  }

  LocationEntity? getLocationById(String id) {
    return locationMap[id];
  }

  AssetEntity? getAssetById(String id) {
    return assetMap[id];
  }
}
