import 'package:flutter_test/flutter_test.dart';
import 'package:tractian_challenge/app/modules/assets/data/repositories/adapters/assets_adapter.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/controllers/tree_node_controller.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/tree_node_entity.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/states/tree_node_state.dart';
import '../../data/repositories/mocks/assets.dart';
import '../../data/repositories/mocks/location.dart';

void main() {

late  TreeNodeController controller;

setUp((){
final assetAdapter = AssetsAdapter.fromJson(assetsJson, locationJson);
controller = TreeNodeController(locations: assetAdapter.locations, assets: assetAdapter.assets);

});





  group('TreeNodeController', () {
    test('should verify the verify the stages of TreeNodeState: initial, loading, success', ()async {
     expect(controller.state, isA<InitialTreeNodeState>());
     final treedata = controller.loadTreeData();     
      expect(controller.state, isA<LoadingTreeNodeState>());
      await treedata;
      expect(controller.state, isA<SuccessTreeNodeState>());
    });
    // test('should verify the verify the stages of TreeNodeState: initial, loading, success', ()async {
    //       final stateStream = StreamController<TreeNodeState>();
    
    //   controller.addListener(() {
    //     stateStream.add(controller.state);
    //   });

    //   final stateQueue = StreamQueue(stateStream.stream);

    //   expect(controller.state, isA<InitialTreeNodeState>());     
    //   controller.loadTreeData();     
    //   expect(await stateQueue.next, isA<LoadingTreeNodeState>());
    //   expect(await stateQueue.next, isA<SuccessTreeNodeState>());
    //   await stateQueue.cancel();
    //   await stateStream.close();
    // });
  });


  group('Test function loadChildrenForNode', (){      
        test('should  return List<TreeNodeEntity> when calling loadChildrenForNode', () async {
          final List<TreeNodeEntity> children = await controller.loadChildrenForNode('65674204664c41001e91ecb4');
          expect(children, isA<List<TreeNodeEntity>>());     
      });

      test('should return a list of TreeNodeEntity with length 1 when loading children for the node with ID "65674204664c41001e91ecb4"', () async {
          final List<TreeNodeEntity> children = await controller.loadChildrenForNode('65674204664c41001e91ecb4');     
          expect(children.length, 1);
      });

      test('should return TreeNodeEntity with ID "656a07b3f2d4a1001e2144bf"', () async {
          final List<TreeNodeEntity> children = await controller.loadChildrenForNode('65674204664c41001e91ecb4');     
          expect(children.first.id, '656a07b3f2d4a1001e2144bf');
      });

      test('shouldreturn empty list when ID does not exist', () async {
          final List<TreeNodeEntity> children = await controller.loadChildrenForNode('12232332332323233332b');     
          expect(children, isEmpty);
      });
  });


  test('should return a list of AssetEntity with length 1 when filtering assets by the name "Motor H12D-Stage 3"', () async {
    final filteredAssets = await controller.filterAssetsByName('Motor H12D-Stage 3');
    expect(filteredAssets.length, 1);
    expect(filteredAssets.first.id, '656733921f4664001f295e9b');
  });


  group('Test function loadChildrenForFilteredAssets', (){

    test('should load a list of children for the assets filtered by the name "Motor H12D-Stage 3"', () async {
      final filteredAssets = await controller.filterAssetsByName('Motor H12D-Stage 3');
     await controller.loadChildrenForFilteredAssets(filteredAssets);
      expect((controller.state as SuccessTreeNodeState).data, isA<List<TreeNodeEntity>>());
    });

  });
  
}

