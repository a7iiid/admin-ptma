import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/Bus/presantation/widget/add_bus.dart';
import 'package:admin/feture/Bus/presantation/widget/bus_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/drawer/drawer.dart';
import '../../../google_map/data/model/station_model.dart';
import '../../../home/presentation/view/widget/drawer_bottom.dart';
import '../../../home/presentation/view/widget/greetingslogin.dart';
import '../../../home/presentation/view/widget/head_home_page.dart';
import '../../../home/presentation/view/widget/station_menue.dart';
import '/feture/google_map/manegar/cubit/select_rout_cubit.dart';

class SelectRouts extends StatefulWidget {
  SelectRouts({super.key});

  @override
  State<SelectRouts> createState() => _SelectRoutsState();
}

class _SelectRoutsState extends State<SelectRouts> {
  final TextEditingController iconController = TextEditingController();

  StationModel? sourseStation;

  StationModel? distnationStation;

  List<DropdownMenuItem<StationModel>>? stationModel;

  @override
  Widget build(BuildContext context) {
    var cubit = SelectRoutCubit.get(context);

    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
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
          ),
          title: Text('Bus'.tr(context)), // Replace with your title
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.lightBlue[50],
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddBus()),
            );
          },
          child: Icon(Icons.add),
        ),
        drawer: CustomeDrawer(),
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
              const SizedBox(
                height: 20,
              ),
              BlocConsumer<SelectRoutCubit, SelectRoutState>(
                  listener: (context, state) {
                // TODO: implement listener
              }, builder: (context, state) {
                if (state is LodingBus) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is StreamBusModel) {
                  return const bodySelecteRout();
                } else {
                  SelectRoutCubit.get(context).loadBusModels();
                  return const Center(child: CircularProgressIndicator());
                }
              }),
            ],
          )),
        ));
  }
}
