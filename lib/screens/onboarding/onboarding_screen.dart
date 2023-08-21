import 'package:bionmed_app/constant/colors.dart';
import 'package:bionmed_app/screens/login/login_screen.dart';
import 'package:bionmed_app/screens/onboarding/onboarding_controller.dart';
import 'package:bionmed_app/widgets/button/button_gradient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// import 'package:get/get_state_manager/get_state_manager.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);
  static const routeName = "/onboarding_screen";

  final _controller = OnboardingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller.pageController,
              onPageChanged: _controller.selectedPageIndex,
              itemCount: _controller.onboardingScreens.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // ignore: avoid_unnecessary_containers
                    Container(
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        height: Get.height / 1.25,
                        width: Get.width,
                        child: Image.asset(
                            _controller.onboardingScreens[index].imageAsset,
                            fit: BoxFit.cover),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 300,
                        width: Get.width,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.25),
                              spreadRadius: 7,
                              blurRadius: 10,
                              offset: const Offset(10, 1),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 26, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  _controller.onboardingScreens.length,
                                  (index) => Obx(() {
                                    return Container(
                                      margin: const EdgeInsets.all(4),
                                      width:
                                          _controller.selectedPageIndex.value ==
                                                  index
                                              ? 30
                                              : 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                          color: _controller.selectedPageIndex
                                                      .value ==
                                                  index
                                              ? AppColor.bluePrimary
                                              : AppColor.weakColor,
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                _controller.onboardingScreens[index].title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                _controller
                                    .onboardingScreens[index].description,
                                style: const TextStyle(
                                  color: Color(0xff555555),
                                  fontWeight: FontWeight.w500,
                                  wordSpacing: 2,
                                  letterSpacing: 0.25,
                                  height: 1.25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: TextButton(
                onPressed: () {
                  Get.to(() => const LoginScreen());
                },
                child: Obx(() {
                  return Text(
                    _controller.isLastPage ? '' : 'Lewati',
                    style: TextStyle(color: AppColor.bodyColor[600]),
                  );
                }),
              ),
            ),
            Positioned(
              right: 20,
              bottom: 20,
              child: GestureDetector(
                onTap: _controller.forwardAction,
                child: Obx(() {
                  return _controller.isLastPage
                      ? const SizedBox.shrink()
                      : FloatingActionButton(
                          elevation: 0,
                          onPressed: _controller.forwardAction,
                          child: Container(
                            width: 56,
                            height: 56,
                            // ignore: sort_child_properties_last
                            child: const Icon(
                              Icons.arrow_forward_ios,
                            ),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColor.gradient1,
                            ),
                          ),
                        );
                }),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onTap: _controller.forwardAction,
        child: Obx(() {
          return _controller.isLastPage
              // ignore: sized_box_for_whitespace
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: ButtonGradient(
                      onPressed: () {
                        Get.to(() => const LoginScreen());
                      },
                      label: "Mulai"),
                )
              : const SizedBox.shrink();
        }),
      ),
    );
  }
}
