import 'package:admin/feture/driver/data/model/DriverModel.dart';
import 'package:admin/feture/driver/presantation/widget/driver_card.dart';
import 'package:flutter/widgets.dart';

class DriverBody extends StatelessWidget {
  const DriverBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DriverCard(
      driverModel: DriverModel(
          driverName: 'driverName',
          phoneNumber: 'phoneNumber',
          busNum: 'busNum',
          email: 'email'),
    );
  }
}
