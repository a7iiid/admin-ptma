import 'dart:async';

import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:flutter/material.dart';
import '/feture/history/presantation/view/history_body.dart';

class TripHistoryPage extends StatelessWidget {
  const TripHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text('Trip History'.tr(context)),
            ),
            body: HistoryBody()));
  }
}
