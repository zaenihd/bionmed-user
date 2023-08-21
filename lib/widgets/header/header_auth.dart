import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class HeaderAuth extends StatelessWidget {
  const HeaderAuth({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subtitle
  }) : super(key: key);

  final String imageUrl, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Image.asset(imageUrl),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding:const EdgeInsets.only(top: 8),
        child: Text(
          subtitle,
          style: TextStyle(
            color: AppColor.bodyColor[600],
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
