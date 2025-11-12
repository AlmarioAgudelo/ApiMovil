import 'package:flutter/material.dart';
import '../models/ResearchDetail.dart';
import '../pages/DetallesEspecies.dart';

class RegistroEspecieDetalladoTile extends StatelessWidget {
  final ObservedSpecies especie;


  const RegistroEspecieDetalladoTile({
    Key? key,
    required this.especie,
  }) : super(key: key);

  Widget _buildDataChip(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF4CAF50);
    const Color accentColor = Color(0xFF5A8E5C); 
    const Color buttonColor = Color(
      0xFFE57373,
    ); 

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),

        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GuacamayaObservationScreen(
                  especie: especie,
                ),
              ),
            );
          },
          borderRadius: BorderRadius.circular(12),
          highlightColor: buttonColor.withOpacity(
            0.1,
          ), 

          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        especie.imageUrl,
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 70,
                          height: 70,
                          color: Colors.grey[200],
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 15),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            especie.nombreComun,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: accentColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),

                          Text(
                            especie.nombreCientifico,
                            style: const TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 13,
                              color: Colors.black54,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),

                          const SizedBox(height: 8),

                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_filled,
                                size: 16,
                                color: primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Flexible(
                                child: Text(
                                  'Última Obs.: ${especie.ultimaObservacion}',
                                  style: const TextStyle(
                                    color: primaryColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.black38,
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 85.0, top: 10.0),
                  child: Wrap(
                    spacing: 8.0, 
                    runSpacing: 4.0, 
                    children: [
                      _buildDataChip(
                        'Qty: ${especie.cantidad}',
                        Icons.tag,
                        Colors.blueGrey,
                      ),
                      
                      _buildDataChip(
                        especie.sexo,
                        especie.sexo.toLowerCase() == 'macho'
                            ? Icons.male
                            : (especie.sexo.toLowerCase() == 'hembra'
                                  ? Icons.female
                                  : Icons.person),
                        primaryColor,
                      ),
                      _buildDataChip(
                        especie.comportamiento,
                        Icons
                            .pets_outlined,
                        Colors.orange,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
