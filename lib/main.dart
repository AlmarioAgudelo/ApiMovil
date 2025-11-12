import 'package:flutter/material.dart';
import 'package:maquetacion_proyecto/src/providers/research_providers.dart';
import 'package:provider/provider.dart';
import 'package:maquetacion_proyecto/src/app.dart';


// HECHO POR: 
//  -> KEVIN ALIRIO ALMARIO AGUDELO 
//  -> DIEGO ARMANDO PÉREZ SANCHÉZ 

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ResearchProvider(),
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}
