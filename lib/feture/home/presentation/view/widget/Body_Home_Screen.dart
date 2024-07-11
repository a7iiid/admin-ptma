import 'dart:developer';
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

class BodyHomeScreen extends StatelessWidget {
  const BodyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns
                ),
                children: [
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(Routes.kBus);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set your desired background color here
                            borderRadius: BorderRadius.circular(
                                12.0), // Set border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Set shadow color
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.imagesBusy,
                              width:
                                  100, // Adjust width and height as per your SVG's dimensions
                              height: 100,
                            ),
                          ),
                        ),
                        Text(
                          'Bus'.tr(context),
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(Routes.kStation);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set your desired background color here
                            borderRadius: BorderRadius.circular(
                                12.0), // Set border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Set shadow color
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.imagesStation,
                              width:
                                  100, // Adjust width and height as per your SVG's dimensions
                              height: 100,
                            ),
                          ),
                        ),
                        Text(
                          'Station'.tr(context),
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      GoRouter.of(context).push(Routes.kDriver);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Set your desired background color here
                            borderRadius: BorderRadius.circular(
                                12.0), // Set border radius
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // Set shadow color
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              Assets.imagesDriver,
                              width:
                                  100, // Adjust width and height as per your SVG's dimensions
                              height: 100,
                            ),
                          ),
                        ),
                        Text(
                          'Driver'.tr(context),
                          style: TextStyle(color: Colors.black, fontSize: 16.0),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
