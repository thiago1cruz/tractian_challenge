class AssetEntity {
  final String id;  
  final String name;
  final String? locationId;
  final String? parentId;
  final String? gatewayId;
  final String? sensorId;
  final String? sensorType;
  final String? status;  
  List<AssetEntity> subAssets = [];
  bool isLoaded = false;

  AssetEntity({
    required this.id,    
    required this.name,
    this.locationId,
    this.parentId,
    this.gatewayId,
    this.sensorId,
    this.sensorType,
    this.status,    
  });

   factory AssetEntity.fromJson(Map<String, dynamic> json) {
    return AssetEntity(
      id: json['id'],
      name: json['name'],
      locationId: json['locationId'],
      parentId: json['parentId'],
      sensorId: json['sensorId'],
      sensorType: json['sensorType'],
      status: json['status'],
      gatewayId: json['gatewayId'],
    );
  }
}