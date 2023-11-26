class BannerModal {
  final int? id;
  final String? shopId;
  final String? redirectUrl;
  final String? area;
  final String? subcatId;
  final String? image;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

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
        shopId = json['shop_id'] as String?,
        redirectUrl = json['redirect_url'] as String?,
        area = json['area'] as String?,
        subcatId = json['subcat_id'] as String?,
        image = json['image'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'shop_id': shopId,
        'redirect_url': redirectUrl,
        'area': area,
        'subcat_id': subcatId,
        'image': image,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
