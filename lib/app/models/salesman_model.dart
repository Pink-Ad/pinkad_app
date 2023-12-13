import 'package:pink_ad/app/models/user_model.dart';

class Salesman {
  final int? id;
  final String? userId;
  final String? phone;
  final String? qualification;
  final String? cnic;
  final String? cnicImage;
  final String? maritalStatus;
  final String? religion;
  final String? workHistory;
  final String? picture;
  final String? bankAccount;
  final String? age;
  final String? address;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final User? user;

  Salesman({
    this.id,
    this.userId,
    this.phone,
    this.qualification,
    this.cnic,
    this.cnicImage,
    this.maritalStatus,
    this.religion,
    this.workHistory,
    this.picture,
    this.bankAccount,
    this.age,
    this.address,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Salesman.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as String?,
        phone = json['phone'] as String?,
        qualification = json['qualification'] as String?,
        cnic = json['cnic'] as String?,
        cnicImage = json['cnic_image'] as String?,
        maritalStatus = json['marital_status'] as String?,
        religion = json['religion'] as String?,
        workHistory = json['work_history'] as String?,
        picture = json['picture'] as String?,
        bankAccount = json['bank_account'] as String?,
        age = json['age'] as String?,
        address = json['address'] as String?,
        status = json['status'] as String?,
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?,
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'phone': phone,
        'qualification': qualification,
        'cnic': cnic,
        'cnic_image': cnicImage,
        'marital_status': maritalStatus,
        'religion': religion,
        'work_history': workHistory,
        'picture': picture,
        'bank_account': bankAccount,
        'age': age,
        'address': address,
        'status': status,
        'created_at': createdAt,
        'updated_at': updatedAt,
        'user': user?.toJson()
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

  User({
    this.id,
    this.name,
    this.email,
    this.role,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        name = json['name'] as String?,
        email = json['email'] as String?,
        role = json['role'] as String?,
        emailVerifiedAt = json['email_verified_at'],
        createdAt = json['created_at'] as String?,
        updatedAt = json['updated_at'] as String?;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'role': role,
        'email_verified_at': emailVerifiedAt,
        'created_at': createdAt,
        'updated_at': updatedAt
      };
}
=======
>>>>>>> Stashed changes
