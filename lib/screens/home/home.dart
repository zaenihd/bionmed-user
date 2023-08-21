// ignore_for_file: prefer_const_constructors

import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/home/home_screen.dart';
import 'package:bionmed_app/screens/pesanan/api_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../pesanan/pesanan_screen.dart';
import '../shop/bishop_screen.dart';
import '../articel/articel_screen.dart';

class Home extends StatefulWidget {
  final int indexPage;
  const Home({
    Key? key,
    required this.indexPage,
  }) : super(key: key);
  static const routeName = "/home";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [
    const HomeScreen(),
    const ArticelScreen(),
    const PesananScreen(),
    const BishopScreen(),
  ]; // to store nested tabs

  final PageStorageBucket bucket = PageStorageBucket();
  Widget? currentScreen;
  int currentTab = 0;

  DateTime? currentBackPressTime;

   Future<bool> _onWillPop() async {
    final now = DateTime.now();
    final backButtonHasNotBeenPressedOrSnackBarHasBeenClosed =
        currentBackPressTime == null ||
            now.difference(currentBackPressTime!) > const Duration(seconds: 2);

    if (backButtonHasNotBeenPressedOrSnackBarHasBeenClosed) {
      currentBackPressTime = now;
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        
        const SnackBar(
          behavior: SnackBarBehavior.floating,
          content: Text('Press back again to exit'),
        ),
      );
      return false;
    }

    return true;
  }



  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      body: WillPopScope(
        onWillPop: _onWillPop,
        child: Stack(
          children: [
            GetBuilder<HomeController>(
              init: Get.find<HomeController>(),
              builder: (controller) {
                return Obx(
                  () => PageStorage(
                    // ignore: sort_child_properties_last
                    child: controller.currentIndex.value == 0
                        ? HomeScreen()
                        : controller.currentIndex.value == 1
                            ? ArticelScreen()
                            : controller.currentIndex.value == 2
                                ? PesananScreen()
                                : BishopScreen(),
                    bucket: bucket,
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        // ignore: sized_box_for_whitespace
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Obx(
                () => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = const HomeScreen();
                          currentTab = 0;
                          Get.find<HomeController>().currentIndex.value = 0;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.home,
                            color:
                                Get.find<HomeController>().currentIndex.value ==
                                        0
                                    ? AppColor.bluePrimary2
                                    : AppColor.weakColor,
                          ),
                          Text(
                            'Home',
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.find<HomeController>()
                                          .currentIndex
                                          .value ==
                                      0
                                  ? AppColor.bluePrimary2
                                  : AppColor.weakColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 80,
                      onPressed: () {
                        setState(() {
                          currentScreen = const ArticelScreen();
                          currentTab = 1;
                          Get.find<HomeController>().currentIndex.value = 1;
                        });
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.article,
                            color:
                                Get.find<HomeController>().currentIndex.value ==
                                        1
                                    ? AppColor.bluePrimary2
                                    : AppColor.weakColor,
                          ),
                          Text(
                            'Artikel',
                            style: TextStyle(
                              fontSize: 12,
                              color: Get.find<HomeController>()
                                          .currentIndex
                                          .value ==
                                      1
                                  ? AppColor.bluePrimary2
                                  : AppColor.weakColor,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),

              // Right Tab bar icons

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        Get.lazyPut<ControllerPesanan>(
                            () => ControllerPesanan());
                        ApiPesanan().automaticStatus();

                        currentScreen = const PesananScreen();
                        currentTab = 2;
                        Get.find<HomeController>().currentIndex.value = 2;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.email,
                          color:
                              Get.find<HomeController>().currentIndex.value == 2
                                  ? AppColor.bluePrimary2
                                  : AppColor.weakColor,
                        ),
                        Text(
                          'Pesanan',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Get.find<HomeController>().currentIndex.value ==
                                        2
                                    ? AppColor.bluePrimary2
                                    : AppColor.weakColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    minWidth: 80,
                    onPressed: () {
                      setState(() {
                        currentScreen = const BishopScreen();
                        currentTab = 3;
                        Get.find<HomeController>().currentIndex.value = 3;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.store,
                          color:
                              Get.find<HomeController>().currentIndex.value == 3
                                  ? AppColor.bluePrimary2
                                  : AppColor.weakColor,
                        ),
                        Text(
                          'Bishop',
                          style: TextStyle(
                            fontSize: 12,
                            color:
                                Get.find<HomeController>().currentIndex.value ==
                                        3
                                    ? AppColor.bluePrimary2
                                    : AppColor.weakColor,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: !keyboardIsOpen,
        child: FloatingActionButton(
          onPressed: () {
            Get.toNamed(ProfileScreen.routeName);
          },
          child: Container(
            height: 67,
            width: 67,
            decoration: const BoxDecoration(
                gradient: AppColor.gradient1, shape: BoxShape.circle),
            child: const Icon(Icons.person),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
