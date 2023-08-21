// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:bionmed_app/constant/string.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;


class ApiPesanan {

  //UPDATE STATUS TIMER UNTUK CHAT
  
  Future<dynamic> automaticStatus() async {
    try {
      var id = await GetStorage().read('id');
      // ignore: prefer_interpolation_to_compose_strings
      String url = MainUrl.urlApi + 'order/automatic/update/status';
      final payload = <String, dynamic>{
        "customerId": int.parse(id),
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
    // ignore: duplicate_ignore
    } catch (e) {
      print("err : $e");
      rethrow;
    }
  }

  Future<dynamic> updateStatus(
      {required int status, required String idOrder}) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      String url = MainUrl.urlApi + 'order/update/status/$idOrder';
      final payload = <String, dynamic>{
        "status": status,
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
      print("err : $e");
      rethrow;
    }
  }

  Future<dynamic> ratingDoctor(
      {required int rating,
      required String descriptionRating,
      required String idOrder}) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      String url = MainUrl.urlApi + 'order/add/rating/$idOrder';
      final payload = <String, dynamic>{
        "rating": rating,
        "description_rating": descriptionRating
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
      print("err : $e");
      rethrow;
    }
  }

  Future<dynamic> updateOrder(
      {required String name,
      required String age,
      required String gender,
      required String phoneNumber,
      required String address,
      required String description,
      required int idOrder}) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      String url = MainUrl.urlApi + 'order/update/data/$idOrder';
      final payload = <String, dynamic>{
        "name": name,
        "age": age,
        "gender": gender,
        "phoneNumber": phoneNumber,
        "address": address,
        "description": description
      };
      print("payload : $payload");
      final response = await http.post(
        Uri.parse(url),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
        },
        body: jsonEncode(payload),
      );
      print("payload : ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      } else {
        Map<String, dynamic> data = jsonDecode(response.body);
        return data;
      }
    } catch (e) {
      print("err : $e");
      rethrow;
    }
  }
}
