// ignore_for_file: unused_field, unused_element, unnecessary_new

import 'dart:async';
import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
// import 'package:bionmed/app/modules/doctor_app/register/controllers/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:search_map_location/search_map_location.dart';
import 'package:search_map_location/utils/google_search/place.dart';
import 'package:search_map_location/utils/google_search/place_type.dart';

import '../layanan_hospital order/indput_data_order_ambulance/controller/input_data_order_ambulance_controller.dart';

// import '../../../../../theme.dart';

class Maaapp extends StatefulWidget {
  const Maaapp({
    Key? key,
    // required this.lat,
    // required this.long,
  }) : super(key: key);

  // double lat;
  // double long;

  @override
  State<Maaapp> createState() => MaaappState();
}

class MaaappState extends State<Maaapp> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  Position? _currentPosition;
  final mapC = Get.put(MapsController());

  @override
  void initState() {
    getlokasi();
    // widget.lat;
    mapC.lat.value;
    // ignore: todo
    // TODO: implement initState
    super.initState();
  }

  void cameraLokasi() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
        CameraUpdate.newLatLng(LatLng(mapC.lat.value, mapC.long.value)));
    mapC.getUserLocation();
  }

  void getlokasi() async {
    await mapC.getCurrentLocation().then((value) {
      mapC.lat.value = value.latitude;
      mapC.long.value = value.longitude;
      cameraLokasi();
    });
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
    });
  }

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  // ignore: prefer_final_fields

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  // ignore: prefer_final_fields

  GoogleMapController? mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              Obx(() => GoogleMap(
                    // ignore: prefer_collection_literals
                    markers: [
                      Marker(
                        markerId: const MarkerId("1"),
                        position: LatLng(mapC.lat.value, mapC.long.value),
                        // position: LatLng(-6.5693770, 106.6710462),
                        draggable: true,
                        onDragEnd: (e) async {
                          List<Placemark> city = await placemarkFromCoordinates(
                              e.latitude, e.longitude);
                          Placemark placemark = city[0];
                          mapC.city.value = placemark.subAdministrativeArea!;
                          mapC.kabupaten.value = placemark.administrativeArea!;
                          mapC.lat.value = e.latitude;
                          mapC.long.value = e.longitude;
                          mapC.cityTujuan.value =
                              placemark.subAdministrativeArea!;
                          mapC.kabupatenTujuan.value =
                              placemark.administrativeArea!;
                          mapC.latTujuan.value = e.latitude;
                          mapC.longTujuan.value = e.longitude;
                        },
                      ),
                      Marker(
                        markerId: const MarkerId("2"),
                        position: LatLng(mapC.lat.value, mapC.long.value),
                        // position: LatLng(-6.5693770, 106.6710462),
                        draggable: true,
                        onDragEnd: (e) async {
                          List<Placemark> city = await placemarkFromCoordinates(
                              e.latitude, e.longitude);
                          Placemark placemark = city[0];
                          mapC.city.value = placemark.subAdministrativeArea!;
                          mapC.kabupaten.value = placemark.administrativeArea!;
                          mapC.lat.value = e.latitude;
                          mapC.long.value = e.longitude;
                          mapC.cityTujuan.value =
                              placemark.subAdministrativeArea!;
                          mapC.kabupatenTujuan.value =
                              placemark.administrativeArea!;
                          mapC.latTujuan.value = e.latitude;
                          mapC.longTujuan.value = e.longitude;
                        },
                      ),
                    ].toSet(),
                    mapType: MapType.terrain,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(mapC.lat.value, mapC.long.value),
                      zoom: 14.4746,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                      // setState(() {
                      //   mapController = controller;
                      // });
                    },
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20),
                child: SearchLocation(
                  country: "ID",
                  language: "id",
                  hasClearButton: true,
                  placeType: PlaceType.establishment,
                  placeholder: "Cari Lokasi",
                  apiKey: "AIzaSyDFEfnWAt9nwFFb8fJXy3USgo94KgnTLSo",
                  onSelected: (Place place) async {
                    // ignore: prefer_collection_literals, unused_local_variable
                    final Set<Marker> markers = new Set();
                    final geolocation = await place.geolocation;
                    final GoogleMapController controller =
                        await _controller.future;
                    // controller.animateCamera(
                    //   CameraUpdate.newLatLng(
                    //     LatLng(
                    //         geolocation!.fullJSON['geometry']['bounds']
                    //             ['northeast']['lat'],
                    //         geolocation.fullJSON['geometry']['bounds']
                    //             ['northeast']['lng']),
                    //   ),
                    // );
                    controller.animateCamera(
                      CameraUpdate.newLatLng(
                        LatLng(
                            geolocation!.fullJSON['geometry']['location']
                                ['lat'],
                            geolocation.fullJSON['geometry']['location']
                                ['lng']),
                      ),
                    );
                    log(geolocation.fullJSON.toString());

                    // mapC.lat.value = geolocation.fullJSON['geometry']['bounds']
                    //     ['northeast']['lat'];
                    // mapC.long.value = geolocation.fullJSON['geometry']['bounds']
                    //     ['northeast']['lng'];
                    // mapC.getUserLocationSearch();
                    if (mapC.isTujuan.isFalse) {
                      mapC.lat.value = geolocation.fullJSON['geometry']['location']['lat'];
                      mapC.long.value = geolocation.fullJSON['geometry']['location']['lng'];
                    } else {
                      mapC.latTujuan.value = geolocation.fullJSON['geometry']['location']['lat'];
                      mapC.longTujuan.value = geolocation.fullJSON['geometry']['location']['lng'];
                    }
                    print("zen nini ${mapC.latTujuan.value}");
                    print("zen nini ${mapC.longTujuan.value}");
                    await mapC.getUserLocation();
                    //  mapC.getUserLocationSearch();
                    // controller.animateCamera(
                    //     CameraUpdate.newLatLng(geolocation!.coordinates));
                    // // controller.animateCamera(CameraUpdate.newLatLngBounds(geolocation.bounds, 0));
                    // controller.animateCamera(
                    //     CameraUpdate.newLatLng(geolocation.coordinates));
                    // print(geolocation!.fullJSON.toString());
                    // print("inin-==-=-=-=-  " + geolocation!.fullJSON['geometry']['bounds']['northeast']['lat'].toString());
                    // print("inin-==-=-=-=-  " + geolocation.fullJSON['geometry']['bounds']['northeast']['lng'].toString());
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: 20.0, left: 20, right: 70),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                              padding: const EdgeInsets.all(7),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Lokasi saat ini',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Obx(
                                    () => SizedBox(
                                      width: 180,
                                      child: mapC.city.isEmpty
                                          ? AutoSizeText(
                                              '${mapC.cityTujuan}, ${mapC.kabupatenTujuan}',
                                              maxLines: 1,
                                            )
                                          : AutoSizeText(
                                              '${mapC.city}, ${mapC.kabupaten}',
                                              maxLines: 1,
                                            ),
                                    ),
                                  )
                                ],
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                await mapC.getUserLocation();
                                mapC.alamatMaps.value =
                                    '${mapC.desa.value} ${mapC.kecamatan.value} ${mapC.city.value} ${mapC.kabupaten.value} ${mapC.kodePos.value} ${mapC.negara.value}';
                                final GoogleMapController controller =
                                    await _controller.future;
                                if (mapC.isTujuan.isFalse) {
                                  controller.animateCamera(
                                      CameraUpdate.newLatLng(LatLng(
                                          mapC.lat.value, mapC.long.value)));
                                } else {
                                  controller.animateCamera(
                                      CameraUpdate.newLatLng(LatLng(
                                          mapC.latTujuan.value,
                                          mapC.longTujuan.value)));
                                }
                                // mapC.getUserLocationSearch();
                                showModalBottomSheet(
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(30),
                                            topRight: Radius.circular(30))),
                                    context: context,
                                    builder: (context) {
                                      return SizedBox(
                                        height: 230,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 24.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 18, top: 14),
                                                  width: Get.width / 1.9,
                                                  height: 10,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: const Color(
                                                          0xffEDEDED)),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Obx(
                                                    () => mapC.isTujuan.isTrue
                                                        ? Text(
                                                            '${mapC.desaTujuan}',
                                                            // 'Jadwal Sudah Penuh',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          )
                                                        : Text(
                                                            '${mapC.desa}',
                                                            // 'Jadwal Sudah Penuh',
                                                            style:
                                                                const TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                          ),
                                                  ),
                                                  Obx(
                                                    () => mapC.isTujuan.isTrue
                                                        ? Text(
                                                            '${mapC.kecamatanTujuan}, ${mapC.kabupatenTujuan} , ${mapC.cityTujuan}',
                                                            // 'Jadwal Sudah Penuh',
                                                            style:
                                                                const TextStyle(),
                                                          )
                                                        : Text(
                                                            '${mapC.kecamatan}, ${mapC.kabupaten} , ${mapC.city}',
                                                            // 'Jadwal Sudah Penuh',
                                                            style:
                                                                const TextStyle(),
                                                          ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 30.0,
                                              ),
                                              ButtonGradient(
                                                  onPressed: () async{
                                                   await Get.put(InputDataOrderAmbulanceController()).checkCsr(startCity: mapC.city.value);
                                                   log(mapC.city.value);
                                                    // if (Get.put(InputDataOrderAmbulanceController())
                                                    //         .serviceAmbulance
                                                    //         .value ==
                                                    //     1) {
                                                    //   Get.to(() =>
                                                    //       TambahAlamatAmbulance());
                                                    // } else {
                                                    // }
                                                    Get.back();
                                                    Get.back();
                                                    // mapC.alamat.text = mapC
                                                    //         .desa.isEmpty
                                                    //     ? ""
                                                    //     : '${mapC.desa.value} ${mapC.kecamatan.value} ${mapC.city.value} ${mapC.kabupaten.value} ${mapC.kodePos.value} ${mapC.negara.value}';
                                                  },
                                                  label:
                                                      'Gunakan & Isi Alamat'),
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              // Container(
                                              //   height: 45,
                                              //   width: Get.width,
                                              //   child: ElevatedButton(
                                              //     style: ElevatedButton.styleFrom(
                                              //       backgroundColor: Colors.grey[400]
                                              //     ),
                                              //     onPressed: (){
                                              //       print('object');
                                              //       mapC.alamat.text =" ";
                                              //       Get.back();
                                              //       Get.back();
                                              //     }, child: Text("Isi Alamat Dengan Manual"))),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                // final GoogleMapController controller =
                                //     await _controller.future;
                                // controller.animateCamera(CameraUpdate.newLatLng(
                                //     LatLng(mapC.lat.value,
                                //         mapC.long.value)));
                                // mapC.getUserLocation();
                                // // mapC.getUserLocationSearch();
                                // Get.back();
                                // print("uwuwuwu" +
                                //     mapC.lat.toString() +
                                //     "sasas" +
                                //     mapC.long.toString());
                              },
                              child: const Text('Pilih Lokasi'))
                        ],
                      ),
                      InkWell(
                        onTap: () async {
                          final GoogleMapController controller =
                              await _controller.future;
                          controller.animateCamera(CameraUpdate.newLatLng(
                              LatLng(mapC.lat.value, mapC.long.value)));
                          controller.animateCamera(
                              CameraUpdate.newCameraPosition(CameraPosition(
                                  // bearing: 192.8334901395799,
                                  target:
                                      LatLng(mapC.lat.value, mapC.long.value),
                                  // tilt: 59.440717697143555,
                                  zoom: 19.151926040649414)));
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.all(
                              Radius.circular(100.0),
                            ),
                          ),
                          child: const Icon(
                            Icons.location_on_outlined,
                            color: Colors.white,
                            size: 35,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        // Obx(
        //   () => Padding(
        //     padding: const EdgeInsets.all(20),
        //     child: Column(
        //       children: [
        //         Text('KOTA : ${mapC.city}'),
        //         Text('KABUPATEN : ${mapC.kabupaten}'),
        //         Text('LAT : ${mapC.lat}'),
        //         Text('LONG : ${mapC.long}'),
        //       ],
        //     ),
        //   ),
        // )
      ],
    )
        // floatingActionButton: FloatingActionButton(
        //   child: const Icon(Icons.map),
        //   onPressed: () async {
        //     final GoogleMapController controller = await _controller.future;
        // controller.animateCamera(CameraUpdate.newLatLng(
        //     LatLng(mapC.lat.value, mapC.long.value)));
        // mapC.getUserLocation();
        //     // Get.back();
        //     print("useeee" + mapC.lat.toString());
        //   },
        //   // label: Text(''),
        //   // icon: const Icon(Icons.directions_boat),
        // ),
        );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}

