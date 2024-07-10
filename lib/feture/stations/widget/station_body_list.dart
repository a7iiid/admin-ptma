import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../google_map/manegar/cubit/map_cubit.dart';
import '../../google_map/manegar/cubit/select_rout_cubit.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class StationBodyList extends StatelessWidget {
  StationBodyList({super.key});
  TextEditingController stationName = TextEditingController();

  @override
  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        stationName.text = MapCubit.get(context).selectStation.name;
        return AlertDialog(
          title: Text('Edit Station Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: stationName,
                decoration: InputDecoration(labelText: 'Station Name'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                if (stationName.text.isNotEmpty) {
                  MapCubit.get(context).selectStation.name = stationName.text;
                  await MapCubit.get(context).updateStation();

                  Navigator.of(context).pop();
                } // Close the dialog
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  Widget build(BuildContext context) {
    var cubit = MapCubit.get(context);
    return BlocBuilder<SelectRoutCubit, SelectRoutState>(
      builder: (context, state) {
        return Expanded(
            child: ListView.builder(
                itemCount: cubit.stationModel.length,
                itemBuilder: (context, index) {
                  return Column(mainAxisSize: MainAxisSize.min, children: [
                    ListTile(
                      title: Text(cubit.stationModel[index].name),
                      onLongPress: () => AwesomeDialog(
                        context: context,
                        dialogType: DialogType.warning,
                        animType: AnimType.bottomSlide,
                        title: 'Delete'.tr(context),
                        desc: 'Are You Sure'.tr(context),
                        btnCancelOnPress: () {},
                        btnOkOnPress: () async {
                          await cubit.deleteStation(cubit.stationModel[index]);
                        },
                      )..show(),
                      onTap: () async {
                        cubit.selectStation = cubit.stationModel[index];
                        _showEditDialog(context);
                      },
                    ),
                    Divider()
                  ]);
                }));
      },
    );
  }
}
