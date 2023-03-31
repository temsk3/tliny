import 'package:ai_barcode/ai_barcode.dart';
import 'package:flutter/material.dart';

//ai_barcodeのexampleを参考に最小化したコードスキャンカメラウィジェット
class BarcodeScannerWidget extends StatefulWidget {
  const BarcodeScannerWidget(this.resultCallback, {super.key});
  final dynamic Function(String result) resultCallback;

  @override
  BarcodeScannerWidgetState createState() => BarcodeScannerWidgetState();
}

class BarcodeScannerWidgetState extends State<BarcodeScannerWidget> {
  late ScannerController _scannerController;

  @override
  void initState() {
    super.initState();

    _scannerController = ScannerController(
      scannerResult: (result) {
        widget.resultCallback(result);
      },
      scannerViewCreated: () {
        _scannerController
          ..startCamera()
          ..startCameraPreview();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scannerController
      ..stopCameraPreview()
      ..stopCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: scanCamera(),
        )
      ],
    );
  }

  Widget scanCamera() {
    return PlatformAiBarcodeScannerWidget(
      platformScannerController: _scannerController,
    );
  }
}
