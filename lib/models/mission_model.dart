class Mission {
  final String id;
  final String name;
  final double lat;
  final double lng;
  final String? description;
  final bool isCompleted;

  const Mission({
    required this.id,
    required this.name,
    required this.lat,
    required this.lng,
    this.description,
    this.isCompleted = false,
  });

  Mission copyWith({
    String? id,
    String? name,
    double? lat,
    double? lng,
    String? description,
    bool? isCompleted,
  }) {
    return Mission(
      id: id ?? this.id,
      name: name ?? this.name,
      lat: lat ?? this.lat,
      lng: lng ?? this.lng,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  String toString() => 'Mission(id: $id, name: $name, lat: $lat, lng: $lng)';
}