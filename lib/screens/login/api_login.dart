import 'dart:convert';
import 'dart:developer';

import 'package:bionmed_app/constant/string.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiLogin {
  Future<dynamic> loginApps({required String phoneNumber}) async {
    try {
      String url = '${MainUrl.urlApi}login';

      final payload = <String, dynamic>{"phoneNumber": phoneNumber};

      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      // ignore: avoid_print
      print("err : $e");
      rethrow;
    }
  }

  Future<dynamic> getOrder({required int status}) async {
    try {
      var id = await GetStorage().read('id');
      var token = await GetStorage().read('token');
      String url = '${MainUrl.urlApi}order/status';
      // ignore: prefer_typing_uninitialized_variables
      var payload;
      log('zaeni ID :$id');

      if (status == 0) {
        payload = <String, dynamic>{
          "filter": [
            {"customerId": id}
          ]
        };
      } else {
        payload = <String, dynamic>{
          "filter": [
            {"customerId": id, "status": status}
          ]
        };
      }
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(payload),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      // ignore: avoid_print
      print("err : $e");
      rethrow;
    }
  }

  Future<dynamic> registerTokenFirebase(String token, String id) async {
    try {
      final payload = <String, String>{
        "deviceId": token,
      };
      String url = '${MainUrl.urlApi}user-device/$id';

      final response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Accept': 'application/json',
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(payload));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      rethrow;
    }
  }
}
