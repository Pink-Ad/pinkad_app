class OfferList {
  final int? id;
  final int? shopId;
  final int? categoryId;
  final int? subcatId;
  final int? area;
  final String? banner;
  final String? title;
  final String? description;
  final dynamic hashTag;
  final int? views;
  final int? impression;
  final int? reach;
  final int? conversion;
  final int? isFeature;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  //final Shop? shop;

  OfferList({
    this.id,
    this.shopId,
    this.categoryId,
    this.subcatId,
    this.area,
    this.banner,
    this.title,
    this.description,
    this.hashTag,
    this.views,
    this.impression,
    this.reach,
    this.conversion,
    this.isFeature,
    this.status,
    this.createdAt,
    this.updatedAt,
    //this.shop,
  });

  OfferList.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        shopId = json['shop_id'] as int?,
        categoryId = json['category_id'] as int?,
        subcatId = json['subcat_id'] as int?,
        area = json['area'] as int?,
        banner = json['banner'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        hashTag = json['hash_tag'],
        views = json['views'] as int?,
        impression = json['impression'] as int?,
        reach = json['reach'] as int?,
        conversion = json['conversion'] as int?,
        isFeature = json['IsFeature'] as int?,
        status = json['status'] as int?,
        createdAt = json['created_at'] == null // Convert from String to DateTime
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt = json['updated_at'] == null ? null : DateTime.parse(json['updated_at'] as String);
  // shop = (json['shop'] as Map<String, dynamic>?) != null
  //     ? Shop.fromJson(json['shop'] as Map<String, dynamic>)
  //     : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'shop_id': shopId,
        'category_id': categoryId,
        'subcat_id': subcatId,
        'area': area,
        'banner': banner,
        'title': title,
        'description': description,
        'hash_tag': hashTag,
        'views': views,
        'impression': impression,
        'reach': reach,
        'conversion': conversion,
        'IsFeature': isFeature,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        //'shop': shop?.toJson()
      };
}
