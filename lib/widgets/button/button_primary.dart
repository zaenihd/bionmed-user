import 'package:flutter/material.dart';

import '../../constant/colors.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
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
    this.textColor
  }) : super(key: key);

  final Function() onPressed;
  final Color? color;
  final bool enable;
  final double? height;
  final String? icon;
  final Color? iconColor;
  final Color? textColor;
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
        margin: margin ?? EdgeInsets.zero,
        height: height ?? 55,
        width: size ?? double.infinity,
        decoration: BoxDecoration(
          // gradient: AppColor.gradient1,
          borderRadius: BorderRadius.circular(radius ?? 6.0),
        ),
        child: ElevatedButton(
            onPressed: enable ? onPressed : null,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  enable ? color ?? Colors.blue : AppColor.bodyColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius ?? 6.0),
              ),
            ),
            child: Text(
              label,
              style: labelStyle ??  TextStyle(color: textColor ?? Colors.white),
              textAlign: TextAlign.center,
            )));
  }
}
