import 'dart:io';

import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/login/disclaimer.dart';
import 'package:bionmed_app/screens/profile/controller_profile.dart';
import 'package:bionmed_app/screens/profile/profile_detail.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/colors.dart';
import '../../widgets/other/title_tile.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = "/profile_screen";
  // ignore: prefer_typing_uninitialized_variables
  final name;

  const ProfileScreen({Key? key, this.name}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  // ignore: prefer_typing_uninitialized_variables
  var files;
  Future<File?> takePhoto(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    // ignore: unnecessary_nullable_for_final_variable_declarations
    final File? file = File(image!.path);
    files == file;

    setState(() => files = File(image.path));
    await Get.find<ControllerProfile>().updateImage(files);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: const Text('Profile'),
        titleTextStyle: TextStyles.subtitle1,
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColor.gradient1,
          ),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        children: [
          SizedBox(height: defaultPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  ClipOval(
                    child: Container(
                      height: 100,
                      width: 100,
                      // ignore: sort_child_properties_last
                      child: files != null
                          ? Image.file(
                              files,
                              fit: BoxFit.cover,
                            )
                          : Get.find<ControllerLogin>().imagePhoto.value.isEmpty
                              ? Image.asset(
                                  'assets/images/img-doctor2.png',
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  Get.find<ControllerLogin>().imagePhoto.value,
                                  fit: BoxFit.contain,
                                ),
                      decoration: const BoxDecoration(
                        // image: DecorationImage(
                        //     image: files == null ? AssetImage("assets/images/img-doctor1.png") : FileImage(files),
                        //     fit: BoxFit.fitHeight),
                        color: AppColor.whiteColor,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.center,
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        border:
                            Border.all(width: 4, color: AppColor.whiteColor),
                        color: AppColor.weakColor,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt),
                        iconSize: 18,
                        color: AppColor.bodyColor.shade700,
                        onPressed: () {
                          pickerFilesImage(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Text(
                Get.find<ControllerLogin>().name.value,
                style: TextStyles.h4.copyWith(fontSize: 24),
              ),
              const SizedBox(height: 4),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  Icon(
                    Icons.location_on,
                    size: 18,
                    color: AppColor.bodyColor.shade500,
                  ),
                  Text(
                    "${Get.find<ControllerLogin>().alamat}",
                    style: TextStyles.subtitle3,
                  ),
                ],
              )
            ],
          ),
          SizedBox(height: defaultPadding),
          TitleTile(title: "Aktivitas", onTap: () {
          }),
          const SizedBox(height: 14),
          AktivitasProfile(
            onTap: () {
              Get.to(() => const PageProfileDetail());
            },
            title: const Text("Profile"),
            icon: const Icon(Icons.person),
          ),
          AktivitasProfile(
            onTap: () {},
            title: const Text("Schedule"),
            icon: const Icon(Icons.date_range),
          ),
          AktivitasProfile(
            onTap: () {},
            title: const Text("Bookmark"),
            icon: const Icon(Icons.bookmark),
          ),
          AktivitasProfile(
            onTap: () {},
            title: const Text("Terms & conditions"),
            icon: const Icon(Icons.summarize),
          ),
          AktivitasProfile(
            onTap: () {
              // Get.find<ControllerProfile>().ketentuanPengguna();
              Get.to(()=> Disclamer());
            },
            title: const Text("Privacy Policy"),
            icon: const Icon(Icons.privacy_tip),
          ),
          SizedBox(height: defaultPadding),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 7),
            padding: const EdgeInsets.only(left: 16, top: 3, bottom: 3),
            decoration: BoxDecoration(
              color: AppColor.redColor,
              borderRadius: BorderRadius.circular(4),
            ),
            child: InkWell(
              onTap: () {
                showPopUp(
                    onTap: () {
                      Get.back();
                    },
                    description: "Apakah anda yakin ingin keluar?",
                    onPress: () {
                      Get.offAllNamed('login_screen');
                      final box = GetStorage();
                      box.remove('phone');
                      box.remove('rememberme');
                      box.remove('dontShowAgain');
                      box.remove('dontShowAgainPesanan');
                    });
              },
              child: const ListTile(
                iconColor: AppColor.whiteColor,
                textColor: AppColor.whiteColor,
                contentPadding: EdgeInsets.zero,
                leading: Icon(Icons.logout),
                title: Text("Logout"),
              ),
            ),
          ),
          SizedBox(height: defaultPadding + 6),
        ],
      ),
    );
  }
}

class AktivitasProfile extends StatelessWidget {
  const AktivitasProfile({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final Icon icon;
  final Text title;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        padding: const EdgeInsets.only(left: 16, top: 3, bottom: 3),
        decoration: BoxDecoration(
          color: AppColor.bgForm,
          borderRadius: BorderRadius.circular(4),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: icon,
          title: title,
          trailing: IconButton(
              iconSize: 20,
              icon: const Icon(
                Icons.arrow_forward_ios,
              ),
              onPressed: () {}),
        ),
      ),
    );
  }
}
