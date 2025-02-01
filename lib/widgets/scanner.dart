import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner {
  static Future<void> scanQrCode(BuildContext context) async {
    Navigator.push<String>(context, MaterialPageRoute(builder: (context) {
      return SizedBox(
        width: 100,
        height: 100,
        child: MobileScanner(onDetect: (capture) {
          final List<Barcode> barcodes = capture.barcodes;
          for (final barcode in barcodes) {
            Navigator.canPop(context)
                ? Navigator.pop<String>(
                    context, barcode.rawValue ?? 'No data in QR')
                : null;
          }
        }),
      );
    })).then((val) {
      print(
          "BROPOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO${val!}");
    });
  }
}
