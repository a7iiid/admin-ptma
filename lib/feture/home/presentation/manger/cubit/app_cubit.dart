import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '/core/utils/ApiServes/map_service.dart';
import '/core/utils/localization/app_localaization.dart';
import '../../../../../core/utils/image_picker/image_picer.dart';
import '../../../../google_map/view/homemap.dart';
import '../../../../history/presantation/history_page.dart';
import '../../view/widget/home_screen.dart';
part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());
  static AppCubit get(context) => BlocProvider.of<AppCubit>(context);
  int selectedPage = 0;
  bool isArabic = false;
  late AuthCredential credential;
  PickImageServes pickImageServes = PickImageServes.get();
//////////////////////////

  Future<void> setUserPictur() async {
    emit(ChangeUserPictiurLoding());

    try {
      await pickImageServes.getImageFromGallery();
      emit(ChangeUserPictiurSuccess());
    } catch (e) {
      emit(ChangeUserPictiurFilur());
    }
  }

  Future<AuthCredential> confirmConiction(String pass) async {
    User user = FirebaseAuth.instance.currentUser!;

    credential =
        EmailAuthProvider.credential(email: user.email!, password: pass);
    return credential;
  }

  Future<void> editProfile(String newName, String newEmail, String pass) async {
    User user = FirebaseAuth.instance.currentUser!;

    await user.reauthenticateWithCredential(credential).then((value) async {
      await user.updateDisplayName(newName); //change new name
      await user.verifyBeforeUpdateEmail(newEmail); //
      //uplode new image
      if (pickImageServes.file != null) {
        await pickImageServes.uplode();

        await user.updatePhotoURL(pickImageServes.url);
      }
      emit(EditProfileSuccess());
    }).catchError((error) {
      print(error.toString());
      emit(EditProfileFaiur());
    });
  }
}
