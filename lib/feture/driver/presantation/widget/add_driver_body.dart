import 'package:admin/core/utils/localization/app_localaization.dart';
import 'package:admin/feture/driver/data/manger/cubit/driver_cubit.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ('Add Driver'.tr(context)),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: ('Name'.tr(context)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter a name'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: ('Email'.tr(context)),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter an email'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone'.tr(context),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter a phone number'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _busNumController,
                decoration: InputDecoration(
                  labelText: ('Bus Number'.tr(context)),
                ),
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
                controller: _salaryController,
                decoration: InputDecoration(
                  labelText: ('Salary'.tr(context)),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return ('Please enter a salary'.tr(context));
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
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
