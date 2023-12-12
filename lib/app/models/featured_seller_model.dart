class FeaturedSeller {
  final int? currentPage;
  final List<Data>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Links>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  FeaturedSeller({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  FeaturedSeller.fromJson(Map<String, dynamic> json)
      : currentPage = json['current_page'] as int?,
        data = (json['data'] as List?)
            ?.map((dynamic e) => Data.fromJson(e as Map<String, dynamic>))
            .toList(),
        firstPageUrl = json['first_page_url'] as String?,
        from = json['from'] as int?,
        lastPage = json['last_page'] as int?,
        lastPageUrl = json['last_page_url'] as String?,
        links = (json['links'] as List?)
            ?.map((dynamic e) => Links.fromJson(e as Map<String, dynamic>))
            .toList(),
        nextPageUrl = json['next_page_url'],
        path = json['path'] as String?,
        perPage = json['per_page'] as int?,
        prevPageUrl = json['prev_page_url'],
        to = json['to'] as int?,
        total = json['total'] as int?;

  Map<String, dynamic> toJson() => {
        'current_page': currentPage,
        'data': data?.map((e) => e.toJson()).toList(),
        'first_page_url': firstPageUrl,
        'from': from,
        'last_page': lastPage,
        'last_page_url': lastPageUrl,
        'links': links?.map((e) => e.toJson()).toList(),
        'next_page_url': nextPageUrl,
        'path': path,
        'per_page': perPage,
        'prev_page_url': prevPageUrl,
        'to': to,
        'total': total
      };
}

class Data {
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
  final User? user;

  Data({
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
    this.user,
  });

  Data.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        userId = json['user_id'] as int?,
        phone = json['phone'] as String?,
        whatsapp = json['whatsapp'] as String?,
        businessName = json['business_name'] as String?,
        businessAddress = json['business_address'] as String?,
        faecbookPage = json['facebook_page'] as String?,
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
                : DateTime.parse(json['updated_at'] as String),
        user = (json['user'] as Map<String, dynamic>?) != null
            ? User.fromJson(json['user'] as Map<String, dynamic>)
            : null;

  Map<String, dynamic> toJson() => {
        'id': id,
        'user_id': userId,
        'phone': phone,
        'whatsapp': whatsapp,
        'business_name': businessName,
        'business_address': businessAddress,
        'facebook_page': faecbookPage,
        'insta_page': instaPage,
        'web_url': webUrl,
        'isFeatured': isFeatured,
        'logo': logo,
        'reference': reference,
        'salesman_id': salesmanId,
        'status': status,
        'created_at': createdAt?.toIso8601String(),
        'updated_at': updatedAt?.toIso8601String(),
        'user': user?.toJson()
      };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final int? role;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
        role = json['role'] as int?,
        emailVerifiedAt =
            json['email_verified_at'] == null // Convert from String to DateTime
                ? null
                : DateTime.parse(json['email_verified_at'] as String),
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
      };
}

class Links {
  final dynamic url;
  final String? label;
  final bool? active;

  Links({
    this.url,
    this.label,
    this.active,
  });

  Links.fromJson(Map<String, dynamic> json)
      : url = json['url'],
        label = json['label'] as String?,
        active = json['active'] as bool?;

  Map<String, dynamic> toJson() =>
      {'url': url, 'label': label, 'active': active};
}
