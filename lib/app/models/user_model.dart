import 'package:pink_ad/app/models/seller_model.dart';

class User {
  final int? id;
  final String? name;
  final String? email;
  final int? role;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
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
        role = json['role'] as int?,
        emailVerifiedAt =
            json['email_verified_at'] == null // Convert from String to DateTime
                ? null
                : DateTime.parse(json['email_verified_at'] as String),
        seller = (json['seller'] as Map<String, dynamic>?) != null
            ? Seller.fromJson(json['seller'] as Map<String, dynamic>)
            : null,
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
        'name': name,
        'email': email,
        'role': role,
        'email_verified_at': emailVerifiedAt?.toIso8601String(),
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'seller': seller?.toJson()
      };
}
