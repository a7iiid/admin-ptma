import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/images.dart';

class UserImage extends StatelessWidget {
  const UserImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 128.0,
      height: 128.0,
      margin: const EdgeInsets.only(
        top: 34.0,
        bottom: 42,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle,
      ),
      child: FirebaseAuth.instance.currentUser!.photoURL == null
          ? Image.network(
              "https://firebasestorage.googleapis.com/v0/b/ptma-9c13f.appspot.com/o/cms_uploads%2FUsers%2F1718225499895000%2Fistockphoto-1316420668-612x612.jpg?alt=media&token=1192bb4d-b7de-41d9-a982-824becc7a452")
          : Image.network(FirebaseAuth.instance.currentUser!.photoURL!),
    );
  }
}
