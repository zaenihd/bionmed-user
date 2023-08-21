import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/constant/styles.dart';
import 'package:bionmed_app/screens/login/controller_login.dart';
import 'package:bionmed_app/widgets/card/card_artikel.dart';
import 'package:bionmed_app/widgets/other/title_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ArtikelDetailScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const ArtikelDetailScreen({Key? key, this.data}) : super(key: key);

  @override
  State<ArtikelDetailScreen> createState() => _ArtikelDetailScreenState();
}

class _ArtikelDetailScreenState extends State<ArtikelDetailScreen> {
  bool isBookmark = false;

  void _clickBookmark() {
    setState(() {
      isBookmark = !isBookmark;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          appBarNews(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 26),
            height: 235,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.data['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 21),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Text(
              widget.data['title'] ?? "",
              style: const TextStyle(
                color: AppColor.bodyColor,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: Row(
              children: [
                Text(
                  "${DateFormat('HH:mm', 'id_ID').format(DateTime.parse(
                          widget.data['createdAt'] ??
                              DateTime.now().toString()))} WIB",
                  style: TextStyle(
                    color: AppColor.bodyColor[700],
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  DateFormat('dd MMMM yyyy', 'id_ID').format(DateTime.parse(
                      widget.data['createdAt'] ?? DateTime.now().toString())),
                  style: TextStyle(
                    color: AppColor.bodyColor[700],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // ignore: prefer_const_constructors
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 26),
            child: 
             Html(
                    data: widget.data['description'],
                  ),
            // Text(
            //   widget.data['description'] ?? "",
            //   style: TextStyle(
            //     wordSpacing: 2,
            //     letterSpacing: 0.25,
            //   ),
            // ),
          ),
          const SizedBox(height: 28),
          SizedBox(height: defaultPadding),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: defaultPadding),
            child: TitleTile(
                title: "Baca 100+ Artikel Terbaru", onTap: () {}, isAll: true),
          ),
          SizedBox(height: defaultPadding),
          ListView.builder(
            scrollDirection: Axis.vertical,
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: Get.find<ControllerLogin>().dataArticel.length,
            itemBuilder: (BuildContext context, int index) {
              return CardArtikel(
                data: Get.find<ControllerLogin>().dataArticel[index],
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Row appBarNews() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              Get.back();
            });
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(26, 20, 26, 16),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.075),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(3, 5),
                ),
              ],
            ),
            child: const Icon(
              Icons.arrow_back,
              size: 20,
            ),
          ),
        ),
        RichText(
          text: const TextSpan(
            text: "Bion",
            style: TextStyle(
              color: AppColor.primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 22,
            ),
            children: [
              TextSpan(
                text: "med.id",
                style: TextStyle(
                    color: AppColor.bodyColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 22),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _clickBookmark();
            });
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(26, 20, 26, 16),
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              // color: AppColor.whiteColor,
              color: isBookmark ? AppColor.primaryColor : AppColor.whiteColor,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.075),
                  spreadRadius: 3,
                  blurRadius: 10,
                  offset: const Offset(3, 5),
                ),
              ],
            ),
            child: Icon(
              isBookmark ? Icons.bookmark : Icons.bookmark_outline,
              color: isBookmark ? AppColor.whiteColor : AppColor.bodyColor,
              size: 20,
            ),
          ),
        ),
      ],
    );
  }
}
