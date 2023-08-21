// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constant/colors.dart';

class ButtonGradient extends StatelessWidget {
  const ButtonGradient({
    Key? key,
    required this.onPressed,
    required this.label,
    this.size,
    this.color,
    this.labelStyle,
    this.height,
    this.margin,
    this.enable = true,
    this.icon,
    this.iconColor,
    this.radius,
    this.addIcon = false,
    this.price,
  }) : super(key: key);

  final Function() onPressed;
  final Color? color;
  final bool enable;
  final double? height;
  final String? icon;
  final Color? iconColor;
  final String label;
  final TextStyle? labelStyle;
  final EdgeInsets? margin;
  final double? size;
  final double? radius;
  final bool addIcon;
  final String? price;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.all(0),
      width: size ?? Get.width,
      height: height ?? 55,
      decoration: BoxDecoration(
        gradient: AppColor.gradient1,
        borderRadius: BorderRadius.circular(5),
      ),
      child: ElevatedButton(
        onPressed: enable ? onPressed : null,
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          onSurface: Colors.transparent,
          // shadowColor: Colors.transparent,
          elevation: 0.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 6.0),
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
