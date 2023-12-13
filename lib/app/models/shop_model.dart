import 'package:pink_ad/app/models/seller_model.dart';

class Shop {
  final int? id;
  final int? sellerId;
  final String? name;
  final int? area;
  final String? branchName;
  final String? address;
  final String? logo;
<<<<<<< Updated upstream
  final dynamic contactNumber;
  final dynamic description;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
=======
  final String? contactNumber;
  final String? description;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final Seller? seller;
>>>>>>> Stashed changes

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

<<<<<<< Updated upstream
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
        updatedAt = json['updated_at'] as String?;
=======
  factory Shop.fromJson(Map<String, dynamic> json) {
    try {
      return Shop(
        id: json['id'] as int?,
        sellerId: json['seller_id'] as int?,
        name: json['name'] as String?,
        area: json['area'] as int?,
        branchName: json['branch_name'] as String?,
        address: json['address'] as String?,
        logo: json['logo'] as String?,
        contactNumber: json['contact_number'] as String?,
        description: json['description'] as String?,
        status: json['status'] as int?,
        createdAt: json['created_at'] == null // Convert from String to DateTime
            ? null
            : DateTime.parse(json['created_at'] as String),
        updatedAt: json['updated_at'] == null // Convert from String to DateTime
            ? null
            : DateTime.parse(json['updated_at'] as String),
        seller: (json['seller'] as Map<String, dynamic>?) != null
            ? Seller.fromJson(json['seller'] as Map<String, dynamic>)
            : null,
      );
    } catch (e) {
      // Print the error to the console or use breakpoints if in an IDE
      print('Error parsing Shop: $e');
      // If you're using an IDE like VSCode, you can set a breakpoint here
      // Return an empty Shop object or handle the error as needed
      return Shop();
    }
  }
>>>>>>> Stashed changes

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
<<<<<<< Updated upstream
        'created_at': createdAt,
        'updated_at': updatedAt
=======
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'seller': seller?.toJson()
>>>>>>> Stashed changes
      };
}
