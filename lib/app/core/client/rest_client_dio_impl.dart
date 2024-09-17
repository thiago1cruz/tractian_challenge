import 'package:dio/dio.dart' as http;
import 'package:tractian_challenge/app/core/constants/api_routes.dart';
import 'package:tractian_challenge/app/core/errors/failures.dart';


import 'i_client_http.dart';

class DioFactory {    
  static http.Dio dio() {
     final baseOptions = http.BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: configTimeout),
      receiveTimeout: const Duration(seconds: configReceiveTimeout),   
      receiveDataWhenStatusError: true,
      followRedirects: true,      
    );

    var dio = http.Dio(baseOptions);   
       return dio;
  }
}

class RestClientDioImpl implements IClientHttp {
  final http.Dio _dio;

  RestClientDioImpl(this._dio);

  @override
  Future<Response<dynamic>> get(String url,
      {Map<String, dynamic>? queryParameters,
      Map<String, String>? headers}) async {
    try {
      final response = await _dio.get(url,
          options: http.Options(
            headers: headers,           
          ));
      return Response(
        statusCode: response.statusCode ?? 500,
        headers: response.headers.map,
        data: response.data,
      );
    } on http.DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> post(String url, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final response = await _dio.post(url,
          data: body,          
          options: http.Options(
            headers: headers,
            // responseType: http.ResponseType.json,
          ));
      return Response(
        statusCode: response.statusCode ?? 500,
        headers: response.headers.map,
        data: response.data,
      );
    } on http.DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> postFormData(String url, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final data = http.FormData.fromMap(body);
      final response = await _dio.post(url,
          data: data,
          options: http.Options(
            headers: headers,
            // responseType: http.ResponseType.json,
          ));
      return Response(
        statusCode: response.statusCode ?? 500,
        headers: response.headers.map,
        data: response.data,
      );
    } on http.DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> put(String url, dynamic body,
      {Map<String, String>? headers}) async {
    try {
      final response = await _dio.put(url,
          data: body,
          options: http.Options(
            headers: headers,
            // responseType: http.ResponseType.json,
          ));
      return Response(
        statusCode: response.statusCode ?? 500,
        headers: response.headers.map,
        data: response.data,
      );
    } on http.DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  @override
  Future<Response<dynamic>> delete(String url,
      {Map<String, String>? headers}) async {
    try {
      final response = await _dio.delete(url,
          options: http.Options(
            headers: headers,
            // responseType: http.ResponseType.json,
          ));
      return Response(
        statusCode: response.statusCode ?? 500,
        headers: response.headers.map,
        data: response.data,
      );
    } on http.DioException catch (e) {
      return _handleError(e);
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Response _handleError(http.DioException e) {
    if (e.response != null) {
      return Response(
          statusCode: e.response?.statusCode ?? 500,
          headers: e.response?.headers.map ?? {},
          data: e.response?.data);
    } else if (http.DioExceptionType.receiveTimeout == e.type) {
      throw DataSourceError(message: 'Tempo de solicitação esgotado');
    }
    throw DataSourceError(message: e.message ?? '');
  }
}
