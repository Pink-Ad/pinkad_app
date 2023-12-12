class BannerModal {
  final int? id;
  final int? shopId; // Changed from String to int
  final String? redirectUrl;
  final int? area; // Changed from String to int
  final int? subcatId; // Changed from String to int
  final String? image;
  final int? status;
  final DateTime? createdAt; // Changed from String to DateTime
  final DateTime? updatedAt; // Changed from String to DateTime

  BannerModal({
    this.id,
    this.shopId,
    this.redirectUrl,
    this.area,
    this.subcatId,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  BannerModal.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        shopId = json['shop_id'] as int?,
        redirectUrl = json['redirect_url'] as String?,
        area = json['area'] as int?,
        subcatId = json['subcat_id'] as int?,
        image = json['image'] as String?,
        status = json['status'] as int?,
        createdAt = json['created_at'] == null
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt = json['updated_at'] == null
            ? null
            : DateTime.parse(json['updated_at'] as String);

  Map<String, dynamic> toJson() => {
        'id': id,
        'shop_id': shopId,
        'redirect_url': redirectUrl,
        'area': area,
        'subcat_id': subcatId,
        'image': image,
        'status': status,
        'created_at': createdAt?.toIso8601String(), // Convert from DateTime to String
        'updated_at': updatedAt?.toIso8601String(), // Convert from DateTime to String
      };
}
