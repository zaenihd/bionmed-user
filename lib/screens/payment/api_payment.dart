import 'dart:convert';
import 'dart:developer';

import 'package:bionmed_app/constant/string.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiPayment {
  final box = GetStorage();

  Future<dynamic> order({
    required int customerId,
    required String districts,
    required String city,
    required String province,
    required String country,
    required double lat,
    required double long,
    required int serviceId,
    required int servicePriceId,
    required String startDate,
    required int doctorId,
    required String date,
    required int totalPrice,
    required int discount,
    required int doctorScheduleId,
  }) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      String url = MainUrl.urlApi + 'order';
      final payload = <String, dynamic>{
        "customerId": customerId,
        "districts": districts,
        "city": city,
        "province": province,
        "country": country,
        "lat": lat,
        "long": long,
        "serviceId": serviceId,
        "servicePriceId": servicePriceId,
        "startDate": startDate,
        "doctorId": doctorId,
        "status": 0,
        "date": date,
        "totalPrice": totalPrice,
        "discount": discount,
        "postal_code": "",
        "doctorScheduleId" : doctorScheduleId,
      };
      var token = await box.read('token');

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
      // ignore: prefer_interpolation_to_compose_strings, avoid_print
      print("err : " + e.toString());
      rethrow;
    }
  }

  Future<dynamic> orderAddVoucher({
    required int orderId,
    required int voucherId,
  }) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      String url = MainUrl.urlApi + 'order/voucher';
      final payload = <String, dynamic>{
        "orderId": orderId,
        "voucherId": voucherId
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

  Future<dynamic> createVa({
    required String codeOrder,
    required String codeBank,
  }) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      String url = MainUrl.urlApi + 'order/espay/create/VA';
      final payload = <String, dynamic>{
        "codeOrder": codeOrder,
        "codeBank": codeBank
      };
      var token = await box.read('token');
      log('code $codeOrder');
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
        Get.defaultDialog(title: data['code'].toString(), middleText: data['message'].toString());
        return data;
        
      }
    } catch (e) {
      // ignore: prefer_interpolation_to_compose_strings, avoid_print
      print("err : " + e.toString());
      rethrow;
    }
  }

  Future<dynamic> getServicePrice(
      {required String idService, required String idDoctor}) async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}package/$idService/$idDoctor'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> findVoucher({
    required String code,
    required double lat,
    required double long,
  }) async {
    try {
      // ignore: prefer_interpolation_to_compose_strings
      String url = MainUrl.urlApi + 'voucher';
      final payload = <String, dynamic>{"code": code, "lat": lat, "long": long};
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
