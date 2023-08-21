import 'dart:convert';
import 'dart:developer';
import 'package:bionmed_app/constant/string.dart';
import 'package:bionmed_app/screens/profile_doctor/detail_profile_doctor_umum.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

class ApiHome {
  Future<dynamic> getService() async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}services'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getSplash() async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}splashscreen'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getArticel() async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}article'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getSpecialist() async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}specialist'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getHospital() async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}hospital'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getDoctor() async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}doctor'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getDoctorDetail({required String id}) async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}doctor/$id'),
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

  Future<dynamic> getPriceByServiceId(
      {required String id, required String idDoctor}) async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}service-price/$id/$idDoctor'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );
    if (response.statusCode == 200) {
      Get.to(() => const DetailProfileDoctorUmum());
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else if (response.statusCode == 201) {
      showPopUp(
          onTap: () {
            Get.back();
          },
          description: "Price doctor not available");
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getDoctorByServiceId(
      {required String id,
      String? day,
      String? jam,
      String? spesialist}) async {
    // ignore: unused_local_variable
    String urls = '${MainUrl.urlApi}doctor/service/$id?';
    if (day != null) {
      urls = '${urls}day=$day';
    }

    if (spesialist != null) {
      urls = '$urls&specialistId=$spesialist';
    }

    log(urls);
    final response = await http.get(
      Uri.parse(urls),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getDoctorBySpesialisId({required String id}) async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}doctor/specialist/$id'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getBanner() async {
    final response = await http.get(
      Uri.parse('${MainUrl.urlApi}banner'),
      headers: <String, String>{
        'Accept': 'application/json',
        'Content-Type': 'application/json; charset=UTF-8',
        'Connection': 'keep-alive',
      },
    );

    if (response.statusCode == 200) {
      final String responseString = response.body;
      return jsonDecode(responseString);
    } else {
      throw response.reasonPhrase.toString();
    }
  }

  Future<dynamic> getNotif() async {
    try {
      var id = await GetStorage().read('id');
      var token = await GetStorage().read('token');
      final response = await http.post(
        Uri.parse('${MainUrl.urlApi}inbox/customer/$id'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
          'Authorization': "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final String responseString = response.body;
        return jsonDecode(responseString);
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }

  Future<dynamic> readNotif({required String id}) async {
    try {
      var token = await GetStorage().read('token');
      final response = await http.post(
        Uri.parse('${MainUrl.urlApi}inbox/read/$id'),
        headers: <String, String>{
          'Accept': 'application/json',
          'Content-Type': 'application/json; charset=UTF-8',
          'Connection': 'keep-alive',
          'Authorization': "Bearer $token"
        },
      );
      if (response.statusCode == 200) {
        final String responseString = response.body;
        return jsonDecode(responseString);
      } else {
        throw response.reasonPhrase.toString();
      }
    } catch (err) {
      // ignore: avoid_print
      print(err.toString());
    }
  }
}
