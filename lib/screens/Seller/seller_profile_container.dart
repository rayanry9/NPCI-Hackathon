import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:uperks/services/firebase_auth.dart';

class SellerProfileContainer extends StatelessWidget {
  const SellerProfileContainer({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 8),
                Text(
                  MyFireBaseAuth().user!.name,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black),
                ),
                Text(
                  "User ID: ${MyFireBaseAuth().user!.id}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          QrImageView(
            data: MyFireBaseAuth().user!.id,
            version: QrVersions.auto,
            size: 150.0,
          ),
          SizedBox(height: 10),
          Text(
            "Your QR code",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Colors.black),
          ),
          SizedBox(height: 20),
          Column(
            children: [
              TextButton(
                onPressed: () {
                  print('update your location ko dabaya');
                  {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Turn on your location to update your location",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                              SizedBox(height: 16),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Update"),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  ;
                },
                child: Text('Update Location'),
              ),
              Divider(
                color: Colors.black26,
                thickness: 1,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Icon(Icons.help),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        "For any queries, kindly mail at ma24btech11018@iith.ac.in",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
