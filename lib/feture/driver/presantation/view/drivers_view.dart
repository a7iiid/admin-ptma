import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/driver/presantation/view/driver_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_driver.dart';

class DriversView extends StatelessWidget {
  const DriversView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Driver'.tr(context),
        ),
        centerTitle: true,
      ),
      body: DriverBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddDriver()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
