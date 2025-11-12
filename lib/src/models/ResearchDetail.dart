import 'package:flutter/foundation.dart';

class ResearchDetail {
  final String uuid;
  final List<SamplePoint> samplePoints;
  final String name;
  final String description;
  final String status;

  ResearchDetail({
    required this.uuid,
    required this.samplePoints,
    required this.name,
    required this.description,
    required this.status,
  });

  factory ResearchDetail.fromJson(Map<String, dynamic> json) {
    final research = json['research'] ?? json;

    List<dynamic> points = [];
    if (research['samplingPoints'] is List) {
      points = research['samplingPoints'];
    }

    return ResearchDetail(
      uuid: research['uuid'] ?? '',
      name: research['name'] ?? '',
      description: research['description'] ?? '',
      status: research['status'] ?? '',
      samplePoints: points
          .map(
            (point) => SamplePoint.fromJson(
              point is Map<String, dynamic> ? point : <String, dynamic>{},
            ),
          )
          .toList(),
    );
  }
}

class ObservedSpecies {
  final String imageUrl;
  final List<String> images;
  final String nombreComun;
  final String nombreCientifico;
  final String ultimaObservacion;
  final int cantidad;
  final String sexo;
  final String comportamiento;
  final double distance;
  final int males;
  final int females;
  final int undeterminedSexCount;
  final int numberAdults;
  final int juvenileCount;
  final String activity;
  final String substrate;
  final String stratum;
  final String observation;
  final Map<String, double> morphology;

  ObservedSpecies({
    required this.imageUrl,
    required this.images,
    required this.nombreComun,
    required this.nombreCientifico,
    required this.ultimaObservacion,
    required this.cantidad,
    required this.sexo,
    required this.comportamiento,
    required this.distance,
    required this.males,
    required this.females,
    required this.undeterminedSexCount,
    required this.numberAdults,
    required this.juvenileCount,
    required this.activity,
    required this.substrate,
    required this.stratum,
    required this.observation,
    required this.morphology,
  });

  factory ObservedSpecies.fromJson(Map<String, dynamic> json) {
    debugPrint('ObservedSpecies parsing JSON: ${json.keys.toList()}');
    
    String sexoCalculado = 'No especificado';
    int males = int.tryParse(json['males']?.toString() ?? '0') ?? 0;
    int females = int.tryParse(json['females']?.toString() ?? '0') ?? 0;
    
    if (males > 0 && females == 0) {
      sexoCalculado = 'Macho';
    } else if (females > 0 && males == 0) {
      sexoCalculado = 'Hembra';
    } else if (males > 0 && females > 0) {
      sexoCalculado = 'Mixto';
    }

    Map<String, double> morphology = {
      'billLength': double.tryParse(json['morphology']?['billLength']?.toString() ?? '0') ?? 0,
      'wingChord': double.tryParse(json['morphology']?['wingChord']?.toString() ?? '0') ?? 0,
      'tarsusLength': double.tryParse(json['morphology']?['tarsusLength']?.toString() ?? '0') ?? 0,
      'tailLength': double.tryParse(json['morphology']?['tailLength']?.toString() ?? '0') ?? 0,
      'totalLength': double.tryParse(json['morphology']?['totalLength']?.toString() ?? '0') ?? 0,
    };

    return ObservedSpecies(
      imageUrl: json['images']?.isNotEmpty == true 
          ? json['images'][0] 
          : 'https://via.placeholder.com/150',
      images: (json['images'] as List<dynamic>?)?.cast<String>() ?? [],
      nombreComun: json['species'] ?? '',
      nombreCientifico: json['species'] ?? '', 
      ultimaObservacion: json['createdAt'] ?? '',
      cantidad: int.tryParse(json['abundance']?.toString() ?? '0') ?? 0,
      sexo: sexoCalculado,
      comportamiento: json['activity'] ?? 'No especificado',
      distance: double.tryParse(json['distance']?.toString() ?? '0') ?? 0,
      males: males,
      females: females,
      undeterminedSexCount: int.tryParse(json['UndeterminedSexCount']?.toString() ?? '0') ?? 0,
      numberAdults: int.tryParse(json['numberAdults']?.toString() ?? '0') ?? 0,
      juvenileCount: int.tryParse(json['JuvenileCount']?.toString() ?? '0') ?? 0,
      activity: json['activity'] ?? 'No especificado',
      substrate: json['substrate'] ?? 'No especificado',
      stratum: json['stratum'] ?? 'No especificado',
      observation: json['observation'] ?? 'No hay observaciones',
      morphology: morphology,
    );
  }
}

class SamplePoint {
  final String tipoMuestreo;
  final String detalles;
  final String radio;
  final String deteccion;
  final String periodo;
  final String fechaInicio;
  final String fechaFin;
  final List<ObservedSpecies> observedSpecies;

  SamplePoint({
    required this.tipoMuestreo,
    required this.detalles,
    required this.radio,
    required this.deteccion,
    required this.periodo,
    required this.fechaInicio,
    required this.fechaFin,
    required this.observedSpecies,
  });

  factory SamplePoint.fromJson(Map<String, dynamic> json) {
    var speciesList = <ObservedSpecies>[];
    
    if (json['samples'] is List) {
      debugPrint('SamplePoint: Found samples list with ${json['samples'].length} items');
      
      for (var sample in json['samples']) {
        if (sample['observedSpecies'] is List) {
          debugPrint('SamplePoint: Found observedSpecies in sample: ${sample['observedSpecies'].length} species');
          speciesList.addAll(
            (sample['observedSpecies'] as List).map((speciesJson) {
              debugPrint('Processing species: ${speciesJson['species']}');
              return ObservedSpecies.fromJson(
                speciesJson is Map<String, dynamic> ? speciesJson : <String, dynamic>{});
            })
          );
        }
      }
      
      debugPrint('SamplePoint: Mapped total of ${speciesList.length} species from all samples');
    } else {
      debugPrint('SamplePoint: No samples list found in json: ${json.keys.toList()}');
    }
    return SamplePoint(
      tipoMuestreo: (json['samplingType'] ?? '')
          .toString(),
      detalles: (json['detailSamplingType'] ?? '').toString(),
      radio: (json['fixedRadius'] ?? json['radius'] ?? '0').toString(),
      deteccion: (json['detection'] ?? '').toString(),
      periodo: (json['censusPeriod'] ?? '0').toString(),
      fechaInicio: (json['startDate'] ?? '').toString(),
      fechaFin: (json['endDate'] ?? '').toString(),
      observedSpecies: speciesList,
    );
  }
}
