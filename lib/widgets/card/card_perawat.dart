import 'package:bionmed_app/screens/layanan_nurse_home/controller/input_layanan_controller.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/screens/profile_doctor/detail_nurse.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

// ignore: must_be_immutable
class CardPerawat extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  int? id;
   CardPerawat({Key? key, this.data,required this.id}) : super(key: key);

  @override
  State<CardPerawat> createState() => _CardPerawatState();
}

final cLog = Get.find<ControllerLogin>();

class _CardPerawatState extends State<CardPerawat> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Get.find<InputLayananController>().idNurse.value = widget.id!;
        // ignore: avoid_print
        print('zezen + ${Get.find<InputLayananController>().idNurse.value}');
        await Get.find<InputLayananController>().getDetailNurse();
        Get.find<InputLayananController>().educationNurse.value = Get.find<InputLayananController>().detailNurse['nurse_educations'];
        // cLog.isloading.isTrue
        //     ? showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return Align(
        //             alignment: Alignment.center,
        //             child: Container(
        //               width: 300.0,
        //               height: 200.0,
        //               decoration: BoxDecoration(
        //                 color: Colors.transparent,
        //                 borderRadius: BorderRadius.circular(10.0),
        //               ),
        //               child: Padding(
        //                 padding: EdgeInsets.all(20.0),
        //                 child: Center(child: CircularProgressIndicator()),
        //               ),
        //             ),
        //           );
        //         },
        //       )
        //     : 

            Get.to(() => const DetailNurse());
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultPadding, vertical: 7),
        padding: const EdgeInsets.all(6),
        height: 128,
        width: Get.width,
        decoration: BoxDecoration(
          color: AppColor.whiteColor,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [AppColor.shadow],
        ),
        child: Row(
          children: [
            // Image.network(widget.data['image']),
            CachedNetworkImage(
              imageUrl: widget.data['image'],
              width: 100.w,
              placeholder: (context, url) =>
                  loadingIndicator(color: AppColor.primaryColor),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/images/img-doctor2.png'),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SizedBox(
                  width: 150.w,
                  child: Text(
                    widget.data['name']?? "Name",
                    style: const TextStyle(
                      overflow: TextOverflow.clip,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                // Text(
                //   widget.data['specialist']['name'] ?? "",
                //   style: TextStyle(fontWeight: FontWeight.w300),
                // ),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColor.bgForm,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        Icon(
                          Icons.business_center,
                          size: 16,
                          color: AppColor.bodyColor[700],
                        ),
                        const SizedBox(width: 6),
                        // SizedBox(
                        //   width: 100.w,
                        //   child: Text(
                        //       widget.data['experience'] ??"10",
                        //       style: TextStyles.callout2),
                        // ),
                      ]),
                    ),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColor.bgForm,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      // ignore: prefer_const_literals_to_create_immutables
                      child: Row(children: [
                        Icon(
                          Icons.person,
                          size: 16,
                          color: AppColor.bodyColor[700],
                        ),
                        const SizedBox(width: 6),
                        Text(widget.data['old'].toString(),
                            style: TextStyles.callout2),
                      ]),
                    ),
                  ],
                ),
              ],
            ),
          
          ],
        ),
      ),
    );
  }
}
