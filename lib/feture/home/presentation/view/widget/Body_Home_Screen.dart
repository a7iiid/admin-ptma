import 'dart:developer';
import 'package:admin/core/utils/Style.dart';
import 'package:admin/core/utils/images.dart';
import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/utils/rout.dart';
import '/feture/google_map/manegar/cubit/map_cubit.dart';
import '/feture/google_map/manegar/cubit/select_rout_cubit.dart';
import '/feture/home/presentation/view/widget/map_route_bus.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> items = [
      {
        'route': Routes.kBus,
        'image': Assets.imagesBusy,
        'text': 'Bus',
      },
      {
        'route': Routes.kStation,
        'image': Assets.imagesStation,
        'text': 'Station',
      },
      {
        'route': Routes.kDriver,
        'image': Assets.imagesDriver,
        'text': 'Driver',
      },
    ];

    return MasonryGridView.builder(
      mainAxisSpacing: 8,
      crossAxisSpacing: 5,
      itemCount: items.length, // Set the itemCount to the length of items
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            GoRouter.of(context).push(items[index]['route']);
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Color(0xff64b6ff), // Set the card color
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade200,
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: SvgPicture.asset(
                    items[index]['image'],
                    width: 100,
                    height: 100,
                  ),
                ),
              ),
              Text(items[index]['text'],
                  style: AppStyle.reguler20white
                      .copyWith(color: Colors.white, fontSize: 25)),
            ],
          ),
        );
      },
      gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2),
    );
  }
}
