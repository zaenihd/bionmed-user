
import 'package:bionmed_app/constant/colors.dart';
import 'package:flutter/material.dart';

class HeaderCurved extends StatelessWidget {
  const HeaderCurved({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyClipper(),
      child: Container(
        height: 200,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: AppColor.gradient1,
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
