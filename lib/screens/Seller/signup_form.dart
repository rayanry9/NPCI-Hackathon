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
  double? offerPercent;
  double? offerThreshold;
  StoreType? selectedCategory;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      MyFireBaseAuth()
          .updateUserData(
        name: sellerName,
        phoneNumber: phoneNumber,
      )
          .then((_) {
        if (context.mounted) {
          final store = StoreModel.withoutId(
              MyFireBaseAuth().user!.id,
              address!,
              storeName!,
              offerPercent!,
              offerThreshold!,
              upiID!,
              selectedCategory!);
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
                      labelText: "Offer Percent",
                      suffixText: "%",
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter offer percent";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      offerPercent = double.parse(val!);
                    },
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Offer Threshold",
                      suffixText: "%",
                      labelStyle: TextStyle(color: Colors.black),
                      errorStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter offer threshold";
                      }
                      return null;
                    },
                    onSaved: (val) {
                      offerThreshold = double.parse(val!);
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
                  DropdownButtonFormField<StoreType>(
                    value: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: "Category of Shop",
                      border: OutlineInputBorder(),
                    ),
                    items: StoreType.values.map((StoreType type) {
                      return DropdownMenuItem<StoreType>(
                        value: type,
                        child: Text(type.toString().split('.').last), 
                      );
                    }).toList(),
                    onChanged: (StoreType? newValue) {
                      setState(() {
                        selectedCategory = newValue;
                      });
                    },
                    onSaved: (val) {
                      selectedCategory = val;
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
