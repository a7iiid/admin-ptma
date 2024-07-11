import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/widget/user_image.dart';
import '/core/utils/drawer/drawer.dart';
import '/feture/google_map/manegar/cubit/select_rout_cubit.dart';

import '../../../../google_map/data/model/station_model.dart';
import 'Body_Home_Screen.dart';
import 'drawer_bottom.dart';
import 'greetingslogin.dart';
import 'head_home_page.dart';
import 'station_menue.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController iconController = TextEditingController();

  StationModel? sourseStation;

  StationModel? distnationStation;

  List<DropdownMenuItem<StationModel>>? stationModel;

  @override
  Widget build(BuildContext context) {
    var cubit = SelectRoutCubit.get(context);

    return Scaffold(
        drawer: CustomeDrawer(),
        body: SafeArea(
            child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                const HeadHomePageShape(),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * .08,
                  child: const DrawerBottom(),
                ),
                Positioned(
                    top: MediaQuery.sizeOf(context).height * .1,
                    child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0),
                        child: Greetingslogin())),
                Positioned(
                  top: MediaQuery.sizeOf(context).height * .02,
                  child: SizedBox(
                      height: 130,
                      child: Row(
                        children: [
                          SizedBox(
                            width: MediaQuery.sizeOf(context).width * .68,
                          ),
                          const UserImage(),
                        ],
                      )),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Expanded(
              child: BodyHomeScreen(),
            ),
          ],
        )));
  }
}
