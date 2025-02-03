import 'package:flutter/material.dart';
import 'package:uperks/constants/store_type.dart';
import 'package:uperks/models/store_model.dart';
import 'package:uperks/services/firebase_auth.dart';
import 'package:uperks/services/firebase_stores.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});
  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();

  String? sellerName;
  String? storeName;
  String? upiID;
  String? address;
  String? phoneNumber;
  String? emailId;
  double offerPercent = 10;
  double offerThreshold = 40;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      MyFireBaseAuth()
          .updateUserData(
        name: sellerName,
        email: emailId,
        phoneNumber: phoneNumber,
      )
          .then((_) {
        if (context.mounted) {
          final store = StoreModel.withoutId(
              MyFireBaseAuth().user!.id,
              address!,
              storeName!,
              offerPercent,
              offerThreshold,
              upiID!,
              StoreType.cafe);

          MyFireBaseStores().addStore(store).then((val) {
            MyFireBaseStores().updateStoreWithStoreId(val!);
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Signup Successful!"),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/home_seller", (route) => false);
            }
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup Form")),
      body: SingleChildScrollView(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Seller Name",
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter seller name";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      sellerName = val;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Store Name",
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter store name";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      storeName = val;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "UPI ID (Shop)",
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter UPI ID";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      upiID = val;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Address",
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter address";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      address = val;
                    },
                  ),
                  TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                      labelText: "Phone Number",
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter phone number";
                      } else if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                        return "Enter a valid 10-digit phone number";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      phoneNumber = val;
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Email ID",
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter email ID";
                      } else if (!RegExp(
                              r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                          .hasMatch(value)) {
                        return "Enter a valid email";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      emailId = val;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _submitForm();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Submission failed. Ensure all fields are correctly filled."),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
