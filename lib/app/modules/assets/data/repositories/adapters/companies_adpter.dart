import 'package:tractian_challenge/app/modules/assets/interactor/entities/company_entity.dart';

class CompaniesAdpter  {

  static Company fromJson(Map<String, dynamic> json) {
    return Company(
      id: json['id'],
      name: json['name'],
    );
  }

}