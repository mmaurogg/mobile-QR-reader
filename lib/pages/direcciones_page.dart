import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_reader/providers/scan_list_provider.dart';
import 'package:qr_reader/widges/scan_tiles.dart';

class DireccionesPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    return ScanTiles(tipo: 'http');
  }
}