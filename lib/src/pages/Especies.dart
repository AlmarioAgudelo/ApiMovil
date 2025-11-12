import 'package:flutter/material.dart';
import 'package:maquetacion_proyecto/src/components/CardEspecies.dart';
import 'package:maquetacion_proyecto/src/components/CustomAppbar.dart';
import '../models/ResearchDetail.dart';

class Especies extends StatelessWidget {
  final List<ObservedSpecies> especies;

  const Especies({Key? key, required this.especies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 126, 163, 99),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: "Especies Registradas"),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final especie = especies[index];
                return RegistroEspecieDetalladoTile(
                  especie: especie,
                );
              },
              childCount: especies.length,
            ),
          ),
        ],
      ),
    );
  }
}

