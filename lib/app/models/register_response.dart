
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
      this._status = status;
    }
    if (message != null) {
      this._message = message;
    }
    if (user != null) {
      this._user = user;
    }
    if (authorisation != null) {
      this._authorisation = authorisation;
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
    _user = json['user'] != null ? new User.fromJson(json['user']) : null;
    _authorisation = json['authorisation'] != null
        ? new Authorisation.fromJson(json['authorisation'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this._status;
    data['message'] = this._message;
    if (this._user != null) {
      data['user'] = this._user!.toJson();
    }
    if (this._authorisation != null) {
      data['authorisation'] = this._authorisation!.toJson();
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
      this._name = name;
    }
    if (email != null) {
      this._email = email;
    }
    if (role != null) {
      this._role = role;
    }
    if (updatedAt != null) {
      this._updatedAt = updatedAt;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    if (id != null) {
      this._id = id;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this._name;
    data['email'] = this._email;
    data['role'] = this._role;
    data['updated_at'] = this._updatedAt;
    data['created_at'] = this._createdAt;
    data['id'] = this._id;
    return data;
  }
}

class Authorisation {
  String? _token;
  String? _type;

  Authorisation({String? token, String? type}) {
    if (token != null) {
      this._token = token;
    }
    if (type != null) {
      this._type = type;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this._token;
    data['type'] = this._type;
    return data;
  }
}