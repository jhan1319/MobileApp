import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_try_project/pages/tercerosEmergency.dart';

import 'directEmergency.dart';

void main() => runApp(Scanner());

class Scanner extends StatefulWidget {
  @override
  _ScannerState createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: const Text(''),
              backgroundColor: Colors.red,
            ),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        /*RaisedButton(
                            onPressed: () => scanBarcodeNormal(),
                            child: Text("Start barcode scan")),*/

                        ElevatedButton(
                            onPressed: () {
                              scanQR();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => tercerosEmergency()),
                              );
                            },
                            child: Flex(
                              direction: Axis.vertical,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.qr_code_scanner_outlined,
                                  size: 50,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text("Escanear QR Cedula")
                              ],
                            )),
                        /*RaisedButton(
                            onPressed: () => scanQR(),
                            child: Text("Scanear cedula QR")),*/
                        /*RaisedButton(
                            onPressed: () => startBarcodeScanStream(),
                            child: Text("Start barcode scan stream")),*/
                        // ignore: unrelated_type_equality_checks
                        ('$_scanBarcode'.toLowerCase() != "unknown")
                            ? scaneado()
                            : Noscaneado(),
                        Text('Resultado del Scan : $_scanBarcode\n',
                            style: TextStyle(fontSize: 20))
                      ]));
            })));
  }

  Widget scaneado() {
    return Text("El código QR ha sido escaneado");
  }

  // ignore: non_constant_identifier_names
  Widget Noscaneado() {
    return Text("Error al escanear el código QR");
  }
}
