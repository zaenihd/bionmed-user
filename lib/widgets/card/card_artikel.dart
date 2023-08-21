
import 'package:bionmed_app/screens/articel/articel_detail_screen.dart';
import 'package:bionmed_app/screens/home/home_controller.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';

import 'package:intl/intl.dart';

import '../../constant/colors.dart';

class CardArtikel extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
   const CardArtikel({
    Key? key,
    this.data,
    // required this.imageUrl,
    // required this.title,
    // required this.subtitle,
  }) : super(key: key);


  // final String imageUrl, title, subtitle;
  @override
  Widget build(BuildContext context) {
    var date2 = DateFormat('yyyy-MM-dd kk:mm').format(DateTime.parse(
        data['createdAt'] ?? DateTime.now().toLocal().toString()));

    var date1 = DateTime.now().toLocal();
    Duration diff = date1.difference(DateTime.parse(date2));

    // var date2 = DateTime.parse(data['createdAt']);

    return GestureDetector(
      onTap: () {
        Get.find<HomeController>().description.value = data['description'];
        Get.to(() => ArtikelDetailScreen(
              data: data,
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Container(
              margin: const EdgeInsets.only(left: 26),
              height: 90,
              width: MediaQuery.of(context).size.width / 3.25,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                color: Colors.transparent,
              ),
              child: CachedNetworkImage(
                imageUrl: data['image'] ?? "",
                placeholder: (context, url) =>
                    loadingIndicator(color: AppColor.primaryColor),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/images/img-doctor2.png'),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  width: Get.width / 2,
                  child: Text(
                    data['title'] ?? "",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColor.bodyColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: Get.width / 2,
                  child: 
                  SizedBox(
                    height: 60,
                    width: Get.width,
                    child: Html(
                      style: const {},
                    data: data['description'],
                  ),
                  ),
                  // Text(data['description'] ?? '',
                  //   style: const TextStyle(
                  //     fontSize: 12,
                  //     fontWeight: FontWeight.w400,
                  //     color: AppColor.bodyColor,
                  //     overflow: TextOverflow.ellipsis,
                  //   ),
                  // ),
                ),
                const SizedBox(height: 6),
                Text(
                  diff.inDays != 0
                      ? "${diff.inDays} Days"
                      : diff.inHours != 0
                          ? "${diff.inHours} Hours"
                          : "${diff.inMinutes} Minutes",
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w300,
                    color: AppColor.bodyColor[500],
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
