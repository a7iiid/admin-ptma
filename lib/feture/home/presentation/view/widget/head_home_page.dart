import 'package:flutter/material.dart';
import '/core/utils/shapes/home_screen.dart';

class HeadHomePageShape extends StatelessWidget {
  const HeadHomePageShape({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(MediaQuery.sizeOf(context).width,
          (MediaQuery.sizeOf(context).width * 0.7433155080213903).toDouble()),
      painter: HomePageShape(),
    );
  }
}
