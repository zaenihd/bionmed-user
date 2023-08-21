import 'package:flutter/material.dart';

import '../../constant/colors.dart';

AppBar appbarGradient(String title){
  return AppBar(
    title: Text(title),
    elevation: 0.0,
    actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.history))],
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: AppColor.gradient1,
      ),
    ),
  );
}
