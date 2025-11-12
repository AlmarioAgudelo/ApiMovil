import 'package:flutter/material.dart';
import '../pages/Especies.dart';
import '../models/ResearchDetail.dart';

class CardPuntosMuestra extends StatelessWidget {
  final String tipoMuestreo;
  final String? detalles;
  final String radio;
  final String deteccion;
  final String periodo;
  final String fechaInicio;
  final String fechaFin;
  final List<ObservedSpecies> observedSpecies;

  const CardPuntosMuestra({
    Key? key,
    required this.tipoMuestreo,
    required this.detalles,
    required this.radio,
    required this.deteccion,
    required this.periodo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.observedSpecies,
  }) : super(key: key);

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: color),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color cardBackgroundColor = Color(0xFFF9F7E8);
    const Color primaryColor = Color(0xFF4CAF50);

    final String detalleValue = (detalles == null || detalles!.isEmpty)
        ? "Sin detalle"
        : detalles!;

    final String radioValue = radio.isEmpty || radio == '0'
        ? "No especificado"
        : "$radio m";

    final String periodoValue = periodo.isEmpty || periodo == '0'
        ? "No especificado"
        : "$periodo minutos";

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: cardBackgroundColor,

      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Detalles del Punto de Muestreo',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.black87,
                  ),
                ),
                Icon(
                  Icons.park_outlined,
                  size: 28,
                  color: primaryColor.withOpacity(0.7),
                ),
              ],
            ),

            const Divider(height: 20, thickness: 1, color: Color(0xFFD2E5C0)),

            _buildInfoRow(
              icon: Icons.pin_drop_outlined,
              label: "Tipo de muestreo:",
              value: tipoMuestreo.isEmpty ? "No especificado" : tipoMuestreo,
              color: primaryColor,
            ),

            _buildInfoRow(
              icon: Icons.public_outlined,
              label: "Detección:",
              value: deteccion,
              color: primaryColor,
            ),

            _buildInfoRow(
              icon: Icons.widgets_outlined,
              label: "Detalle:",
              value: detalleValue,
              color: primaryColor,
            ),

            const SizedBox(height: 10),
            const Divider(height: 0, thickness: 0.5, color: Colors.black12),
            const SizedBox(height: 10),

            _buildInfoRow(
              icon: Icons.radio_button_checked,
              label: "Radio fijo:",
              value: radioValue,
              color: primaryColor,
            ),

            _buildInfoRow(
              icon: Icons.timer_outlined,
              label: "Periodo del censo:",
              value: periodoValue,
              color: primaryColor,
            ),

            const SizedBox(height: 15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildDateChip(
                    label: "Fecha Inicio",
                    value: fechaInicio,
                    icon: Icons.calendar_today,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildDateChip(
                    label: "Fecha Fin",
                    value: fechaFin,
                    icon: Icons.event_available,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Especies(especies: observedSpecies),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5A8E5C),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 3,
                ),
                child: const Text(
                  'Ver Especies Colectadas',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateChip({
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
