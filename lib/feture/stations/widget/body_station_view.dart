import 'package:admin/feture/stations/widget/add_station.dart';
import 'package:admin/feture/stations/widget/station_body_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/drawer/drawer.dart';
import '../../google_map/data/model/station_model.dart';
import '../../google_map/manegar/cubit/map_cubit.dart';
import '../../google_map/manegar/cubit/select_rout_cubit.dart';
import '../../home/presentation/view/widget/drawer_bottom.dart';
import '../../home/presentation/view/widget/greetingslogin.dart';
import '../../home/presentation/view/widget/head_home_page.dart';

class BodyStationView extends StatefulWidget {
  BodyStationView({super.key});

  @override
  State<BodyStationView> createState() => _BodyStationViewState();
}

class _BodyStationViewState extends State<BodyStationView> {
  final TextEditingController iconController = TextEditingController();

  StationModel? sourseStation;

  StationModel? distnationStation;

  List<DropdownMenuItem<StationModel>>? stationModel;

  @override
  Widget build(BuildContext context) {
    var cubit = MapCubit.get(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddStation()),
            );
          },
          child: Icon(Icons.add),
        ),
        drawer: const CustomeDrawer(),
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
          child: SafeArea(
              child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  const HeadHomePageShape(),
                  Positioned(
                    top: MediaQuery.sizeOf(context).height * .05,
                    child: const DrawerBottom(),
                  ),
                  Positioned(
                      top: MediaQuery.sizeOf(context).height * .1,
                      child: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          child: Greetingslogin())),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<MapCubit, MapState>(listener: (context, state) {
                // TODO: implement listener
              }, builder: (context, state) {
                return StationBodyList();
              }),
            ],
          )),
        ));
  }
}
