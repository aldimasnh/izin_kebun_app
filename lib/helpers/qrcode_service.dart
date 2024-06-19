import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:izin_kebun_app/helpers/helpers.dart';
import 'package:izin_kebun_app/helpers/navigator.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQRCode extends StatefulWidget {
  const ScanQRCode({super.key});

  @override
  State<StatefulWidget> createState() => _ScanQRCodeState();
}

class _ScanQRCodeState extends State<ScanQRCode>
    with SingleTickerProviderStateMixin {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final NavigationService _navigationService = NavigationService.instance;

  AnimationController? _animationController;
  Animation<double>? _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController!);
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = calculateScanAreaSize(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    return Stack(
      children: [
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
            borderColor: Colors.white,
            borderRadius: 10,
            borderLength: 30,
            borderWidth: 10,
            cutOutSize: scanArea,
          ),
          onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
        ),
        AnimatedBuilder(
          animation: _animationController!,
          builder: (context, child) {
            return Positioned(
              top: _animation!.value * (scanArea - 2) +
                  (MediaQuery.of(context).size.height - scanArea) / 2,
              left: (MediaQuery.of(context).size.width - scanArea) / 1.85,
              right: (MediaQuery.of(context).size.width - scanArea) / 1.85,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.red,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.6),
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: const Offset(0, -3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        Positioned(
          top: MediaQuery.of(context).size.height / 3.7, // Adjust as needed
          left: 0,
          right: 0,
          child: const Center(
            child: Text(
              'Scan Kode QR Surat Izin disini',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white // Optional background color
                  ),
            ),
          ),
        ),
        Positioned(
          bottom: 20, // Adjust as needed
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_rounded),
                  onPressed: () async {
                    await controller?.pauseCamera();
                    _navigationService.showLoader();
                    Future.delayed(const Duration(milliseconds: 500), () {
                      _navigationService.hideLoader();
                      _navigationService.navigate('/login');
                      controller?.dispose();
                    });
                  },
                  iconSize: 30.0,
                  color: Colors.white,
                ),
              ),
              IconButton(
                icon: FutureBuilder<bool?>(
                  future: controller?.getFlashStatus(),
                  builder: (context, snapshot) {
                    bool flashStatus = snapshot.data ?? false;
                    return flashStatus
                        ? const Icon(Icons.flash_on_rounded)
                        : const Icon(Icons.flash_off_rounded);
                  },
                ),
                onPressed: () async {
                  await controller?.toggleFlash();
                  setState(() {});
                },
                iconSize: 30.0,
                color: Colors.white,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.flip_camera_ios_rounded),
                  onPressed: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                  iconSize: 30.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  double calculateScanAreaSize(double screenWidth, double screenHeight) {
    double scanAreaSize = 300.0;

    if (screenWidth < screenHeight) {
      scanAreaSize = screenWidth * 0.8;
    } else {
      scanAreaSize = screenHeight * 0.8;
    }

    return scanAreaSize < 300.0 ? scanAreaSize : 300.0;
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        result = scanData;
      });

      if (result != null && result!.code != null) {
        await controller.pauseCamera();
        _navigationService.showLoader();
        String decryptedData =
            Helpers.aesDecrypt(result!.code.toString(), 'CBI@2024');

        if (decryptedData.isNotEmpty) {
          await Future.delayed(const Duration(milliseconds: 1500));
          _navigationService.hideLoader();
          _navigationService.navigate('/verification', arguments: {
            'dataQr': decryptedData,
          });
          controller.dispose();
        } else {
          _navigationService.hideLoader();
          _navigationService.navigate('/login');
          controller.dispose();
        }
      }
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    _animationController?.dispose();
    super.dispose();
  }
}
