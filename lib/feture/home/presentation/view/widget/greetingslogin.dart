import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '/core/utils/Style.dart';
import '/core/utils/localization/app_localaization.dart';

class Greetingslogin extends StatelessWidget {
  const Greetingslogin({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const SizedBox(
                width: 30,
              ),
              Text(
                DateTime.now().hour < 12
                    ? " ${"Good morning".tr(context)} "
                    : "${"Good evening".tr(context)} ",
                style: AppStyle.normal40,
              ),
              if (DateTime.now().hour < 12)
                const Icon(
                  Icons.sunny,
                  color: Colors.yellow,
                )
              else
                const Icon(
                  Icons.nightlight_round_outlined,
                  color: Colors.white,
                  size: 25,
                ),
            ],
          ),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width * .3,
              ),
              Text(
                FirebaseAuth.instance.currentUser!.displayName.toString(),
                style: AppStyle.normal40,
              ),
            ],
          )
        ],
      ),
    );
  }
}
