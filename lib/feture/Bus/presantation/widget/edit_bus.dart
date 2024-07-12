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
        title: Text(
          "Edit Bus".tr(
            context,
          ),
        ),
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
          child: EditBusBody()),
    );
  }
}
