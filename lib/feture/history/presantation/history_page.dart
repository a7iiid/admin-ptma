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
              title: Text('Trip History'.tr(context)),
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
                child: HistoryBody())));
  }
}
