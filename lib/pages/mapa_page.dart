import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qr_reader/providers/db_provider.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {

  @override
  State<MapaPage> createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {

  // Controlador del mapa
  Completer<GoogleMapController> _controller = Completer();


  MapType mapType = MapType.normal;

  @override
  Widget build(BuildContext context) {

    //Forma de recibir informacion que se recibe como argumento
    final ScanModel scan = ModalRoute.of(context)!.settings.arguments as ScanModel;

    final CameraPosition puntoInicial = CameraPosition(
      target: scan.getLatLng(),
      zoom: 17,
      tilt: 50
    );

    //Marcadores
    Set<Marker> markers = new  Set<Marker>();
    markers.add(new Marker(
        markerId: MarkerId('geo-location'),
      position: scan.getLatLng()
    ));

    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa'),
        actions: [
          IconButton(
              onPressed: () async {
                final GoogleMapController controller = await _controller.future;
                controller.animateCamera(
                    CameraUpdate.newCameraPosition(CameraPosition(
                        target: scan.getLatLng(),
                      zoom: 17.5,
                      tilt: 50,
                    )
                    )
                );

              },
              icon: Icon(Icons.location_disabled))
        ],
      ),
      body: GoogleMap(
        mapType: mapType,
        markers:  markers,
        initialCameraPosition: puntoInicial,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      // Cambiar el mapa de presentacion
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.layers),
        onPressed: () {
          if (mapType == MapType.normal) {
            mapType = MapType.satellite;
          } else {
            mapType = MapType.normal;
          }

          setState(() {});

        },
      ),
    );
  }
}