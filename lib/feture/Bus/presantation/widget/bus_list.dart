import 'package:admin/feture/Bus/presantation/widget/edit_bus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../google_map/manegar/cubit/map_cubit.dart';
import '../../../google_map/manegar/cubit/select_rout_cubit.dart';
import '../../../home/presentation/view/widget/map_route_bus.dart';

class bodySelecteRout extends StatelessWidget {
  const bodySelecteRout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = SelectRoutCubit.get(context);
    return BlocBuilder<SelectRoutCubit, SelectRoutState>(
      builder: (context, state) {
        return Expanded(
            child: ListView.builder(
                itemCount: cubit.busModel.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.lightBlue[50],
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      title: Text(cubit.busModel[index].busname),
                      trailing: Text(cubit.busModel[index].busnumber),
                      onLongPress: () {
                        cubit.selectBus = cubit.busModel[index];
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => EditBus()),
                        );
                      },
                      onTap: () async {
                        try {
                          // var result = await cubit.destans(
                          //     distnationLocation, busLocation);
                          // cubit.busModel[index].duration = result;
                          var select = cubit.busModel[index];
                          cubit.selectBus = cubit.busModel[index];
                          MapCubit.get(context).setSelectedBus(select);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MapRouteBus()),
                          );
                        } catch (e) {
                          // Handle error
                        }
                      },
                    ),
                  );
                }));
      },
    );
  }
}
