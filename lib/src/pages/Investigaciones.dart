import 'package:flutter/material.dart';
import 'package:maquetacion_proyecto/src/providers/research_providers.dart';
import 'package:provider/provider.dart';
import '../components/CardInvestigaciones.dart';
import '../components/CustomAppbar.dart';

class Investigaciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final researchProvider = Provider.of<ResearchProvider>(context);

    return Scaffold(
      backgroundColor:  Color.fromARGB(255, 126, 163, 99),
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: "Investigaciones"),
          SliverToBoxAdapter(
            child: researchProvider.isLoading
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(30),
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  )
                : researchProvider.researches.isEmpty
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.all(30),
                          child: Text(
                            'No se encontraron investigaciones',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      )
                    : Column(
                        children: researchProvider.researches.map((inv) {
                          debugPrint('Rendering card for research: ${inv.title}');
                          return CardInvestigaciones(
                        imageUrl: inv.imageUrl,
                        title: inv.title,
                        subtitle: inv.subtitle,
                        dateRange: inv.dateRange,
                        location: inv.location,
                        estado: inv.estado,
                        habitat: inv.habitat,
                        vegetacion: inv.vegetacion,
                        altitud: inv.altitud,
                        uuid: inv.uuid,
                      );
                    }).toList(),
                  ),
          ),
        ],
      ),
    );
  }
}
