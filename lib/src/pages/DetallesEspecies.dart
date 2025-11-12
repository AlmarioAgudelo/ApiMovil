import 'package:flutter/material.dart';
import 'package:maquetacion_proyecto/src/components/CustomAppbar.dart';
import '../models/ResearchDetail.dart';

class GuacamayaObservationScreen extends StatelessWidget {
  static const Color primaryGreen = Color(0xFF386641);
  static const Color lightGreen = Color(0xFFE6E8D6);
  static const Color darkBrown = Color(0xFF6B584E);
  static const Color fondocolor =  Color.fromARGB(255, 126, 163, 99);

  final ObservedSpecies especie;
  
  const GuacamayaObservationScreen({
    super.key,
    required this.especie,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: fondocolor,
      body: CustomScrollView(
        slivers: [
          CustomAppBar(title: "Detalles de Especie"),
          SliverList(
            delegate: SliverChildListDelegate([
              _buildHeaderAndCarousel(context),
              _buildObservationDetails(),
              _buildMorfologiaSection(),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderAndCarousel(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: primaryGreen,
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        bottom: 16,
      ),
      child: Column(
        children: [
          const SizedBox(height: 8),
          Text(
            'Observación de ${especie.nombreComun}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...especie.images.map((url) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: _buildImageContainer(url),
                )).toList(),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              especie.images.length,
              (index) => Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                width: index == 0 ? 8.0 : 6.0,
                height: index == 0 ? 8.0 : 6.0,
                decoration: BoxDecoration(
                  color: index == 0 ? Colors.white : Colors.white54,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImageContainer(String imageUrl) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.network(
        imageUrl,
        width: 150,
        height: 150,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 150,
            height: 150,
            color: Colors.grey[300],
            child: const Center(
              child: Text(
                'Imagen no\ndisponible',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildObservationDetails() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Detalles de la Observación',
            Icons.edit_note,
            primaryGreen,
            darkBrown,
          ),
          const Divider(color: primaryGreen),
          _buildDetailRow(
            'Especie:',
            especie.nombreComun,
            Icons.pets,
            darkBrown,
          ),
          _buildDetailRow(
            'Abundancia:',
            '${especie.cantidad} (${especie.males} Machos, ${especie.females} Hembras)',
            Icons.group,
            darkBrown,
          ),
          _buildDetailRow(
            'Adultos y Juveniles:',
            '${especie.numberAdults} adultos, ${especie.juvenileCount} juveniles',
            Icons.person,
            darkBrown
          ),
          _buildDetailRow(
            'Actividad:',
            especie.activity,
            Icons.radar,
            darkBrown
          ),
          _buildDetailRow(
            'Sustrato:',
            especie.substrate,
            Icons.terrain,
            darkBrown,
          ),
          _buildDetailRow(
            'Estrato:',
            especie.stratum,
            Icons.layers,
            darkBrown,
          ),
          _buildDetailRow(
            'Observación:',
            especie.observation,
            Icons.visibility,
            darkBrown,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(
    String label,
    String value,
    IconData icon,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  TextSpan(
                    text: ' $value',
                    style: TextStyle(color: textColor),
                  ),
                ],
              ),
            ),
          ),
          Icon(icon, color: textColor.withOpacity(0.7), size: 18),
        ],
      ),
    );
  }

  Widget _buildMorfologiaSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader(
            'Morfología (cm)',
            Icons.straighten,
            primaryGreen,
            darkBrown,
            trailing: true,
          ),
          const Divider(color: primaryGreen),
          _buildMorfologiaTable(),
        ],
      ),
    );
  }

  Widget _buildMorfologiaTable() {
    final morphologyData = especie.morphology;
    
    return Table(
      defaultColumnWidth: const FlexColumnWidth(1.0),
      border: TableBorder.all(color: Colors.grey.shade300, width: 1),
      children: [
        TableRow(
          decoration: const BoxDecoration(color: lightGreen),
          children: [
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Medida',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),
              ),
            ),
            TableCell(
              verticalAlignment: TableCellVerticalAlignment.middle,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.center,
                child: const Text(
                  'Valor (cm)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: darkBrown,
                  ),
                ),
              ),
            ),
          ],
        ),
        _buildMorphologyRow('Pico', morphologyData['billLength']?.toString() ?? '0'),
        _buildMorphologyRow('Cuerda Ala', morphologyData['wingChord']?.toString() ?? '0'),
        _buildMorphologyRow('Tarso', morphologyData['tarsusLength']?.toString() ?? '0'),
        _buildMorphologyRow('Cola', morphologyData['tailLength']?.toString() ?? '0'),
        _buildMorphologyRow('Total', morphologyData['totalLength']?.toString() ?? '0'),
      ],
    );
  }

  TableRow _buildMorphologyRow(String label, String value) {
    return TableRow(
      decoration: BoxDecoration(
        color: label == 'Pico' ? Colors.grey.shade50 : Colors.white,
      ),
      children: [
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: darkBrown,
              ),
            ),
          ),
        ),
        TableCell(
          verticalAlignment: TableCellVerticalAlignment.middle,
          child: Container(
            padding: const EdgeInsets.all(8.0),
            alignment: Alignment.center,
            child: Text(
              value,
              style: const TextStyle(color: darkBrown),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(
    String title,
    IconData icon,
    Color iconColor,
    Color textColor, {
    bool trailing = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ],
          ),
          if (trailing) Icon(Icons.keyboard_arrow_right, color: textColor),
        ],
      ),
    );
  }
}
