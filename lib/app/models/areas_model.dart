class Area {
  final int? id;
  final String? cityId;
  final String? name;
  final String? code;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

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
        cityId = json['city_id'] as String?,
        name = json['name'] as String?,
        code = json['code'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'city_id': cityId,
        'name': name,
        'code': code,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
