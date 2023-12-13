import 'package:pink_ad/app/models/user_model.dart';

class LoginResponse {
  final String? status;
  final User? user;
  final Authorisation? authorisation;

  LoginResponse({
    this.status,
    this.user,
    this.authorisation,
  });

  LoginResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null,
        authorisation = (json['authorisation'] as Map<String, dynamic>?) != null
            ? Authorisation.fromJson(
                json['authorisation'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'status': status,
        'user': user?.toJson(),
        'authorisation': authorisation?.toJson()
      };
}

<<<<<<< Updated upstream
class User {
  final int? id;
  final String? name;
  final String? email;
  final String? role;
  final dynamic emailVerifiedAt;
  final String? createdAt;
  final String? updatedAt;
  final Seller? seller;

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.seller,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        role = json['role'] as String?,
        emailVerifiedAt = json['email_verified_at'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        seller = (json['seller'] as Map<String, dynamic>?) != null
            ? Seller.fromJson(json['seller'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'seller': seller?.toJson()
      };
}

class Seller {
  final int? id;
  final String? userId;
  final String? phone;
  final String? whatsapp;
  final String? businessName;
  final String? businessAddress;
  final String? faecbookPage;
  final String? instaPage;
  final String? webUrl;
  final String? isFeatured;
  final String? logo;
  final dynamic reference;
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
        instaPage = json['insta_page'] as String?,
        webUrl = json['web_url'] as String?,
        isFeatured = json['isFeatured'] as String?,
        logo = json['logo'] as String?,
        reference = json['reference'],
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
class Authorisation {
  final String? token;
  final String? type;

  Authorisation({
    this.token,
    this.type,
  });

  Authorisation.fromJson(Map<String, dynamic> json)
      : token = json['token'] as String?,
        type = json['type'] as String?;

  Map<String, dynamic> toJson() => {'token': token, 'type': type};
}
