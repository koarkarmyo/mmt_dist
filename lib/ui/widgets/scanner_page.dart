// import 'dart:async';
// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:mmt_mobile/src/extension/navigator_extension.dart';
// import 'package:qr_code_scanner/qr_code_scanner.dart';
//
// class ScannerPage extends StatefulWidget {
//   const ScannerPage({super.key});
//
//   @override
//   State<ScannerPage> createState() => _ScannerPageState();
// }
//
// class _ScannerPageState extends State<ScannerPage> {
//   final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
//   Barcode? result;
//   QRViewController? controller;
//
//   @override
//   void reassemble() {
//     super.reassemble();
//     if (Platform.isAndroid) {
//       controller!.pauseCamera();
//     } else if (Platform.isIOS) {
//       controller!.resumeCamera();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: QRView(
//             key: qrKey,
//             overlay: QrScannerOverlayShape(),
//             onQRViewCreated: _onQRViewCreated));
//   }
//
//   void _onQRViewCreated(QRViewController controller) {
//     StreamSubscription? subscription;
//     this.controller = controller;
//     subscription = controller.scannedDataStream.listen((scanData) async {
//       subscription?.cancel();
//
//       if (context.mounted == true) {
//         context.pop({
//           'data' : scanData.code
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     controller?.dispose();
//     super.dispose();
//   }
// }
