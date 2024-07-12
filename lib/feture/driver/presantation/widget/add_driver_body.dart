import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/driver/data/manger/cubit/driver_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/Style.dart';
import '../../data/model/Driver.dart';

class AddDriverBody extends StatefulWidget {
  const AddDriverBody({Key? key}) : super(key: key);

  @override
  _AddDriverBodyState createState() => _AddDriverBodyState();
}

class _AddDriverBodyState extends State<AddDriverBody> {
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

  InputDecoration getInputDecoration(String labelText, BuildContext context) {
    return InputDecoration(
      labelText: labelText.tr(context),
      hintStyle: AppStyle.normal24.copyWith(fontSize: 18),
      labelStyle: AppStyle.normal24.copyWith(fontSize: 18),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                style: TextStyle(color: Colors.lightBlue[50]),
                controller: _nameController,
                decoration: getInputDecoration('Name', context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter a name'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Colors.lightBlue[50]),
                controller: _emailController,
                decoration: getInputDecoration('Email', context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter an email'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Colors.lightBlue[50]),
                controller: _phoneController,
                decoration: getInputDecoration('Phone', context),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter a phone number'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Colors.lightBlue[50]),
                controller: _busNumController,
                decoration: getInputDecoration('Bus Number', context),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter a bus number'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                style: TextStyle(color: Colors.lightBlue[50]),
                controller: _salaryController,
                decoration: getInputDecoration('Salary', context),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter a salary'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 30.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Create a Driver object
                    Driver newDriver = Driver(
                      name: _nameController.text,
                      email: _emailController.text,
                      phone: _phoneController.text,
                      bus_num: int.tryParse(_busNumController.text),
                      salary: int.tryParse(_salaryController.text),
                      photo_url: _photoUrlController.text,
                    );

                    // Add the new driver to Firestore
                    await DriverCubit.get(context)
                        .addDriver(newDriver)
                        .then((value) {
                      // Show success message or navigate to another screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text('Driver added successfully'.tr(context))),
                      );
                      Navigator.of(context)
                          .pop(); // Navigate back to previous screen
                    }).catchError((error) {
                      // Show error message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text('Failed to add driver'.tr(context))),
                      );
                    });
                  }
                },
                child: Text(
                  ('Add Driver'.tr(context)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
