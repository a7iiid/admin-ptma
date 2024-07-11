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
        title: Text('Driver'.tr(context)), // Replace with your title
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
          child: DriverBody()),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
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
