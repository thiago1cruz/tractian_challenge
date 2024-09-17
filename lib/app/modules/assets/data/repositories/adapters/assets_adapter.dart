import 'package:tractian_challenge/app/modules/assets/interactor/entities/assets.dart';


import '../../../interactor/entities/asset_entity.dart';
import '../../../interactor/entities/location_entity.dart';

class AssetsAdapter  {

  static Assets fromJson(List<Map<String, dynamic>> assetsJson, List<Map<String, dynamic>> locationsJson) {
    return Assets(
     assets: assetsJson.map(_fromJsonAssetEntity).toList(),
     locations: locationsJson.map(_fromJsonLocationEntity).toList(),
    );
  }

  static AssetEntity _fromJsonAssetEntity(Map<String, dynamic> json) {
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

  static LocationEntity _fromJsonLocationEntity(Map<String, dynamic> json) {
   return LocationEntity(
      id: json['id'],
      name: json['name'],
      parentId: json['parentId'],
    );
  }

}