import 'package:admin/feture/driver/presantation/widget/driver_card.dart';
import 'package:admin/feture/driver/data/manger/cubit/driver_cubit.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverBody extends StatelessWidget {
  const DriverBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DriverCubit()..loadDriver(),
      child: BlocBuilder<DriverCubit, DriverState>(
        builder: (context, state) {
          return ListView.builder(
            itemCount: DriverCubit.get(context).drivers.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  DriverCubit.get(context).selecteDriver(index);
                },
                child: DriverCard(
                    driverModel: DriverCubit.get(context).drivers[index]),
              );
            },
          );
        },
      ),
    );
  }
}
