class Research {
  final String uuid;
  final String
  imageUrl; 
  final String title;
  final String subtitle;
  final String dateRange;
  final String location;
  final String estado;
  final String habitat;
  final String vegetacion;
  final String altitud;

  Research({
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

  factory Research.fromJson(Map<String, dynamic> json) {
    String safeString(dynamic value) {
      return (value ?? '').toString();
    }

    final String uuid = safeString(json['uuid']);
    final String imageUrl = safeString(
      json['imageUrl'],
    ); 
    final String title = safeString(json['name']);
    final String subtitle = safeString(json['description']);
    final String estado = safeString(json['status']);
    final String habitat = safeString(json['habitatType']);
    final String vegetacion = safeString(json['dominantVegetation']);
    final String altitud = safeString(json['height']);

    String dateRange;
    final String startDate = safeString(json['startDate']);
    final String endDate = safeString(json['endDate']);
    if (startDate.isNotEmpty || endDate.isNotEmpty) {
      dateRange = '$startDate - $endDate';
    } else {
      dateRange = '';
    }

    String location;
    final Map<String, dynamic>? locality =
        json['locality'] as Map<String, dynamic>?;
    if (locality != null) {
      final String name = safeString(locality['name']);
      final String village = safeString(locality['village']);
      final String neighborhood = safeString(locality['neighborhood']);
      final String city = safeString(locality['city']);
      final String state = safeString(locality['state']);
      final String country = safeString(locality['country']);

      location = [
        name,
        village,
        neighborhood,
        city,
        state,
        country,
      ].where((s) => s.isNotEmpty).join(', ');
    } else {
      location = '';
    }

    return Research(
      uuid: uuid,
      imageUrl: imageUrl,
      title: title,
      subtitle: subtitle,
      dateRange: dateRange,
      location: location,
      estado: estado,
      habitat: habitat,
      vegetacion: vegetacion,
      altitud: altitud,
    );
  }
}
