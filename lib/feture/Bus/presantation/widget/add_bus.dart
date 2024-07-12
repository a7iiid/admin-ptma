import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/Bus/data/bus.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/Style.dart';
import '../../../google_map/data/model/station_model.dart';
import '../../../google_map/manegar/cubit/select_rout_cubit.dart';
import '../../../home/presentation/view/widget/station_menue.dart';

class AddBus extends StatelessWidget {
  AddBus({super.key});
  TextEditingController nameBus = TextEditingController();

  TextEditingController numBus = TextEditingController();
  StationModel? sourseStation;

  StationModel? distnationStation;
  bool isActive = false;

  @override
  Widget build(BuildContext context) {
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
        title: Text("Add Bus".tr(context)),
        centerTitle: true,
      ),
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      style: TextStyle(color: Colors.lightBlue[50]),
                      controller: nameBus,
                      decoration: InputDecoration(
                        labelText: 'Bus Name'.tr(context),
                        hintStyle: AppStyle.normal24.copyWith(fontSize: 18),
                        labelStyle: AppStyle.normal24.copyWith(fontSize: 18),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16.0),
                  Expanded(
                    child: TextFormField(
                      controller: numBus,
                      style: TextStyle(color: Colors.lightBlue[50]),
                      decoration: InputDecoration(
                        labelText: 'Bus Number'.tr(context),
                        hintStyle: AppStyle.normal24.copyWith(fontSize: 18),
                        labelStyle: AppStyle.normal24.copyWith(fontSize: 18),
                        enabledBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 30),
              DropMenuItem(
                location: sourseStation,
                onChanged: (value) {
                  sourseStation = value;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropMenuItem(
                location: distnationStation,
                onChanged: (value) {
                  distnationStation = value;
                },
              ),
              SizedBox(height: 24.0),
              Row(
                children: [
                  BlocBuilder<SelectRoutCubit, SelectRoutState>(
                    builder: (context, state) {
                      return Checkbox(
                        value: isActive,
                        checkColor: Colors.blue,
                        activeColor: Colors.white,
                        onChanged: (bool? value) {
                          isActive = value ?? true;
                          SelectRoutCubit.get(context).enabelBus();
                        },
                      );
                    },
                  ),
                  Text(
                    'Is Active'.tr(context),
                    style: AppStyle.normal24,
                  )
                ],
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  Bus bus = Bus(
                      busLocation: GeoPoint(32.4, 35.1),
                      busname: nameBus.text,
                      busnumber: numBus.text,
                      isActive: isActive,
                      endStation: distnationStation!.stationLocation,
                      startStation: sourseStation!.stationLocation);

                  await SelectRoutCubit.get(context).addBus(bus);
                  Navigator.pop(context); // Close the edit page after saving
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
