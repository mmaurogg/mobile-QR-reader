import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/pages/direcciones_page.dart';
import 'package:qr_reader/pages/mapas_page.dart';
import 'package:qr_reader/providers/db_provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/providers/ui_provider.dart';

import '../widges/widgets.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Historial'),
        actions: [
          IconButton(
              onPressed: () {
                //por lo general en un provider si la llamada va en la accion de un boton, debe ir listen false
                Provider.of<ScanListProvider>(context, listen: false).borrarTodos();
              },
              icon: Icon(Icons.delete_forever))
        ],
      ),
      body: _HamePageBody(),

      bottomNavigationBar: CustomNavigatorBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class _HamePageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // Aca consumo el provider para obtener el selected menu opt, para que el provider sepa cual es lo debo poner entre <>
    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    //Pruebas para la base de datos
    //final tempScan = new ScanModel( valor: 'https://www.google.com/');
    //DBProvider.db.nuevoScan(tempScan);
    //DBProvider.db.getScanById(3).then((value) => print(value?.valor));
    //DBProvider.db.getScans().then(print);
    //DBProvider.db.deleteAllScan().then(print);

    // Usar el scanlist provider
    final scanListProvider = Provider.of<ScanListProvider>(context, listen: false);

    switch (currentIndex){
      case 0:
        scanListProvider.cargarScanPorTipo('geo');
        return MapasPage();
      case 1:
        scanListProvider.cargarScanPorTipo('http');
        return DireccionesPage();
      default:
        return MapasPage();
    }
  }
}

