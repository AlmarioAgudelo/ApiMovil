import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:maquetacion_proyecto/src/components/CardPuntosMuestra.dart';
import 'package:maquetacion_proyecto/src/components/CustomAppbar.dart';
import 'package:provider/provider.dart';
import '../providers/research_providers.dart';

class PuntosPage extends StatefulWidget {
  final String uuid;

  const PuntosPage({super.key, required this.uuid});

  @override
  _PuntosPageState createState() => _PuntosPageState();
}

class _PuntosPageState extends State<PuntosPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => Provider.of<ResearchProvider>(
        context,
        listen: false,
      ).getResearchDetail(widget.uuid),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 126, 163, 99),
      appBar: AppBar(
        title: const Text(
          'Puntos de Muestra',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: CustomAppBar.barColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 126, 163, 99),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Consumer<ResearchProvider>(
        builder: (context, provider, child) {
          if (provider.isLoadingDetail) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (provider.currentResearchDetail == null) {
            return const Center(
              child: Text(
                'No se encontraron detalles',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            );
          }

          final detail = provider.currentResearchDetail!;

          if (detail.samplePoints.isEmpty) {
            return const Center(
              child: Text(
                'NO HAY PUNTOS',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: [
              SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  final punto = detail.samplePoints[index];
                  return CardPuntosMuestra(
                    tipoMuestreo: punto.tipoMuestreo,
                    detalles: punto.detalles,
                    radio: punto.radio,
                    deteccion: punto.deteccion,
                    periodo: punto.periodo,
                    fechaInicio: punto.fechaInicio,
                    fechaFin: punto.fechaFin,
                    observedSpecies: punto.observedSpecies,
                  );
                }, childCount: detail.samplePoints.length),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          );
        },
      ),
    );
  }
}
