import 'package:bionmed_app/screens/onboarding/onboarding_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/state_manager.dart';
// import 'package:get/utils.dart';

class OnboardingController extends GetxController {
  var selectedPageIndex = 0.obs;
  bool get isLastPage =>
      selectedPageIndex.value == onboardingScreens.length - 1;
  var pageController = PageController();

  forwardAction() {
    if (isLastPage) {
      //go to home page
    } else
      // ignore: curly_braces_in_flow_control_structures
      pageController.nextPage(duration: 300.milliseconds, curve: Curves.ease);
  }

  List<OnboardingModel> onboardingScreens = [
    OnboardingModel('assets/images/img-splash1.jpg', 'Mudah Berkonsultasi',
        'Konsultasikan kesehatan Anda bersama BIONMED dengan layanan Chatting, Call dan juga Video Call dengan dokter yang Anda pilih.'),
    OnboardingModel('assets/images/img-splash2.jpg', 'Buat Jadwal Anda',
        'Anda juga bisa mengatur jadwal untuk bertemu dan berkonsultasi langsung dengan dokter yang Anda pilih dengan mudah.'),
    OnboardingModel('assets/images/img-splash3.jpg', 'Sehat Dengan BIONMED',
        'Mulai harimu bersama BIONMED dengan layanan-layanan yang dapat memudahkan dalam menjaga dan memelihara kesehatan.')
  ];
}
