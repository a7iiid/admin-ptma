import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/driver/presantation/widget/add_driver_body.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../data/model/Driver.dart';

class AddDriver extends StatefulWidget {
  const AddDriver({Key? key}) : super(key: key);

  @override
  _AddDriverState createState() => _AddDriverState();
}

class _AddDriverState extends State<AddDriver> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _busNumController = TextEditingController();
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _photoUrlController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _busNumController.dispose();
    _salaryController.dispose();
    _photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff667eea),
                  Color(0xff64b6ff),
                ],
              ),
            ),
          ),
          title: Text(
            ('Add Driver'.tr(context)),
          ),
          centerTitle: true,
        ),
        body: Container(
            height: MediaQuery.sizeOf(context).height,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff667eea),
                  Color(0xff64b6ff),
                ],
              ),
            ),
            child: AddDriverBody()));
  }
}
