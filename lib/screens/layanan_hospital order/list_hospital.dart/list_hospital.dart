import 'package:bionmed_app/widgets/appbar/appbar_gradient.dart';
import 'package:bionmed_app/widgets/container/container.dart';
import 'package:bionmed_app/widgets/txt/text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ListHospital extends StatelessWidget {
  const ListHospital({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbarGradient('Hospital'),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) => Cntr(
          margin: EdgeInsets.only(top: 10, left: 10, right: 10),
          height: 100,
          width: Get.width,
          radius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey[200]!, spreadRadius: 1, blurRadius: 5)
          ],
          child: Row(
            children: [
              Cntr(
                width: 115,
                height: 85,
                radius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: AssetImage('assets/images/hospital.png'),
                    fit: BoxFit.cover
                    ),
              ),
              // Image.network('https://picsum.photos/seed/picsum/200/300'),
              const SizedBox(
                width: 15.0,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    text: 'Rumah Sakit',
                    size: 16,
                    weight: FontWeight.bold,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.green,
                      ),
                      Txt(text: 'Kupang')
                    ],
                  ),
                  Row(
                    children: [
                      RatingBar.builder(
                        itemSize: 20,
                        ignoreGestures: true,
                        initialRating: 5.0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Txt(text: 'Kupang')
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
