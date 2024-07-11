import 'package:admin/feture/home/presentation/view/widget/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/utils/drawer/drawer.dart';
import '../../../driver/data/manger/cubit/driver_cubit.dart';
import '/feture/google_map/manegar/cubit/map_cubit.dart';
import '/feture/home/presentation/manger/cubit/app_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AppCubit cubit;
  late MapCubit mapCubit;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    cubit = AppCubit.get(context);
    mapCubit = MapCubit.get(context);
    mapCubit.getStationFromFireBase();
    await DriverCubit.get(context).loadDriver();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<AppCubit, AppState>(
        builder: (context, state) {
          return Scaffold(
            body: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xff667eea),
                      Color(0xff64b6ff),
                    ],
                  ),
                ),
                child: HomeScreen()),
            drawer: const CustomeDrawer(),
          );
        },
      ),
    );
  }
}
