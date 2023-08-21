// ignore_for_file: deprecated_member_use
import 'dart:developer';

import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/layanan_nurse_home/view/input_layanan_nurse.dart';
import 'package:bionmed_app/screens/pesanan/controller_pesanan.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_jadwal.dart';

import 'package:bionmed_app/screens/home/home_notif_screen.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/payment/controller_payment.dart';
import 'package:bionmed_app/screens/splash/splash_controller.dart';
import 'package:bionmed_app/widgets/card/card_dokter_by_home.dart';

import 'package:bionmed_app/widgets/card/card_rec_doctor.dart';
import 'package:bionmed_app/widgets/header/header_curved.dart';
import 'package:bionmed_app/widgets/other/show_dialog.dart';
import 'package:bionmed_app/widgets/other/title_tile.dart';
import 'package:bionmed_app/widgets/search/form_search.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../widgets/card/card_artikel.dart';
import '../../widgets/card/card_services.dart';
import '../../widgets/card/carousel_banner.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "/home_screen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  // ignore: unused_field
  int _dotIndicator = 0;
  List<int> carouselBanner = [1, 2, 3];
  List<int> promoBanner = [1, 2, 3];

  // indicator
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  final myC = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      body: GetBuilder<ControllerLogin>(
          init: ControllerLogin(),
          builder: (controller) {
            return ListView(
              children: [
                Stack(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const HeaderCurved(),
                    Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.only(
                              left: defaultPadding,
                              right: defaultPadding,
                              top: 7),
                          title: InkWell(
                            onTap: () {},
                            child: InkWell(
                              onTap: () async {
                                // popUpGetLokasi();
                                // myC.reminderKeberangkatanDokter();
                                // myC.automaticUpdateStatus();

                                // myC.reminderPayment();
                                // Get.to(()=>const PilihJadwalView());
                              },
                              child: Text(
                                "Hello, How's your health ?",
                                style: TextStyle(
                                  color: AppColor.whiteColor.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ),
                          subtitle: InkWell(
                            onTap: () {
                              // Get.to(() => const ChatCenterScreen());
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                controller.name.value,
                                style: const TextStyle(
                                    color: AppColor.whiteColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          trailing: GestureDetector(
                            onTap: () {
                              controller.activeNotif.value = 0;
                              Get.to(() => const NotifScreen());
                            },
                            child: Obx(
                              () => controller.activeNotif.value != 0
                                  ? Stack(
                                      children: [
                                        const Icon(
                                          Icons.notifications,
                                          color: AppColor.whiteColor,
                                          size: 30,
                                        ),
                                        Container(
                                          width: 40,
                                          decoration: const BoxDecoration(
                                              color: AppColor.redColor,
                                              shape: BoxShape.circle),
                                          child: Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Text(
                                              controller.activeNotif.value
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyles.small1.copyWith(
                                                  color: AppColor.whiteColor),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : const Icon(
                                      Icons.notifications,
                                      color: AppColor.whiteColor,
                                      size: 30,
                                    ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultPadding),
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
                                controller.locality.value,
                                style: const TextStyle(
                                    color: AppColor.whiteColor, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 18),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: defaultPadding),
                          child: const FormSearch(
                            hinText: "Cari tahu tentang gejala Anda...",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                // ignore: avoid_unnecessary_containers
                Container(
                  child: CarouselSlider(
                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        autoPlay: true,
                        autoPlayInterval: const Duration(milliseconds: 3200),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        pauseAutoPlayOnTouch: true,
                        height: 128,
                        pageSnapping: false,
                        aspectRatio: 16 / 9,
                        // viewportFraction: 0.8,
                        // enlargeCenterPage: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _dotIndicator = index;
                          });
                        },
                      ),
                      items: Get.find<ControllerLogin>()
                          .dataBanner
                          .map((element) => Container(
                                width: 312,
                                height: 128,
                                margin: const EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(15.0),
                                    ),
                                    color: Colors.grey[300],
                                    image: DecorationImage(
                                        image:
                                            NetworkImage('${element['image']}'),
                                        fit: BoxFit.cover)),
                              ))
                          .toList()),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: map<Widget>(controller.dataBanner, (index, url) {
                //     return AnimatedContainer(
                //       duration: const Duration(milliseconds: 200),
                //       width: _dotIndicator == index ? 7.0 : 6.0,
                //       height: _dotIndicator == index ? 7.0 : 6.0,
                //       margin: const EdgeInsets.symmetric(
                //           vertical: 12.0, horizontal: 2.0),
                //       decoration: BoxDecoration(
                //         shape: BoxShape.circle,
                //         // borderRadius: BorderRadius.circular(5),
                //         color: _dotIndicator == index
                //             ? AppColor.primaryColor
                //             : AppColor.bodyColor[200],
                //       ),
                //     );
                //   }),
                // ),
                SizedBox(height: defaultPadding - 12),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TitleTile(title: "Layanan Kami", onTap: () {}),
                      InkWell(
                          onTap: () {
                            showModalBottomSheet(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(30),
                                        topRight: Radius.circular(30))),
                                context: context,
                                builder: (context) {
                                  return SizedBox(
                                    height: 400,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 18, top: 14),
                                          width: Get.width / 1.9,
                                          height: 10,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: const Color(0xffEDEDED)),
                                        ),
                                        const Text(
                                          "Layanan Kami",
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 300,
                                          child: GridView.builder(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: defaultPadding,
                                                vertical: defaultPadding),
                                            shrinkWrap: true,
                                            physics: const ScrollPhysics(),
                                            gridDelegate:
                                                const SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 3 / 4,
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 18,
                                              mainAxisSpacing: 18,
                                            ),
                                            itemCount:
                                                controller.dataService.length,
                                            itemBuilder: (context, index) {
                                              return CardServices(
                                                onTap: () {
                                                  Get.find<ControllerPayment>()
                                                          .serviceId
                                                          .value =
                                                      controller.dataService[
                                                          index]['id'];
                                                  Get.find<ControllerPayment>()
                                                      .nameService
                                                      .value = controller
                                                          .dataService[index]
                                                      ['name'];
                                                  // Get.find<ControllerLogin>().getDoctorByServiceId(
                                                  //     id: controller.dataService[index]['id'].toString(),
                                                  //     day: DateFormat("EEEE", "id_ID")
                                                  //         .format(DateTime.now()),
                                                  //     jam: DateFormat("HH:mm", "id_ID")
                                                  //         .format(DateTime.now()));

                                                  Get.to(
                                                      const PagePesananJawal());
                                                },
                                                imageUrl: controller
                                                        .dataService[index]
                                                    ['image'],
                                                name: controller
                                                    .dataService[index]['name'],
                                              );
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: const Text(
                            'Lihat Semua',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  ),
                ),
                GridView.builder(
                  padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding, vertical: defaultPadding),
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3 / 4,
                    crossAxisCount: 3,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                  ),
                  itemCount: controller.dataService.length,
                  itemBuilder: (context, index) {
                    return CardServices(
                      onTap: () async {
                        bool isLocationEnabled =
                            await Get.find<HomeController>().checkGpsStatus();
                        if (isLocationEnabled) {
                          // Get.put(SplashScreenController()).getLocation();
                          // Get.defaultDialog(title: 'Aktif');
                          Get.find<ControllerPayment>().serviceId.value =
                              controller.dataService[index]['id'];
                          Get.find<ControllerPayment>().sequenceId.value =
                              controller.dataService[index]['sequence'];
                          Get.find<ControllerPayment>().imageService.value =
                              controller.dataService[index]['image'];
                          Get.find<ControllerPayment>().nameService.value =
                              controller.dataService[index]['name'];
                          //CLEAR LIST
                          Get.put(InputLayananController())
                              .listDataNurse
                              .clear();
                          Get.find<ControllerPesanan>()
                              .listDokterHomeVisit
                              .clear();
                          Get.find<ControllerLogin>().doctorByService.clear();
                          if (controller.dataService[index]['sequence'] == 4 
                          ||
                              controller.dataService[index]['sequence'] == 5 ||
                              controller.dataService[index]['sequence'] == 6
                              ) {
                            log('coba ${Get.find<ControllerPayment>()
                                    .serviceId
                                    .value}');
                            Get.to(() => const InputLayananNurse());
                            // }else if(controller.dataService[index]['sequence'] == 3){
                            //   Get.to(()=>const InputLaboKlinik());
                          } else if (controller.dataService[index]
                                      ['sequence'] ==
                                  1 ||
                              controller.dataService[index]['sequence'] == 2) {
                            Get.to(() => const PagePesananJawal());
                            getLocation();
                            // popUpGetLokasi();
                          } else {
                            showPopUp(
                                onTap: () {
                                  Get.back();
                                },
                                imageAction: "assets/json/eror.json",
                                description: "Layanan ini masih\nBelum aktif");
                          }
                          // Pindah ke halaman berikutnya
                        } else {
                          // Get.put(SplashScreenController()).getLocation();
                          showPopUp(
                              labelButton: 'Aktifkan',
                              onPress: () async {
                              Get.put(SplashScreenController()).getLocation();
                                // Get.find<HomeController>().enableGPS();
                                Geolocator.openLocationSettings();
                                Get.back();
                              },
                              imageSize: 200,
                              onTap: () {
                                Get.back();
                              },
                              imageUri: "assets/images/lokasi.png",
                              description:
                                  "Aktifkan GPS anda\nuntuk melakukan pemesanan");
                        }
                      },
                      imageUrl: controller.dataService[index]['image'],
                      name: controller.dataService[index]['name'],
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: TitleTile(title: "Rekomendasi Dokter", onTap: () {}),
                ),
                SizedBox(height: defaultPadding - 10),
                controller.dataDoctor.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: controller.dataDoctor.length,
                        physics: const ScrollPhysics(),
                        itemBuilder: (BuildContext context, index) {
                          return 
                          CardRecDoctorByHome(
                            data: controller.dataDoctor[index],
                          );
                        },
                      )
                    : verticalSpace(0),
                SizedBox(height: defaultPadding),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: TitleTile(
                      title: "Baca 100+ Artikel Terbaru",
                      onTap: () {},
                      isAll: true),
                ),
                SizedBox(height: defaultPadding),
                ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.dataArticel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return CardArtikel(
                      data: controller.dataArticel[index],
                    );
                  },
                ),

                SizedBox(height: defaultPadding * 2),
              ],
            );
          }),
    );
  }
}

getLocation() async {
  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);
  // Get.put(SplashScreenController()).getLocation();
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);
  Get.find<ControllerLogin>().locality.value = placemarks[0].locality!;
  Get.find<ControllerPayment>().lat.value = position.latitude;
  Get.find<ControllerPayment>().long.value = position.longitude;
  Get.find<ControllerPayment>().districts.value = placemarks[0].locality!;
  Get.find<ControllerPayment>().city.value = placemarks[0].subLocality!;
  Get.find<ControllerPayment>().country.value = placemarks[0].country!;
  Get.find<ControllerPayment>().province.value =
      placemarks[0].subAdministrativeArea!;

  print( "ZEEN " + Get.find<ControllerPayment>().lat.value.toString());
  // Get.defaultDialog(title: 'Aktif');
}

popUpGetLokasi() {
  Get.dialog(
    AlertDialog(
      // backgroundColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.7),
      title: Text(
        'Agar layanan dapat berfungsi ijinkan Bionmed mencatat data lokasi anda',
        style: TextStyles.h5,
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset("assets/images/lokasi.png"),
            Text("BionMed mencatat dan menyimpan data lokasi agar dapat menampilkan dokter terdekat yang dapat melayani dan mencapai lokasi anda", textAlign: TextAlign.center,),
            const SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Container(
                    margin: EdgeInsets.zero,
                    height: 45,
                    width: Get.width / 3.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Text(
                          'Tidak',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ))),
                        Container(
                    margin: EdgeInsets.zero,
                    height: 45,
                    width: Get.width / 3.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ElevatedButton(
                        onPressed: () async {
                           bool isLocationEnabled =
                            await Get.find<HomeController>().checkGpsStatus();
                          if(isLocationEnabled){
                          Get.back();
                            getLocation();
                          }else{
                            Get.back();
                            Get.put(SplashScreenController()).getLocation();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.bluePrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        child: Text(
                          'Ijinkan',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ))),
              ],
            )
            // content,
            // verticalSpace(20),
            // actions,
          ],
        ),
      ),
    ),
  );
}

List<Widget> items = [
  CarouselBanner(
    imageUrl: '1',
  ),
  CarouselBanner(
    imageUrl: '2',
  ),
  CarouselBanner(
    imageUrl: '3',
  ),
  CarouselBanner(
    imageUrl: '4',
  ),
  CarouselBanner(
    imageUrl: '5',
  ),
  CarouselBanner(
    imageUrl: '7',
  ),
  CarouselBanner(
    imageUrl: '8',
  ),
  CarouselBanner(
    imageUrl: '9',
  ),
  // Image.asset('assets/Group 804.png'),
  // Image.asset('assets/Group 804.png'),
  // Image.asset('assets/Group 804.png'),
];
