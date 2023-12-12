class ShopList {
  final int? id;
  final int? sellerId;
  final String? name;
  final int? area;
  final String? branchName;
  final String? address;
  final String? logo;
  final String? contactNumber;
  final String? description;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
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
        sellerId = json['seller_id'] as int?,
        name = json['name'] as String?,
        area = json['area'] as int?,
        branchName = json['branch_name'] as String?,
        address = json['address'] as String?,
        logo = json['logo'] as String?,
        contactNumber = json['contact_number'] as String?,
        description = json['description'] as String?,
        status = json['status'] as int?,
        createdAt =
            json['created_at'] == null // Convert from String to DateTime
                ? null
                : DateTime.parse(json['created_at'] as String),
        updatedAt =
            json['updated_at'] == null // Convert from String to DateTime
                ? null
                : DateTime.parse(json['updated_at'] as String),
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
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
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
  final String? reference;
  final int? salesmanId;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
        reference = json['reference'] as String?,
        salesmanId = json['salesman_id'] as int?,
        status = json['status'] as int?,
        createdAt =
            json['created_at'] == null // Convert from String to DateTime
                ? null
                : DateTime.parse(json['created_at'] as String),
        updatedAt =
            json['updated_at'] == null // Convert from String to DateTime
                ? null
                : DateTime.parse(json['updated_at'] as String);

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
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
      };
}
