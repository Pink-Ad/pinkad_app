class Cities {
  final int? id;
  final String? name;
  final String? code;
  final int? status;
   final DateTime? createdAt;
  final DateTime? updatedAt;

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
        status = json['status'] as int?,
        createdAt = json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt = json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String);


  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'code': code,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String()
      };
}

class City {
  int id;
  String name;

  City({required this.id, required this.name});
}
