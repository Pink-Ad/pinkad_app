class Category {
  final int? id;
  final String? name;
  final String? code;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Category({
    this.id,
    this.name,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Category.fromJson(Map<String, dynamic> json)
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

<<<<<<< Updated upstream
class SubCategory {
  final int? id;
  final String? categoryId;
  final String? name;
  final String? code;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  SubCategory({
    this.id,
    this.categoryId,
    this.name,
    this.code,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  SubCategory.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        categoryId = json['category_id'] as String?,
        name = json['name'] as String?,
        code = json['code'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'category_id': categoryId,
        'name': name,
        'code': code,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
=======
>>>>>>> Stashed changes
