import 'dart:convert';

import 'package:bionmed_app/constant/string.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiRegister {
  final box = GetStorage();

  Future<dynamic> registerApp(
      {required String name,
      required String brithdayDate,
      required String address,
      required String phoneNumber}) async {
    try {
      String url = '${MainUrl.urlApi}register';
      final payload = <String, dynamic>{
        "name": name,
        "brithdayDate": brithdayDate,
        "address": address,
        "phoneNumber": phoneNumber,
        "deviceId": box.read('deviceId')
      };

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
}
