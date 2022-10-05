import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
        child: Icon(Icons.filter_center_focus),
        onPressed: () async {
          String barcodeScanRes =
              //'https://www.qrcode.es/es/generador-qr-code/';
              //'geo:6.256411,-75.590083';

          await FlutterBarcodeScanner.scanBarcode(
              '#3D8BEF',
              'Cancelar',
              false,
              ScanMode.QR);

          // Busca en el arbol de widgets la instancia dle scan list provider

          //Abortar si el usuario cancela
          if ( barcodeScanRes == '-1'){
            return ;
          }

          final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

          final nuevoScan = await scanListProvider.nuevoScan(barcodeScanRes);

          
          launchURL(context, nuevoScan);

        });
  }
}
