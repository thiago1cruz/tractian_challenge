import 'asset_entity.dart';

class LocationEntity {
  final String id;
  final String name;
  final String? parentId;
  List<LocationEntity> subLocations = [];
  List<AssetEntity> assets = [];
  bool isLoaded = false;

  LocationEntity({
    required this.id,
    required this.name,
    required this.parentId,
  });

  String? get status => null;
}