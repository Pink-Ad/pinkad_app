class Area {
  final int? id;
  final int? cityId;
  final String? name;
  final String? code;
  final int? status;
  final DateTime? createdAt; // Changed from String to DateTime
  final DateTime? updatedAt; // Changed from String to DateTime

  Area({
    this.id,
    this.cityId,
    this.name,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Area.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        cityId = json['city_id'] as int?,
        name = json['name'] as String?,
        code = json['code'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] == null // Convert from String to DateTime
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt = json['updated_at'] == null // Convert from String to DateTime
            ? null
            : DateTime.parse(json['updated_at'] as String);

  Map<String, dynamic> toJson() => {
        'id': id,
        'city_id': cityId,
        'name': name,
        'code': code,
        'status': status,
        'created_at': createdAt?.toIso8601String(), // Convert from DateTime to String
        'updated_at': updatedAt?.toIso8601String(), // Convert from DateTime to String
      };
}
