import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:flutter/material.dart';
import '/feture/settings/view/widget/settings_body.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
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
        title: Text('Settings'.tr(context)), // Replace with your title
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
          child: SettingsBody()),
    ));
  }
}
