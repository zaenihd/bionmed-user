import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InputDataOrderHospitalController extends GetxController{
  TextEditingController tanggalC = TextEditingController();
  TextEditingController namaPasienC = TextEditingController();
  TextEditingController umurPasienC = TextEditingController();
  TextEditingController keluhanC = TextEditingController();
  
  RxString imageUrl = "".obs;
  // ignore: prefer_typing_uninitialized_variables
  var files;
  final ImagePicker _picker = ImagePicker();



  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;
     files = File(image.path);
     imageUrl.value = files.toString();
    return file;
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
                  // if (await Permission.storage.request().isGranted) {
                  // }
                  takePhoto(ImageSource.gallery);
                  Get.back();
                  // takePhoto(ImageSource.gallery);
                  // Get.back();
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

}