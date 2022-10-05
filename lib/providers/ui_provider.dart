
import 'package:flutter/cupertino.dart';

//Esta será la clase que nos proveerá la informacion (es un servicio)

class UiProvider extends ChangeNotifier {
  // propiedad que necesito compartir
  int _selectedMenuOpt = 0;

  int get selectedMenuOpt{
    return this._selectedMenuOpt;
  }

  set selectedMenuOpt(int i){
    this._selectedMenuOpt = i;
    //Notificar a los widges de cambios (a todos los que oyen)
    notifyListeners();
  }

}