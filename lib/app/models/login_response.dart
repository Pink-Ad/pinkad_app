import 'package:pink_ad/app/models/shop_model.dart';
import 'package:pink_ad/app/models/user_model.dart';

class LoginResponse {
  final String? status;
  final User? user;
  final Authorisation? authorisation;
  final Shop? shop;
  final int? cityId;
  final String? cityName;
  final String? areaName;

  LoginResponse({
    this.status,
    this.user,
    this.authorisation,
    this.shop,
    this.cityId,
    this.cityName,
    this.areaName,
  });

  LoginResponse.fromJson(Map<String, dynamic> json)
      : status = json['status'] as String?,
        user = (json['user'] as Map<String, dynamic>?) != null ? User.fromJson(json['user'] as Map<String, dynamic>) : null,
        shop = json['shop'] != null && json['shop'] is List && json['shop'].isNotEmpty ? Shop.fromJson(json['shop'][0]) : null,
        cityId = json['city_id'],
        cityName = json['city_name'],
        areaName = json['area_name'],
        authorisation =
            (json['authorisation'] as Map<String, dynamic>?) != null ? Authorisation.fromJson(json['authorisation'] as Map<String, dynamic>) : null;

  Map<String, dynamic> toJson() => {
        'status': status,
        'user': user?.toJson(),
        'shop': shop?.toJson(),
        'city_id': cityId,
        'city_name': cityName,
        'area_name': areaName,
        'authorisation': authorisation?.toJson(),
      };
}

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
