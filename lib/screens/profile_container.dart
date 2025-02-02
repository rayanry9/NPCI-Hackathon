import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key});
  @override
  Widget build(BuildContext context) {
    String upiID = "yadavsaransh06@okicici";
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
                  "USERNAME",
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.black),
                ),
                Text(
                  "UPI ID: $upiID",
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
            data: upiID,
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
              ElevatedButton(
                onPressed: () {
                  print('share points ko dabaya');
                },
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Ensures spacing
                  children: [
                    Icon(Icons.paid), // Left-aligned icon
                    Text("Share points",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_forward), // Right-aligned icon
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('manage your acccount ko dabaya');
                },
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Ensures spacing
                  children: [
                    Icon(Icons.account_circle), // Left-aligned icon
                    Text("Manage your account",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_forward), // Right-aligned icon
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  print('help and feedback ko dabaya');
                },
                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment.spaceBetween, // Ensures spacing
                  children: [
                    Icon(Icons.help), // Left-aligned icon
                    Text("Help and feedback",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Icon(Icons.arrow_forward), // Right-aligned icon
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
