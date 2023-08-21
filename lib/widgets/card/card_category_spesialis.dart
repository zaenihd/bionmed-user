import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constant/colors.dart';
import '../../constant/styles.dart';

class CardCategorySpesialis extends StatelessWidget {
  const CardCategorySpesialis(
      {Key? key,
      required this.title,
      required this.imageUrl,
      required this.onTap})
      : super(key: key);

  final String title, imageUrl;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColor.weak2Color,
              borderRadius: BorderRadius.circular(8),
            ),
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              // ignore: prefer_const_constructors
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/icons/paru_paru2.png'),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyles.callout1.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}
