import 'dart:developer';

import 'package:admin/feture/driver/data/manger/cubit/driver_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feture/history/presantation/manegar/cubit/history_cubit.dart';

import '../widget/card.dart';

class HistoryBody extends StatelessWidget {
  HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DriverCubit, DriverState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = DriverCubit.get(context);

          if (state is DriverHistorySuccess) {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemCount: state.historyDriver.length,
                  itemBuilder: (context, index) {
                    return CustomCard(
                      history: state.historyDriver[index],
                    );
                  },
                )
              ],
            );
          } else if (state is DriverFailure) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
