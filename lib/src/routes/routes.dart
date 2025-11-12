import 'package:flutter/material.dart';
import 'package:maquetacion_proyecto/src/pages/Inicio.dart';
import 'package:maquetacion_proyecto/src/pages/Investigaciones.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => Inicio(),
    'investigaciones': (BuildContext context) => Investigaciones(),
  };
}
