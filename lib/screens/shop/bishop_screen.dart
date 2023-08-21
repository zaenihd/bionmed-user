import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';
import '../../widgets/header/header_curved.dart';
import '../../widgets/search/form_search.dart';

class BishopScreen extends StatefulWidget {
  const BishopScreen({Key? key}) : super(key: key);
  static const routeName = "/bishop_screen";

  @override
  State<BishopScreen> createState() => _BishopScreenState();
}

class _BishopScreenState extends State<BishopScreen> {
  String title = "Bishop";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Stack(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            const HeaderCurved(),
            Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.only(
                      left: defaultPadding, right: defaultPadding, top: 7),
                  title: Text(
                    "Hallo, Bagaimana kesehatan anda ?",
                    style: TextStyle(
                      color: AppColor.whiteColor.withOpacity(0.7),
                      fontSize: 12,
                    ),
                  ),
                  subtitle:  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      Get.find<ControllerLogin>().name.value,
                      style: const TextStyle(
                          color: AppColor.whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  trailing: GestureDetector(
                    onTap: () {
                      debugPrint("Cart");
                    },
                    child: const Icon(
                      Icons.shopping_cart,
                      color: AppColor.whiteColor,
                      size: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.white,
                        size: 12.0,
                      ),
                      const SizedBox(width: 4),
                       Text(
                         Get.find<ControllerLogin>().locality.value.toString(),
                        style:
                            const TextStyle(color: AppColor.whiteColor, fontSize: 12),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: const FormSearch(
                    hinText: "Cari apotek terdekat",
                  ),
                ),
              ],
            ),
          ],
        ),
      ]),
    );
  }
}
