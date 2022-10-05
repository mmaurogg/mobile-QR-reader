import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/ui_provider.dart';

class CustomNavigatorBar extends StatelessWidget {
  const CustomNavigatorBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final uiProvider = Provider.of<UiProvider>(context);
    final currentIndex = uiProvider.selectedMenuOpt;

    return BottomNavigationBar(
        // cambiar de icono en la barra se trabaja de esta forma ya que selectedMenuOpt es un set y no acepta parámetros entre parentesis
        onTap: (int i) => uiProvider.selectedMenuOpt = i,
        currentIndex: currentIndex,
        elevation: 0,
        items: <BottomNavigationBarItem> [
          // Una d ela regla de estos es que tienen que ser dos items
          BottomNavigationBarItem(icon: Icon(Icons.map), label: 'Mapa'),
          BottomNavigationBarItem(icon: Icon(Icons.compass_calibration), label: 'Direcciones'),
        ]
    );
  }
}
