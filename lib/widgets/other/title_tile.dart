import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class TitleTile extends StatelessWidget {
  const TitleTile({
    Key? key,
    required this.title,
    this.isAll = false,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final bool isAll;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      // ignore: prefer_const_literals_to_create_immutables
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColor.bodyColor,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              overflow: TextOverflow.ellipsis),
        ),
        isAll
            ? GestureDetector(
                onTap: isAll ? onTap : null,
                child: const Text(
                  "",
                  style: TextStyle(
                    color: AppColor.primaryColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
