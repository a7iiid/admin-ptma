import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../google_map/manegar/cubit/select_rout_cubit.dart';
import 'edit_bus_body.dart';

class EditBus extends StatelessWidget {
  const EditBus({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Bus".tr(
            context,
          ),
        ),
        centerTitle: true,
      ),
      body: EditBusBody(bus: SelectRoutCubit.get(context).selectBus),
    );
  }
}
