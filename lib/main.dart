import 'package:admin/feture/autth/manger/cubit/auth_cubit.dart';
import 'package:admin/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/manger/cubit/loclaization_cubit.dart';
import 'core/utils/cach/cach_helpar.dart';
import 'core/utils/localization/app_localaization.dart';
import 'core/utils/rout.dart';
import 'core/utils/them_app.dart';
import 'feture/driver/data/manger/cubit/driver_cubit.dart';
import 'feture/google_map/manegar/cubit/map_cubit.dart';
import 'feture/google_map/manegar/cubit/select_rout_cubit.dart';
import 'feture/history/presantation/manegar/cubit/history_cubit.dart';
import 'feture/home/presentation/manger/cubit/app_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CachHelper.init();
  bool isArabic = CachHelper.langGetData('isArabic');

  runApp(MyApp(
    isArabic: isArabic,
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isArabic});
  bool isArabic;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MapCubit()..mapServiceApp(),
          ),
          BlocProvider(
            create: (context) => AuthAppCubit(),
          ),
          BlocProvider(
            create: (BuildContext context) {
              return LoclaizationCubit()..changeLang(isArabic);
            },
          ),
          BlocProvider(
            create: (BuildContext context) {
              return AppCubit();
            },
          ),
          BlocProvider(
            create: (context) => SelectRoutCubit(),
          ),
          BlocProvider(
            create: (context) => DriverCubit(),
          ),
          BlocProvider(
            create: (context) => HistoryCubit(),
          ),
        ],
        child: BlocBuilder<LoclaizationCubit, LoclaizationState>(
          builder: (context, state) {
            return MaterialApp.router(
              routerConfig: Routes.router,
              locale: LoclaizationCubit.get(context).isArabic
                  ? Locale('ar')
                  : Locale('en'),
              supportedLocales: const [Locale('en'), Locale('ar')],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate
              ],
              localeResolutionCallback: (deviceLocale, supportedLocales) {
                for (var locale in supportedLocales) {
                  if (deviceLocale != null &&
                      deviceLocale.languageCode == locale.languageCode) {
                    return deviceLocale;
                  }
                }

                return supportedLocales.first;
              },
              debugShowCheckedModeBanner: false,
              theme: ThemeApp.themeapplight,
            );
          },
        ));
  }
}