//CONTROLLER
class MapsController extends GetxController {
  @override
  void onInit() {
    isButtonActive.value = alamat.value.text;
    // ignore: todo
    // TODO: implement onInit
    super.onInit();
  }

  TextEditingController nama = TextEditingController();
  TextEditingController noHp = TextEditingController();
  TextEditingController alamat = TextEditingController();

  RxString alamatLengkap = "".obs;
  RxString alamatLengkapSendAPI = "".obs;
  RxString alamatMaps = "".obs;
  //Maps
  RxString city = ''.obs;
  RxString kabupaten = ''.obs;
  RxString negara = ''.obs;
  RxString kecamatan = ''.obs;
  RxString kodePos = ''.obs;
  RxString desa = ''.obs;

  RxBool isTujuan = false.obs;

  RxString cityTujuan = ''.obs;
  RxString kabupatenTujuan = ''.obs;
  RxString negaraTujuan = ''.obs;
  RxString kecamatanTujuan = ''.obs;
  RxString kodePosTujuan = ''.obs;
  RxString desaTujuan = ''.obs;

  // late double lat;
  // late double long;
  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
  RxDouble latTujuan = 0.0.obs;
  RxDouble longTujuan = 0.0.obs;
  String locationMessage = "Current Location";
  RxBool isLoadingMaps = false.obs;
  RxDouble latMaps = 0.0.obs;
  RxDouble longMaps = 0.0.obs;
  RxString isButtonActive = "".obs;

