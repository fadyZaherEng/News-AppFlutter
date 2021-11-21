 import 'package:dio/dio.dart';

class dioHelper {
 static late Dio dio;

 static init(){
    dio=Dio(
      BaseOptions(
        baseUrl:'https://newsapi.org/v2/',
        receiveDataWhenStatusError: true,
        connectTimeout:5000,
        receiveTimeout:5000,
      ),
    );
  }

 static Future<Response> getData({
  required String completePath,
  required Map<String, dynamic> queryParameters,
  }){
   return dio.get(completePath,queryParameters: queryParameters);
  }

}