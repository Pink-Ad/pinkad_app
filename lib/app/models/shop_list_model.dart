import 'package:pink_ad/app/models/seller_model.dart';

class ShopList {
  final int? id;
  final String? sellerId;
  final String? name;
  final String? area;
  final String? branchName;
  final String? address;
  final String? logo;
  final String? contactNumber;
  final String? description;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final Seller? seller;

  ShopList({
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

  ShopList.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        sellerId = json['seller_id'] as String?,
        name = json['name'] as String?,
        area = json['area'] as String?,
        branchName = json['branch_name'] as String?,
        address = json['address'] as String?,
        logo = json['logo'] as String?,
        contactNumber = json['contact_number'] as String?,
        description = json['description'] as String?,
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
<<<<<<< Updated upstream

class Seller {
  final int? id;
  final String? userId;
  final String? phone;
  final String? whatsapp;
  final String? businessName;
  final String? businessAddress;
  final String? faecbookPage;
  final dynamic instaPage;
  final dynamic webUrl;
  final String? isFeatured;
  final String? logo;
  final String? reference;
  final String? salesmanId;
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
        userId = json['user_id'] as String?,
        phone = json['phone'] as String?,
        whatsapp = json['whatsapp'] as String?,
        businessName = json['business_name'] as String?,
        businessAddress = json['business_address'] as String?,
        faecbookPage = json['faecbook_page'] as String?,
        instaPage = json['insta_page'],
        webUrl = json['web_url'],
        isFeatured = json['isFeatured'] as String?,
        logo = json['logo'] as String?,
        reference = json['reference'] as String?,
        salesmanId = json['salesman_id'] as String?,
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