  getUserLocation() async {
    //  Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high);
    isLoadingMaps(true);
    if (isTujuan.isFalse) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat.value, long.value);
      Placemark place = placemarks[0];
      city.value = place.subAdministrativeArea.toString();
      kabupaten.value = place.administrativeArea.toString();
      desa.value = place.subLocality.toString();
      negara.value = place.country.toString();
      kecamatan.value = place.locality.toString();
      kodePos.value = place.postalCode.toString();
      log('user nih boss ==============');
      // lat.value = position.latitude;
      // long.value = position.longitude;
    } else {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latTujuan.value, longTujuan.value);
      Placemark place = placemarks[0];
      cityTujuan.value = place.subAdministrativeArea.toString();
      kabupatenTujuan.value = place.administrativeArea.toString();
      desaTujuan.value = place.subLocality.toString();
      negaraTujuan.value = place.country.toString();
      kecamatanTujuan.value = place.locality.toString();
      kodePosTujuan.value = place.postalCode.toString();
      log('Tujuan nih boss ==============');

      // latTujuan.value = position.latitude;
      // longTujuan.value = position.longitude;
    }
    isLoadingMaps(false);
  }

  getUserLocationSearch() async {
    //  Position position = await Geolocator.getCurrentPosition(
    //       desiredAccuracy: LocationAccuracy.high);

    if (isTujuan.isFalse) {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(lat.value, lat.value);
      Placemark place = placemarks[0];
      city.value = place.subAdministrativeArea.toString();
      kabupaten.value = place.administrativeArea.toString();
      desa.value = place.subLocality.toString();
      negara.value = place.country.toString();
      kecamatan.value = place.locality.toString();
      kodePos.value = place.postalCode.toString();
      // lat.value = position.latitude;
      // long.value = position.longitude;
    } else {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latTujuan.value, longTujuan.value);
      Placemark place = placemarks[0];
      cityTujuan.value = place.subAdministrativeArea.toString();
      kabupatenTujuan.value = place.administrativeArea.toString();
      desaTujuan.value = place.subLocality.toString();
      negaraTujuan.value = place.country.toString();
      kecamatanTujuan.value = place.locality.toString();
      kodePosTujuan.value = place.postalCode.toString();
      // latTujuan.value = position.latitude;
      // longTujuan.value = position.longitude;
    }
  }

  Future<Position> getCurrentLocation() async {
    // isLoadingMaps(true);

    bool serviceEnable = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnable) {
      return Future.error("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      isLoadingMaps(false);
      return Future.error("Location permissions are permanently denied");
    }
    return await Geolocator.getCurrentPosition();
  }
}
