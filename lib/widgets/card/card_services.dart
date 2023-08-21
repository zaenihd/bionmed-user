import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/widgets/other/loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/colors.dart';

// ignore: must_be_immutable
class CardServices extends StatelessWidget {
  CardServices({
    Key? key,
    required this.imageUrl,
    required this.name,
    required this.onTap,
    this.isClick = true,
  }) : super(key: key);

  final String imageUrl, name;
  final Function() onTap;
  bool isClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isClick ? onTap : null,
      child: Container(
        padding: const EdgeInsets.only(bottom: 8, left: 6, right: 6),
        // width: MediaQuery.of(context).size.width / 3 - 26,
        // height: 300,
        decoration: BoxDecoration(
          color: AppColor.weak2Color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            CachedNetworkImage(
              imageUrl: imageUrl,
              width: 70.w,
              placeholder: (context, url) => loadingIndicator(),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: 40,
                color: Colors.red,
              ),
            ),
            Text(name,
                textAlign: TextAlign.center,
                style: TextStyles.callout1.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}
