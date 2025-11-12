import 'package:flutter/material.dart';
import 'package:maquetacion_proyecto/src/pages/Puntos.dart';

class CardInvestigaciones extends StatelessWidget {
  final String uuid;
  final String imageUrl;
  final String title;
  final String subtitle;
  final String dateRange;
  final String location;
  final String estado;
  final String habitat;
  final String vegetacion;
  final String altitud;

  const CardInvestigaciones({
    super.key,
    required this.uuid,
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.dateRange,
    required this.location,
    required this.estado,
    required this.habitat,
    required this.vegetacion,
    required this.altitud,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Card(
        color: Colors.white,
        elevation: 3,
        shadowColor: Colors.black12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (imageUrl.isNotEmpty)
                SizedBox(
                  width: double.infinity,
                  height: 150,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    headers: const {
                      'Access-Control-Allow-Origin': '*',
                    },
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                    errorBuilder: (context, error, stack) {
                      debugPrint('Error loading image: $error');
                      return Container(
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: const Icon(Icons.broken_image, size: 48),
                      );
                    },
                  ),
                )
              else
                Container(
                  width: double.infinity,
                  height: 150,
                  color: Colors.grey[200],
                  alignment: Alignment.center,
                  child: const Icon(Icons.image, size: 48),
                ),
              const SizedBox(height: 12),

              Text(
                title.isNotEmpty ? title : 'Sin título',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle.isNotEmpty ? subtitle : 'Sin descripción',
                style: const TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 10),

              _infoRow(
                Icons.date_range,
                dateRange.isNotEmpty ? dateRange : '-',
              ),
              _infoRow(Icons.place, location.isNotEmpty ? location : '-'),
              _infoRow(Icons.terrain, habitat.isNotEmpty ? habitat : '-'),
              _infoRow(Icons.nature, vegetacion.isNotEmpty ? vegetacion : '-'),
              _infoRow(Icons.height, altitud.isNotEmpty ? altitud : '-'),
              const SizedBox(height: 8),

              Align(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PuntosPage(uuid: uuid),
                      ),
                    );
                  },
                  child: const Text('Ver Puntos'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Colors.black54),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 15, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
