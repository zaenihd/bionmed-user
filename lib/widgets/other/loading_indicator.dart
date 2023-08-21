import 'package:bionmed_app/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

Widget loadingIndicator({Color? color}) {
  return SpinKitFadingCircle(
    size: 35,
    duration: const Duration(seconds: 3),
    color: color ?? AppColor.primaryColor,
  );
}

Widget loadingIndicatorBottom() {
  return const SizedBox(
    height: 32,
    child: Center(
      child: SpinKitThreeBounce(
        size: 8,
        color: AppColor.primaryColor,
      ),
    ),
  );
}
