import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bus/presantation/widget/edit_bus.dart';
import '../../google_map/manegar/cubit/map_cubit.dart';
import '../../google_map/manegar/cubit/select_rout_cubit.dart';
import '../../home/presentation/view/widget/map_route_bus.dart';

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
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditBus()),
                        );
                      },
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
