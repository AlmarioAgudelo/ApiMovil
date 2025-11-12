import 'package:flutter/material.dart';
import 'package:maquetacion_proyecto/src/routes/routes.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes(),
      theme: ThemeData.light().copyWith(
        appBarTheme: AppBarTheme(
          color: Color(0xFF2C8861),
          centerTitle: true,
          elevation: 5.0,
        ),
      ),
    );
  }
}
