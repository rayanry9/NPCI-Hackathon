import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner {
  static Future<String?> scanQrCode(BuildContext context) async {
    final controller = MobileScannerController(
      formats: [BarcodeFormat.qrCode],
    );

    final scanWindow = Rect.fromCenter(
        center: MediaQuery.of(context).size.center(Offset.zero),
        width: 200,
        height: 200);
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) {
        return MobileScanner(
          controller: controller,
          onDetect: (capture) {
            final List<Barcode> barcodes = capture.barcodes;
            for (final barcode in barcodes) {
              Navigator.canPop(context)
                  ? Navigator.pop<String>(
                      context, barcode.rawValue ?? 'No data in QR')
                  : null;
            }
          },
          //scanWindow: scanWindow,
        );
      }),
    );
    await controller.dispose();
    return result;
  }
}
