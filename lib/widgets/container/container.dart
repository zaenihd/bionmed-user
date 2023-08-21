import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Cntr extends StatelessWidget {
  Cntr(
      {super.key,
      this.width,
      this.height,
      this.color,
      this.margin,
      this.padding,
      this.radius,
      this.image,
      this.border,
      this.boxShadow,
      this.alignment,
      this.gradient,
      this.child});

  double? height;
  double? width;
  EdgeInsetsGeometry? margin;
  EdgeInsetsGeometry? padding;
  BorderRadiusGeometry? radius;
  Color? color;
  Gradient? gradient;
  DecorationImage? image;
  BoxBorder? border;
  List<BoxShadow>? boxShadow;
  AlignmentGeometry? alignment;
  Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: color ?? Colors.white,
          borderRadius: radius,
          image: image,
          border: border,
          gradient: gradient,
          boxShadow: boxShadow),
      child: child,
    );
  }
}
