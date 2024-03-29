import 'package:pink_ad/app/models/user_model.dart';

class Salesman {
  final int? id;
  final int? userId;
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
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
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
        userId = json['user_id'] as int?,
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
        status = json['status'] as int?,
        createdAt =
            json['created_at'] == null // Convert from String to DateTime
                ? null
                : DateTime.parse(json['created_at'] as String),
        updatedAt =
            json['updated_at'] == null // Convert from String to DateTime
                ? null
                : DateTime.parse(json['updated_at'] as String),
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
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user': user?.toJson()
      };
}

