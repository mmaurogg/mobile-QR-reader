import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

//------ funcion para insertar un nuevo scan

class ScanListProvider extends ChangeNotifier{

  List<ScanModel> scans = [];
  String tipoSeleccionado = 'http';

  Future<ScanModel> nuevoScan ( String valor ) async {
    // Crear instancia BD
    final nuevoScan = new ScanModel(valor: valor);
    // insertar en la bd
    final id = await DBProvider.db.nuevoScan(nuevoScan);
    nuevoScan.id = id;

    if( tipoSeleccionado == nuevoScan.tipo){
      // insetar en la interfaz de usuario
      scans.add(nuevoScan);
      // notificar que hubo cambios para que se redibujen los widgets interesados
      notifyListeners();
    }

    return nuevoScan;

  }

  cargarScans() async {
    //Recupero los scans
    final scans = await DBProvider.db.getScans() ;
    //Los asigno a un arreglo
    this.scans = [...scans];
    notifyListeners();
  }

  cargarScanPorTipo( String tipo) async {
    //Recupero los scans
    final scans = await DBProvider.db.getScansByTipo(tipo) ;
    //Los asigno a un arreglo
    this.scans = [...scans];
    this.tipoSeleccionado = tipo;
    notifyListeners();
  }

  borrarTodos() async {
    await DBProvider.db.deleteAllScan() ;
    this.scans = [];
    notifyListeners();
  }

  borrarScanById( id ) async {
    await DBProvider.db.deleteScanById(id) ;
    cargarScanPorTipo( this.tipoSeleccionado);
    // no va notifyListeners(); por que el cargar ya lo tiene
  }

}