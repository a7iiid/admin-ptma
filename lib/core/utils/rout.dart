import 'package:admin/core/utils/splash/splash.dart';
import 'package:admin/feture/Bus/bus_view.dart';
import 'package:admin/feture/admin/admin_view.dart';
import 'package:admin/feture/driver/presantation/view/drivers_view.dart';
import 'package:admin/feture/stations/station_view.dart';
import 'package:go_router/go_router.dart';
import '/../feture/autth/presentation/view/signin.dart';
import '../../feture/driver/presantation/widget/add_driver_body.dart';
import '/../feture/home/presentation/view/home_page.dart';
import '/../feture/settings/view/settings.dart';
import '/../feture/user_profile/presntation/view/widget/edit_profile_page.dart';

import '../../feture/home/presentation/view/widget/home_screen.dart';

abstract class Routes {
  static const kMainScreen = '/mainScreen';
  static const kSigninScreen = '/signinscreen';
  static const kSignUpScreen = '/signupscreen';
  static const kHomePage = '/homepage';
  static const kSelectRouts = '/selectrout';
  static const kSettings = '/settings';
  static const kEditProfilePage = '/editProfile';
  static const kMapRouteBus = '/maproutebus';
  static const kBus = '/bus';
  static const kStation = '/station';
  static const kAdmin = '/admin';
  static const kDriver = '/driver';

  static final router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return SplashView();
      },
    ),
    GoRoute(
      path: kSigninScreen,
      builder: (context, state) {
        return const SignInScreen();
      },
    ),
    GoRoute(
      path: kSignUpScreen,
      builder: (context, state) {
        return const AddDriverBody();
      },
    ),
    GoRoute(
      path: kHomePage,
      builder: (context, state) {
        return HomePage();
      },
    ),
    GoRoute(
      path: kSelectRouts,
      builder: (context, state) {
        return HomeScreen();
      },
    ),
    GoRoute(
      path: kSettings,
      builder: (context, state) {
        return Settings();
      },
    ),
    GoRoute(
      path: kEditProfilePage,
      builder: (context, state) {
        return EditProfilePage();
      },
    ),
    GoRoute(
      path: kBus,
      builder: (context, state) => BusView(),
    ),
    GoRoute(
      path: kDriver,
      builder: (context, state) {
        return DriversView();
      },
    ),
    GoRoute(
      path: kStation,
      builder: (context, state) {
        return StationView();
      },
    ),
    GoRoute(
      path: kAdmin,
      builder: (context, state) {
        return AdminView();
      },
    ),
  ]);
}
