import 'package:bionmed_app/screens/articel/artikel_binding.dart';
import 'package:bionmed_app/screens/home/home.dart';
import 'package:bionmed_app/screens/home/home_binding.dart';
import 'package:bionmed_app/screens/home/home_screen.dart';
import 'package:bionmed_app/screens/login/login_binding.dart';
import 'package:bionmed_app/screens/login/login_screen.dart';
import 'package:bionmed_app/screens/onboarding/onboarding_binding.dart';
import 'package:bionmed_app/screens/onboarding/onboarding_screen.dart';
import 'package:bionmed_app/screens/payment/metode_pembayaran_screen.dart';
import 'package:bionmed_app/screens/payment/payment_biinding.dart';
import 'package:bionmed_app/screens/payment/payment_screen.dart';
import 'package:bionmed_app/screens/payment/voucher_screen.dart';
import 'package:bionmed_app/screens/pesanan/pesanan_screen.dart';
import 'package:bionmed_app/screens/profile/profile_screen.dart';
import 'package:bionmed_app/screens/register/register_binding.dart';
import 'package:bionmed_app/screens/register/register_screen.dart';
import 'package:bionmed_app/screens/shop/bishop_screen.dart';
import 'package:bionmed_app/screens/splash/splash_screen.dart';
import 'package:bionmed_app/screens/articel/articel_screen.dart';
import 'package:get/get.dart';

import '../../screens/pesanan/pesanan_binding.dart';
import '../../screens/profile/profile_binding.dart';
import '../../screens/shop/bishop_binding.dart';
import '../../screens/splash/splash_binding.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: SplashScreen.routeName,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: OnboardingScreen.routeName,
      page: () => OnboardingScreen(),
      binding: OnboardingScreenBinding(),
    ),
    GetPage(
      name: LoginScreen.routeName,
      page: () => const LoginScreen(),
      binding: LoginScreenBinding(),
    ),
    GetPage(
      name: RegisterScreen.routeName,
      page: () => const RegisterScreen(),
      binding: RegisterScreenBinding(),
    ),
    GetPage(
      name: ProfileScreen.routeName,
      page: () => const ProfileScreen(),
      binding: ProfileScreenBinding(),
    ),
    GetPage(
      name: PaymentScreen.routeName,
      page: () => const PaymentScreen(),
      binding: PaymentScreenBinding(),
    ),
    GetPage(
      name: Home.routeName,
      page: () => const Home(
        indexPage: 0,
      ),
      children: [
        GetPage(
          name: HomeScreen.routeName,
          page: () => const HomeScreen(),
          binding: HomeScreenBinding(),
        ),
        GetPage(
          name: ArticelScreen.routeName,
          page: () => const ArticelScreen(),
          binding: ArtikelScreenBinding(),
        ),
        GetPage(
          name: PesananScreen.routeName,
          page: () => const PesananScreen(),
          binding: PesananScreenBinding(),
        ),
        GetPage(
          name: PesananScreen.routeName,
          page: () => const PesananScreen(),
          binding: PesananScreenBinding(),
        ),
        GetPage(
          name: BishopScreen.routeName,
          page: () => const BishopScreen(),
          binding: BishopScreenBinding(),
        ),
        GetPage(
          name: MetodePaymentScreen.routeName,
          page: () => const MetodePaymentScreen(),
          binding: PaymentScreenBinding(),
        ),
        GetPage(
          name: PaymentScreen.routeName,
          page: () => const PaymentScreen(),
          binding: PaymentScreenBinding(),
        ),
        GetPage(
          name: VoucherScreen.routeName,
          page: () => const VoucherScreen(),
          binding: PaymentScreenBinding(),
        ),
      ],
    ),

    // GetPage(
    //   name: HomeScreen.routeName,
    //   page: () => const HomeScreen(),
    //   binding: BindingsBuilder(() {
    //     Get.lazyPut<ControllerLogin>(() => ControllerLogin());
    //   }),
    // ),
  ];
}
