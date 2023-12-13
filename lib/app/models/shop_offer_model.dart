import 'shop_model.dart';

class ShopOffer {
  final int? id;
  final int? shopId;
  final int? categoryId;
  final int? subcatId;
  final int? area;
  final String? banner;
  final String? title;
  final String? description;
  final String? hashTag;
  final int? views;
  final int? impression;
  final int? reach;
  final int? conversion;
  final int? isFeature;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final Shop? shop;

  ShopOffer({
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
    this.shop,
  });

  ShopOffer.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        shopId = json['shop_id'] as int?,
        categoryId = json['category_id'] as int?,
        subcatId = json['subcat_id'] as int?,
        area = json['area'] as int?,
        banner = json['banner'] as String?,
        title = json['title'] as String?,
        description = json['description'] as String?,
        hashTag = json['hash_tag'] as String?,
        views = json['views'] as int?,
        impression = json['impression'] as int?,
        reach = json['reach'] as int?,
        conversion = json['conversion'] as int?,
        isFeature = json['IsFeature'] as int?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        shop = (json['shop'] as Map<String, dynamic>?) != null
            ? Shop.fromJson(json['shop'] as Map<String, dynamic>)
            : null;

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
        'created_at': createdAt,
        'updated_at': updatedAt,
        'shop': shop?.toJson()
      };
}

<<<<<<< Updated upstream
class Shop {
  final int? id;
  final int? sellerId;
  final String? name;
  final int? area;
  final String? branchName;
  final String? address;
  final String? logo;
  final dynamic contactNumber;
  final dynamic description;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final Seller? seller;

  Shop({
    this.id,
    this.sellerId,
    this.name,
    this.area,
    this.branchName,
    this.address,
    this.logo,
    this.contactNumber,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.seller,
  });

  Shop.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        sellerId = json['seller_id'] as int?,
        name = json['name'] as String?,
        area = json['area'] as int?,
        branchName = json['branch_name'] as String?,
        address = json['address'] as String?,
        logo = json['logo'] as String?,
        contactNumber = json['contact_number'],
        description = json['description'],
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        seller = (json['seller'] as Map<String, dynamic>?) != null
            ? Seller.fromJson(json['seller'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'seller_id': sellerId,
        'name': name,
        'area': area,
        'branch_name': branchName,
        'address': address,
        'logo': logo,
        'contact_number': contactNumber,
        'description': description,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'seller': seller?.toJson()
      };
}

class Seller {
  final int? id;
  final int? userId;
  final String? phone;
  final String? whatsapp;
  final String? businessName;
  final String? businessAddress;
  final String? faecbookPage;
  final String? instaPage;
  final String? webUrl;
  final int? isFeatured;
  final String? logo;
  final dynamic reference;
  final int? salesmanId;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

  Seller({
    this.id,
    this.userId,
    this.phone,
    this.whatsapp,
    this.businessName,
    this.businessAddress,
    this.faecbookPage,
    this.instaPage,
    this.webUrl,
    this.isFeatured,
    this.logo,
    this.reference,
    this.salesmanId,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  Seller.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        phone = json['phone'] as String?,
        whatsapp = json['whatsapp'] as String?,
        businessName = json['business_name'] as String?,
        businessAddress = json['business_address'] as String?,
        faecbookPage = json['faecbook_page'] as String?,
        instaPage = json['insta_page'] as String?,
        webUrl = json['web_url'] as String?,
        isFeatured = json['isFeatured'] as int?,
        logo = json['logo'] as String?,
        reference = json['reference'],
        salesmanId = json['salesman_id'] as int?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'phone': phone,
        'whatsapp': whatsapp,
        'business_name': businessName,
        'business_address': businessAddress,
        'faecbook_page': faecbookPage,
        'insta_page': instaPage,
        'web_url': webUrl,
        'isFeatured': isFeatured,
        'logo': logo,
        'reference': reference,
        'salesman_id': salesmanId,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
=======
>>>>>>> Stashed changes
