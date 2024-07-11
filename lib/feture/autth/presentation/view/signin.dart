import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/utils/rout.dart';
import '/core/utils/Style.dart';
import '/core/utils/images.dart';
import '/core/widget/custom_button.dart';

import '../../../../core/widget/custom_teaxt_form_field.dart';
import '../../manger/cubit/auth_cubit.dart';
import '/core/utils/localization/app_localaization.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  @override
  GlobalKey<FormState> key = GlobalKey<FormState>();

  final emailControlar = TextEditingController();

  final pasControlar = TextEditingController();

  bool isEmail = false;

  bool isPass = false;

  @override
  void dispose() {
    emailControlar.dispose();
    pasControlar.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    await AuthAppCubit.get(context).lodeAdmin();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: Scaffold(
        body: SafeArea(child: BlocBuilder<AuthAppCubit, AuthState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    Assets.imagesLogin,
                  ),
                  Text("Login".tr(context), style: AppStyle.bold28blak),
                  const SizedBox(
                    height: 33,
                  ),
                  CustomTeaxtFormField(
                    controlar: emailControlar,
                    validatText: 'pleas Enter email'.tr(context),
                    hintText: 'Email'.tr(context),
                    labelText: 'Email'.tr(context),
                  ),
                  CustomTeaxtFormField(
                    controlar: pasControlar,
                    validatText: "pleas Enter Passwored".tr(context),
                    hintText: 'Password'.tr(context),
                    labelText: 'Password'.tr(context),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    title: 'Login'.tr(context),
                    backgraondColor: const Color(0xFF2743FB),
                    textStyle: AppStyle.reguler20white,
                    iconcolor: Colors.white,
                    function: () {
                      if (key.currentState!.validate()) {
                        AuthAppCubit.get(context).login(
                            emailControlar.text, pasControlar.text, context);
                      }
                    },
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: Text('or using social '.tr(context)))
                ],
              ),
            );
          },
        )),
      ),
    );
  }
}
