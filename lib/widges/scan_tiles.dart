import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/utils/utils.dart';

class ScanTiles extends StatelessWidget {

  final String tipo;

  const ScanTiles({required this.tipo});

  @override
  Widget build(BuildContext context) {
    // Busca en el arbol de widgets la instancia dle scan list provider
    // aca necesito oir los cambios (normalmente cuando estoy dentro de un build listen es en true
    final scanListProvider = Provider.of<ScanListProvider>(context);

    final scans = scanListProvider.scans;


    return ListView.builder(
      // los datos de esto los podemos traer del scan list (teoricamente sería d ela base de datos
      itemCount: scans.length,
      //borrar elemento individuales con el dismmissible
      itemBuilder: (_, index) => Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.indigo,
        ),
        // LLamamos la funcion de la base de datos para eliminacion

        onDismissed: (DismissDirection direction){
          Provider.of<ScanListProvider>(context, listen: false).borrarScanById(scans[index].id);
        },
        child: ListTile(
          leading: Icon(
              tipo == 'http'
                  ? Icons.home_outlined
                  : Icons.map_outlined,
              color: Theme.of(context).primaryColor),
          title: Text(scans[index].valor),
          subtitle: Text(scans[index].id.toString()),
          trailing: Icon(Icons.keyboard_arrow_right, color: Colors.grey),
          onTap: () => launchURL(context, scans[index])

        ),
      ),
    );
  }
}
