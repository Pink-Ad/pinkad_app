import 'package:pink_ad/app/models/category_model.dart';
import 'package:pink_ad/app/models/shop_model.dart';
import 'package:pink_ad/app/models/subcategory_model.dart';
import 'package:pink_ad/app/models/user_model.dart';

class Data {
  final int? id;
  final int? userId;
  final int? shopId;
  final int? categoryId;
  final int? subcatId;
  final int? area;
  final String? phone;
  final String? whatsapp;
  final String? businessName;
  final String? businessAddress;
  final String? facebookPage;
  final String? instaPage;
  final String? webUrl;
  final String? banner;
  final String? title;
  final String? description;
  final String? hashTag;
  final int? isFeatured;
  final String? logo;
  final String? reference;
  final int? salesmanId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Shop? shop;
  final Category? category;
  final SubCategory? subcategory;
  final User? user;

  Data({
    this.id,
    this.shopId,
    this.categoryId,
    this.subcatId,
    this.area,
    this.banner,
    this.title,
    this.description,
    this.hashTag,
    this.isFeatured,
    this.phone,
    this.whatsapp,
    this.businessName,
    this.businessAddress,
    this.facebookPage,
    this.instaPage,
    this.webUrl,
    this.status,
    this.logo,
    this.reference,
    this.salesmanId,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.userId,
    this.shop,
    this.category,
    this.subcategory,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        shopId = json['shop_id'] as int?,
        userId = json['user_id'] as int?,
        categoryId = json['category_id'] as int?,
        subcatId = json['subcat_id'] as int?,
        area = json['area'] as int?,
        banner = json['banner'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        hashTag = json['hash_tag'] as String?,
        isFeatured = json['IsFeatured'] as int?,
        status = json['status'] as int?,
        phone = json['phone'] as String?,
        whatsapp = json['whatsapp'] as String?,
        businessName = json['business_name'] as String?,
        businessAddress = json['business_address'] as String?,
        facebookPage = json['faecbook_page'] as String?,
        instaPage = json['insta_page'] as String?,
        webUrl = json['web_url'] as String?,
        logo = json['logo'] as String?,
        reference = json['reference'] as String?,
        salesmanId = json['salesman_id'] as int?,
        createdAt = json['created_at'] == null // Convert from String to DateTime
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt = json['updated_at'] == null // Convert from String to DateTime
            ? null
            : DateTime.parse(json['updated_at'] as String),
        shop = (json['shop'] as Map<String, dynamic>?) != null ? Shop.fromJson(json['shop'] as Map<String, dynamic>) : null,
        category = (json['category'] as Map<String, dynamic>?) != null ? Category.fromJson(json['category'] as Map<String, dynamic>) : null,
        subcategory =
            (json['subcategory'] as Map<String, dynamic>?) != null ? SubCategory.fromJson(json['subcategory'] as Map<String, dynamic>) : null,
        user = (json['user'] as Map<String, dynamic>?) != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'shop_id': shopId,
        'category_id': categoryId,
        'subcat_id': subcatId,
        'phone': phone,
        'whatsapp': whatsapp,
        'business_name': businessName,
        'business_address': businessAddress,
        'faecbook_page': facebookPage,
        'insta_page': instaPage,
        'web_url': webUrl,
        'area': area,
        'banner': banner,
        'title': title,
        'description': description,
        'hash_tag': hashTag,
        'IsFeatured': isFeatured,
        'logo': logo,
        'reference': reference,
        'salesman_id': salesmanId,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'shop': shop?.toJson(),
        'category': category?.toJson(),
        'subcategory': subcategory?.toJson(),
        'user': user?.toJson()
      };
}
