import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';
import '../../model/admin.dart';
import '/core/utils/image_picker/image_picer.dart';
import '/core/utils/rout.dart';

part 'auth_state.dart';

class AuthAppCubit extends Cubit<AuthState> {
  AuthAppCubit() : super(changstat());

  static AuthAppCubit get(context) => BlocProvider.of<AuthAppCubit>(context);

  PickImageServes pickImageServes = PickImageServes.get();
  List<Admin> admin = [];

  Future<void> lodeAdmin() async {
    var instans = await FirebaseFirestore.instance.collection('Admin').get();
    log(instans.toString());
    instans.docs.forEach((element) {
      admin.add(Admin.fromJson(element.data()));
    });
  }

  bool adminExist(String email, String pass) {
    for (int i = 0; i < admin.length; i++) {
      if (admin[i].email == email && admin[i].password == pass) {
        return true;
      }
    }
    return false;
  }

  Future<void> SetUserPictur() async {
    emit(ChangeUserPictiurLoding());

    try {
      await pickImageServes.getImageFromGallery();
      emit(ChangeUserPictiurSuccess());
    } catch (e) {
      emit(ChangeUserPictiurFilur());
    }
  }

  void creatAcaunte(String email, String pass, String name, ctx) async {
    emit(createAcunte());
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: pass,
      );
      User? user = userCredential.user;

      if (pickImageServes.file != null) {
        await pickImageServes.uplode();

        await user?.updatePhotoURL(pickImageServes.url);
      }
      await user?.updateDisplayName(name);

      emit(success());

      GoRouter.of(ctx).pushReplacement(Routes.kSigninScreen);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      emit(Filur(e.code));
    } catch (e) {
      print(e);
    }
  }

  Future<void> login(email, passwored, ctx) async {
    if (adminExist(email, passwored)) {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: passwored);

        GoRouter.of(ctx).push(Routes.kHomePage);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }
}
