// ignore_for_file: sized_box_for_whitespace

import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/register/register_controller.dart';
import 'package:bionmed_app/widgets/appbar/appbar_back.dart';
import 'package:bionmed_app/widgets/header/header_auth.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'dart:io';

import '../../widgets/input/input_primary.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  static const routeName = "/register_screen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController controllerNama = TextEditingController();
  final TextEditingController controllerDate = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerCity = TextEditingController();

  final registerController = RegisterController();

  final items = ['Laki-laki', 'Perempuan'];
  String selectedValue = 'Laki-laki';

  // @override
  // void initState() {
  //   controllerDate.text = "";
  //   super.initState();
  // }

  bool isButtonActive = false;
  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var files;

  @override
  void initState() {
    controllerNama.addListener(() {
      final isButtonActive = controllerNama.text.isNotEmpty;
      setState(() {
        this.isButtonActive = isButtonActive;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    controllerNama.dispose();
    super.dispose();
  }

  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;
    setState(() => files = File(image.path));
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
                onTap: ()async {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ignore: avoid_unnecessary_containers
      backgroundColor: AppColor.whiteColor,
      appBar: appbarBack(),
      body: LoadingOverlay(
        isLoading: Get.find<RegisterController>().isloading.value,
        progressIndicator: loadingIndicator(),
        color: Colors.transparent,
        opacity: 0.2,
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: defaultPadding),
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const SizedBox(height: 40),
            const HeaderAuth(
                imageUrl: "assets/images/img-biodata.png",
                title: "Biodata",
                subtitle:
                    "Isi data ini dengan lengkap untuk membuat \nakun anda"),
            const SizedBox(height: 32),
            GestureDetector(
                onTap: () {
                  pickerFilesImage(context);
                },
                child: files == null
                    ? Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColor.weak2Color),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Icon(
                              Icons.add_a_photo_outlined,
                              size: 42,
                              color: AppColor.bodyColor[500],
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Tambahkan foto",
                              style: TextStyle(
                                color: AppColor.bodyColor[500],
                                fontSize: 11,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 120,
                        width: 120,
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                ClipOval(
                                  child: SizedBox.fromSize(
                                    size: const Size.fromRadius(48), // Image radius
                                    child: Image.file(files, fit: BoxFit.cover),
                                  ),
                                ),
                                Positioned(
                                  left: 55,
                                  bottom: 5,
                                  child: Icon(
                                    Icons.add_a_photo,
                                    size: 35,
                                    color: AppColor.bodyColor.shade500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )),
            const SizedBox(height: 6),
            const Text(
              "Foto Profile",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.bodyColor,
              ),
            ),
            SizedBox(height: defaultPadding),
            Container(
              width: double.infinity,
              child: const Text(
                'Nama Lengkap',
                textAlign: TextAlign.left,
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: InputPrimary(
                onTap: () {},
                hintText: "Masukkan nama lengkap",
                controller: controllerNama,
                onChange: (val) {},
                validate: (value) {
                  if (value.toString().isNotEmpty) {
                    return null;
                  }
                  return "Nama tidak boleh kosong";
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: const Text(
                'Tanggal Lahir',
                textAlign: TextAlign.left,
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: InputPrimary(
                controller: controllerDate,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1800),
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    // ignore: avoid_print
                    print(pickedDate);
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    // ignore: avoid_print
                    print(formattedDate);

                    setState(() {
                      controllerDate.text = formattedDate;
                    });
                  } else {
                    // ignore: avoid_print
                    print("Date is not selected");
                  }
                },
                hintText: "Masukkan tanggal lahir",
                onChange: (val) {},
                validate: (value) {
                  if (value.toString().isNotEmpty) {
                    return null;
                  }
                  return "Tanggal lahir tidak boleh kosong";
                },
                prefixIcon: const Icon(Icons.calendar_month),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: const Text(
                'Jenis Kelamin',
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: Get.width,
              decoration: BoxDecoration(
                  color: AppColor.bgForm,
                  borderRadius: BorderRadius.circular(10),
                  border: BorderStyles.borderGrey),
              // dropdown below..
              child: DropdownButton<String>(
                value: selectedValue,
                onChanged: (String? newValue) =>
                    setState(() => selectedValue = newValue!),
                items: items
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: AppColor.bodyColor.shade500,
                                ),
                              ),
                            ))
                    .toList(),
                icon: const Icon(
                  Icons.arrow_drop_down,
                  color: Color(0xffb6b6b6),
                ),
                iconSize: 20,
                underline: const SizedBox(),
                isExpanded: true,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              child: const Text(
                'Kota / Provinsi',
                textAlign: TextAlign.left,
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: InputPrimary(
                onTap: () {},
                hintText: "Isi kota Anda",
                controller: controllerCity,
                onChange: (val) {},
                validate: (value) {
                  if (value.toString().isNotEmpty) {
                    return null;
                  }
                  return "Kota / provinsi tidak boleh kosong";
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: const Text(
                'Alamat',
                textAlign: TextAlign.left,
              ),
            ),
            // ignore: avoid_unnecessary_containers
            Container(
              child: InputPrimary(
                onTap: () {},
                hintText: "Isi alamat anda",
                controller: controllerAddress,
                onChange: (val) {},
                validate: (value) {
                  if (value.toString().isNotEmpty) {
                    return null;
                  }
                  return "Alamat tidak boleh kosong";
                },
              ),
            ),
            const SizedBox(height: 50),
            Container(
              margin: EdgeInsets.only(bottom: defaultPadding),
              height: 45,
              width: double.infinity,
              decoration: isButtonActive == true
                  ? BoxDecoration(
                      gradient: AppColor.gradient1,
                      borderRadius: BorderRadius.circular(6.0),
                    )
                  : null,
              child: ElevatedButton(
                onPressed: isButtonActive
                    ? () async{

                         await Get.find<RegisterController>().registerApps(
                              name: controllerNama.text,
                              brithdayDate: controllerDate.text,
                              address: controllerAddress.text,
                              phoneNumber: Get.find<RegisterController>()
                                  .phoneNumber
                                  .value,
                                  file: files
                                  );
                          isButtonActive = false;
                          // controllerNama.clear();

                      //  await Get.put(ControllerProfile()).updateImage(files);

                      }
                    : null,
                style:
                    // ignore: deprecated_member_use
                    ElevatedButton.styleFrom(onSurface: AppColor.bluePrimary),
                child: const Text(
                  "Lanjutkan",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
