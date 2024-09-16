import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/app/core/client/i_client_http.dart';
import 'package:tractian_challenge/app/core/client/rest_client_dio_impl.dart';

class CoreModule extends Module {

   @override
  void exportedBinds(Injector i) {  
    i.addInstance<Dio>(DioFactory.dio());
    i.add<IClientHttp>(RestClientDioImpl.new); 
  }

}