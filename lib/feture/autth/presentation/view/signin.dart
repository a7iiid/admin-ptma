import 'package:admin/core/utils/shapes/login_admin_shap.dart';
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
            return Stack(
              clipBehavior: Clip.none,
              children: [
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        Assets.imagesLogin,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Login Details'.tr(context),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24,
                            fontFamily: 'Outfit',
                            fontWeight: FontWeight.w500,
                            height: 0,
                          ),
                        ),
                      ),
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
                      GestureDetector(
                        child: Container(
                          width: 330,
                          height: 60,
                          decoration: ShapeDecoration(
                            color: Color(0xFF0B6EFE),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                          child: Center(
                            child: Text(
                              'Login'.tr(context),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontFamily: 'Outfit',
                                fontWeight: FontWeight.w700,
                                height: 0,
                              ),
                            ),
                          ),
                        ),
                        onTap: () {
                          if (key.currentState!.validate()) {
                            AuthAppCubit.get(context).login(emailControlar.text,
                                pasControlar.text, context);
                          }
                        },
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
                Positioned(
                    bottom: -MediaQuery.sizeOf(context).height *
                        .27, // Position the CustomPaint at the bottom
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: Size(
                          MediaQuery.sizeOf(context).width,
                          (MediaQuery.sizeOf(context).width *
                                  0.5435897435897435)
                              .toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                      painter: LoginAdminShape(),
                    ))
              ],
            );
          },
        )),
      ),
    );
  }
}
