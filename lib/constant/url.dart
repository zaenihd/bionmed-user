// ignore_for_file: constant_identifier_names, avoid_print

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';

enum Method { POST, GET, PUT, DELETE, PATCH }

// const BASE_URL = "http://108.137.148.166/api/"; //dev
// const BASE_URL = "https://bionmed.online/api/"; //test
const BASE_URL = "https://bionmed.id/api/"; //prod

class RestClient extends GetxService {
  Dio _dio = Dio();

  //this is for header
  static header() => {
        'Content-Type': 'application/json',
      };

  Future<RestClient> init() async {
    _dio = Dio(BaseOptions(baseUrl: BASE_URL, headers: header()));
    initInterceptors();
    return this;
  }

  void initInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      print('REQUEST[${options.method}] => PATH: ${options.path} '
          '=> Request Values: ${options.queryParameters}, => HEADERS: ${options.headers}');
      return handler.next(options);
    }, onResponse: (response, handler) {
      print('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
      return handler.next(response);
    }, onError: (err, handler) {
      print('ERROR[${err.response?.statusCode}]');
      return handler.next(err);
    }));
  }

  Future<dynamic> request(
      String url, Method method, Map<String, dynamic>? params) async {
    Response response;
    print("Cek : $url");
    print("Cek : $params");
    try {
      if (method == Method.POST) {
        print("masuk sini");
        response = await _dio.post(
          url,
          data: params,
          options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            },
            headers: header(),
          ),
        );
      } else if (method == Method.DELETE) {
        response = await _dio.delete(url);
      } else if (method == Method.PATCH) {
        response = await _dio.patch(url);
      } else {
        response = await _dio.get(
          url,
          queryParameters: params,
        );
      }
      print("Cek sini yaaa: $response");

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized");
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else {
        throw Exception("Something Went Wrong");
      }
    // ignore: unused_catch_clause
    } on SocketException catch (e) {
      throw Exception("No Internet Connection");
    } on FormatException {
      throw Exception("Bad Response Format!");
    } on DioError catch (e) {
      throw Exception(e);
    } catch (e) {
      throw Exception("Something Went Wrong");
    }
  }
}

// required package imports
// import 'dart:async';
// import 'package:sqflite/sqflite.dart' as sqflite;
// import 'package:floor/floor.dart';

// import 'package:clean_architecture/core/database/dao/person_dao.dart';
// import 'package:clean_architecture/core/database/entity/person.dart';

// part 'database.g.dart';

// @Database(version: 1, entities: [Person])
// abstract class AppDb extends FloorDatabase {
//   PersonDao get personDao;

//   static Future<AppDb> init() async {
//     AppDb instance = await $FloorAppDb.databaseBuilder("db_name").build();
//     return instance;
//   }
// }