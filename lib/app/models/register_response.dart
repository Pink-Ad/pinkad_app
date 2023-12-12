class RegisterPostResponse {
  String? _status;
  String? _message;
  User? _user;
  Authorisation? _authorisation;

  RegisterPostResponse(
      {String? status,
      String? message,
      User? user,
      Authorisation? authorisation}) {
    if (status != null) {
      _status = status;
    }
    if (message != null) {
      _message = message;
    }
    if (user != null) {
      _user = user;
    }
    if (authorisation != null) {
      _authorisation = authorisation;
    }
  }

  String? get status => _status;
  set status(String? status) => _status = status;
  String? get message => _message;
  set message(String? message) => _message = message;
  User? get user => _user;
  set user(User? user) => _user = user;
  Authorisation? get authorisation => _authorisation;
  set authorisation(Authorisation? authorisation) =>
      _authorisation = authorisation;

  RegisterPostResponse.fromJson(Map<String, dynamic> json) {
    _status = json['status'];
    _message = json['message'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
    _authorisation = json['authorisation'] != null
        ? Authorisation.fromJson(json['authorisation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = _status;
    data['message'] = _message;
    if (_user != null) {
      data['user'] = _user!.toJson();
    }
    if (_authorisation != null) {
      data['authorisation'] = _authorisation!.toJson();
    }
    return data;
  }
}

class User {
  String? _name;
  String? _email;
  String? _role;
  String? _updatedAt;
  String? _createdAt;
  int? _id;

  User(
      {String? name,
      String? email,
      String? role,
      String? updatedAt,
      String? createdAt,
      int? id}) {
    if (name != null) {
      _name = name;
    }
    if (email != null) {
      _email = email;
    }
    if (role != null) {
      _role = role;
    }
    if (updatedAt != null) {
      _updatedAt = updatedAt;
    }
    if (createdAt != null) {
      _createdAt = createdAt;
    }
    if (id != null) {
      _id = id;
    }
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get email => _email;
  set email(String? email) => _email = email;
  String? get role => _role;
  set role(String? role) => _role = role;
  String? get updatedAt => _updatedAt;
  set updatedAt(String? updatedAt) => _updatedAt = updatedAt;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;
  int? get id => _id;
  set id(int? id) => _id = id;

  User.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _email = json['email'];
    _role = json['role'];
    _updatedAt = json['updated_at'];
    _createdAt = json['created_at'];
    _id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = _name;
    data['email'] = _email;
    data['role'] = _role;
    data['updated_at'] = _updatedAt;
    data['created_at'] = _createdAt;
    data['id'] = _id;
    return data;
  }
}

class Authorisation {
  String? _token;
  String? _type;

  Authorisation({String? token, String? type}) {
    if (token != null) {
      _token = token;
    }
    if (type != null) {
      _type = type;
    }
  }

  String? get token => _token;
  set token(String? token) => _token = token;
  String? get type => _type;
  set type(String? type) => _type = type;

  Authorisation.fromJson(Map<String, dynamic> json) {
    _token = json['token'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['token'] = _token;
    data['type'] = _type;
    return data;
  }
}
