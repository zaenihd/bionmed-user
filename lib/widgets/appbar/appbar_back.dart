import 'package:flutter/material.dart';

import '../../constant/colors.dart';

AppBar appbarBack() {
    return AppBar(
      iconTheme: const IconThemeData(color: AppColor.bodyColor),
      title: const Text("Kembali"),
      titleTextStyle: const TextStyle(color: AppColor.bodyColor),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
    );
  }