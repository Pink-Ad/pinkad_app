class Cities {
  final int? id;
  final String? name;
  final String? code;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Cities({
    this.id,
    this.name,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Cities.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        code = json['code'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}

class City {
  int id;
  String name;

  City({required this.id, required this.name});
}
