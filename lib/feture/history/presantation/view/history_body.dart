import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feture/history/presantation/manegar/cubit/history_cubit.dart';

import '../widget/card.dart';

class HistoryBody extends StatelessWidget {
  HistoryBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => HistoryCubit()..loadTripsForCurrentUser(),
        child: BlocConsumer<HistoryCubit, HistoryState>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = HistoryCubit.get(context);

            if (state is HistorySuccess) {
              return CustomScrollView(
                slivers: [
                  SliverList.builder(
                    itemCount: state.history.length,
                    itemBuilder: (context, index) {
                      return CustomCard(
                        history: state.history[index],
                      );
                    },
                  )
                ],
              );
            } else if (state is HistoryFailure) {
              return state.error;
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
