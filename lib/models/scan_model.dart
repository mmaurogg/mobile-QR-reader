import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  ScanModel({
   this.id,
   this.tipo,
   required this.valor,
  }){
    if(valor.contains('http')){
      tipo = 'http';
    } else {
      tipo = 'geo';
    }
  }

  int? id;
  String? tipo;
  String valor;

  LatLng getLatLng(){
    // crear arreglo con coorednadas (latitud, logitud)
    final latLng = valor.substring(4).split(',');
    final lat = double.parse( latLng [0]);
    final lng = double.parse( latLng [1]);

    return LatLng ( lat, lng);
  }


  //Recibe un json y hace una instancia del ScanModel
  factory ScanModel.fromJson( Map<String, dynamic> json ) => ScanModel(
    id: json["id"],
    tipo: json["tipo"],
    valor: json["valor"],
  );

  // convierte la data a un Map
  Map<String, dynamic> toJson() => {
    "id": id,
    "tipo": tipo,
    "valor": valor,
  };

}