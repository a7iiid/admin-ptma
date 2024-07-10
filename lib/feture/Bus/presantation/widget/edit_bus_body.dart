import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/google_map/data/model/bus_model.dart';
import 'package:admin/feture/google_map/manegar/cubit/select_rout_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../google_map/data/model/station_model.dart';
import '../../../home/presentation/view/widget/station_menue.dart';
import '../../data/bus.dart';

class EditBusBody extends StatefulWidget {
  EditBusBody({super.key, required this.bus});
  BusModel bus;

  @override
  State<EditBusBody> createState() => _EditBusBodyState();
}

class _EditBusBodyState extends State<EditBusBody> {
  TextEditingController nameBus = TextEditingController();

  TextEditingController numBus = TextEditingController();
  StationModel? sourseStation;

  StationModel? distnationStation;
  bool? isActive;

  @override
  void initState() {
    nameBus.text = SelectRoutCubit.get(context).selectBus.busname;
    numBus.text = SelectRoutCubit.get(context).selectBus.busnumber;
    isActive = SelectRoutCubit.get(context).selectBus.isActive;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: nameBus,
                  decoration:
                      InputDecoration(labelText: 'Bus Name'.tr(context)),
                ),
              ),
              SizedBox(width: 16.0),
              Expanded(
                child: TextFormField(
                  controller: numBus,
                  decoration:
                      InputDecoration(labelText: 'Bus Number'.tr(context)),
                ),
              ),
            ],
          ),
          SizedBox(height: 30),
          DropMenuItem(
            location: sourseStation,
            onChanged: (value) {
              SelectRoutCubit.get(context).selectBus.startStation =
                  value!.stationLocation;
              sourseStation = value;

              SelectRoutCubit.get(context).updateSourceStation(value);
            },
          ),
          const SizedBox(
            height: 10,
          ),
          DropMenuItem(
            location: distnationStation,
            onChanged: (value) {
              SelectRoutCubit.get(context).selectBus.endStation =
                  value!.stationLocation;
              distnationStation = value;

              //SelectRoutCubit.get(context).updateDistnationStation(value);
            },
          ),
          SizedBox(height: 24.0),
          Row(
            children: [
              BlocBuilder<SelectRoutCubit, SelectRoutState>(
                builder: (context, state) {
                  return Checkbox(
                    value: isActive,
                    onChanged: (bool? value) {
                      isActive = value ?? true;
                      SelectRoutCubit.get(context).selectBus.isActive =
                          isActive ?? false;
                      SelectRoutCubit.get(context).enabelBus();
                    },
                  );
                },
              ),
              Text('Is Active'.tr(context))
            ],
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
            onPressed: () async {
              SelectRoutCubit.get(context).selectBus.busname = nameBus.text;
              SelectRoutCubit.get(context).selectBus.busnumber = numBus.text;

              await SelectRoutCubit.get(context).updateBusData();
              Navigator.pop(context); // Close the edit page after saving
            },
            child: Text('Save'.tr(context)),
          ),
        ],
      ),
    );
  }
}
