// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

// ignore: must_be_immutable
class CarouselBanner extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  String imageUrl;
   CarouselBanner({
    Key? key,
    this.data,
    required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultPadding / 2 - 5),
      height: 128,
      width: Get.width,
      // padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: AppColor.bluePrimary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              image: AssetImage('assets/images/banner$imageUrl.png'), fit: BoxFit.cover)),
      // child: Stack(
      //   children: [
      //     // Padding(
      //     //   padding:
      //     //       EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 18),
      //     //   child: Column(
      //     //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     //     crossAxisAlignment: CrossAxisAlignment.start,
      //     //     // ignore: prefer_const_literals_to_create_immutables
      //     //     children: [
      //     //       Text(
      //     //         data['name'],
      //     //         style: TextStyle(color: Color(0xff004989)),
      //     //       ),
      //     //       Container(
      //     //         // width: 100,
      //     //         height: 35,
      //     //         decoration: BoxDecoration(
      //     //           gradient: AppColor.gradient1,
      //     //           borderRadius: BorderRadius.circular(5),
      //     //         ),
      //     //         child: ElevatedButton(
      //     //           onPressed: () {},
      //     //           style: ElevatedButton.styleFrom(
      //     //             // padding: EdgeInsets.zero,
      //     //             primary: Colors.transparent,
      //     //             onSurface: Colors.transparent,
      //     //             // shadowColor: Colors.transparent,
      //     //             elevation: 0.0,
      //     //             shape: RoundedRectangleBorder(
      //     //               borderRadius: BorderRadius.circular(6.0),
      //     //             ),
      //     //           ),
      //     //           child: Text(
      //     //             "Selengkapnya",
      //     //             textAlign: TextAlign.center,
      //     //             style: TextStyles.callout1.copyWith(fontSize: 10),
      //     //           ),
      //     //         ),
      //     //       ),
      //     //     ],
      //     //   ),
      //     // ),

      //     // Positioned(
      //     //   bottom: 0,
      //     //   right: 12,
      //     //   child: SizedBox(
      //     //     height: 110,
      //     //     child: Image.network(data['image'], fit: BoxFit.contain),
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
