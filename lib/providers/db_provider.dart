import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:qr_reader/models/scan_model.dart';
// ya que necesito trabajar en otras partes con el scan, o exporto tambien
export 'package:qr_reader/models/scan_model.dart';


// esta clase se crea apara hacer un singleton de la instancia d ela base de datos
class DBProvider {

  static Database? _database;

  // constructor publico
  static final DBProvider db = DBProvider._();

  // constructor privado: mantiene el singleton por que siempre devuelve la misma instancia
  DBProvider._();

  // acceder al obeto del DB, es un metodo async por que consulta la base de datos
  Future <Database> get database async {
    //Validacion para saber si esta instanciado
    if (_database != null) {
      return _database!;
    };

    // ingreso a la base de datos
    _database = await initDB();

    return _database!;
  }

  Future <Database> initDB() async {
    //path donde se almacena la base de datos
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    //join servira para unir los pedazos de path (el path  actual con la base de datos 'ScansDB,db' proviene de la extensión
    final path = join(documentsDirectory.path, 'ScansDB,db');
    print(path);

    // Crear base de datos
    return await openDatabase(
        path,
        // cada vez que se haga cambios a la base de datos se debe incrementar esta version ento con el fin que actualice las tablas
        version: 4,
        //Esta creará la base de datos
        onCreate: (db, version) async {
          //String multilinea se hace con ''' '''
          //Query de BD
          await db.execute(''' 
            CREATE TABLE Scans(
              id INTEGER PRIMARY KEY,
              tipo TEXT,
              valor TEXT
              )
          ''');
        }
    );
  }

  //Primer método
  // toda la info de la base de datos la puedo recibir del ScanModel
  nuevoScanRaw(ScanModel nuevoScan) async {
    //Propiedades del scan
    final id = nuevoScan.id;
    final tipo = nuevoScan.tipo;
    final valor = nuevoScan.valor;


    // llamada al getter de la clase
    final db = await database;

    final res = await db.rawInsert('''
      INSERT INTO Scans( id, tipo, valor)
        VALUES($id, '$tipo', '$valor') 
    ''');

    return res;
  }


  // Segundo metodo
  Future<int> nuevoScan(ScanModel nuevoScan) async {
    final db = await database;
    final res = await db.insert('Scans', nuevoScan.toJson());
    // la respuesta es el id
    return res;
  }

  // recuperar registros
  Future<ScanModel?> getScanById(int id) async {
    final db = await database;
    //busqueda en la bd
    final res = await db.query('Scans', where: 'id = ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getScans() async {
    final db = await database;
    //busqueda en la bd
    final res = await db.query('Scans');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<List<ScanModel>> getScansByTipo( String tipo ) async {
    final db = await database;
    //busqueda en la bd otra forma de hacerlo
    final res = await db.rawQuery('''
      SELECT * FROM Scans WHERE tipo = '$tipo'
    ''');

    return res.isNotEmpty
        ? res.map((s) => ScanModel.fromJson(s)).toList()
        : [];
  }

  Future<int> updateScan (ScanModel nuevoScan) async {
    final db =await database;
    // Query de actualizacion OJO este necesita were para que no sobre escriba toda la bd
    // el poner entre [] el where args permite buscar las coincidencias
    final res = await db.update('Scans', nuevoScan.toJson(), where: 'id = ?', whereArgs: [nuevoScan.id]);
    return res;
  }

  Future<int> deleteScanById (int id ) async {
    final db =await database;
    final res = await db.delete('Scans', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAllScan () async {
    final db =await database;
    // primer metodo
    //final res = await db.delete('Scans');
    // Segundo metodo
    final res = await db.rawDelete('''DELETE FROM Scans''');
    return res;
  }

}