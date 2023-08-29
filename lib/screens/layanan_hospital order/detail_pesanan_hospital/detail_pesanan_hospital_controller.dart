import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DetailPesananHospitalController extends GetxController {

  RxString tanggalRiset = ''.obs;
  RxString imageUrl = "".obs;
  // ignore: prefer_typing_uninitialized_variables
  var files;
  final ImagePicker _picker = ImagePicker();




  pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: Get.context!,
        initialDate: DateTime.now(),
        firstDate: DateTime(1800),
        lastDate: DateTime(2101));
    if (pickedDate != null) {
      // ignore: avoid_print
      print(pickedDate);
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      // ignore: avoid_print
      print(formattedDate);
      tanggalRiset.value = formattedDate;
      log(tanggalRiset.value);
    }
  }

  void pickerFilesImage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.photo),
                title: const Text("Photo"),
                onTap: () async{
                  //    if (await Permission.storage.request().isGranted) {
                  // }
                  takePhoto(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text("Camera"),
                onTap: () {
                  takePhoto(ImageSource.camera);
                  Get.back();
                },
              )
            ],
          );
        });
  }
  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;
     files = File(image.path);
     imageUrl.value = files.toString();
    return file;
  }
}
