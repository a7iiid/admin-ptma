import 'dart:developer';

import 'package:admin/core/utils/Style.dart';
import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/driver/data/manger/cubit/driver_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feture/history/presantation/manegar/cubit/history_cubit.dart';

import '../widget/card.dart';

class HistoryBody extends StatelessWidget {
  HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverCubit, DriverState>(
      listener: (context, state) {},
      builder: (context, state) {
        log(state.toString());
        var cubit = DriverCubit.get(context);

        if (cubit.history.length > 0) {
          return CustomScrollView(
            slivers: [
              SliverList.builder(
                itemCount: cubit.history.length,
                itemBuilder: (context, index) {
                  return CustomCard(
                    history: cubit.history[index],
                  );
                },
              )
            ],
          );
        } else {
          return Center(
            child: Text(
              "Not have trip".tr(context),
              style: AppStyle.bold28blak,
            ),
          );
        }
      },
    );
  }
}
