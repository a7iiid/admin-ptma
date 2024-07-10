import 'package:admin/feture/driver/presantation/widget/driver_card.dart';
import 'package:flutter/widgets.dart';

class DriverBody extends StatelessWidget {
  const DriverBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DriverCard(
      busNum: '',
      driverName: '',
      phoneNumber: '',
      photoUrl: '',
    );
  }
}
