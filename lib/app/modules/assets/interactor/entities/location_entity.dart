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

 factory LocationEntity.fromJson(Map<String, dynamic> json) {
    return LocationEntity(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

  String? get status => null;
}