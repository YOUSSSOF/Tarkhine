import 'dart:convert';

class UserModel {
  final int id;
  final String phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? birth;
  final String? username;
  String? token;
  final String? address;
  UserModel({
    required this.id,
    required this.phoneNumber,
    this.firstName,
    this.lastName,
    this.email,
    this.birth,
    this.token,
    this.address,
    this.username = 'کاربر ترخینه',
  });

  String get name => '${firstName!} ${lastName!}';

  UserModel copyWith({
    int? id,
    String? phoneNumber,
    String? firstName,
    String? lastName,
    String? email,
    String? birth,
    String? username,
    String? token,
    String? address,
  }) {
    return UserModel(
      id: id ?? this.id,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      birth: birth ?? this.birth,
      username: username ?? this.username,
      token: token ?? this.token,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'phone_number': phoneNumber});
    if (firstName != null) {
      result.addAll({'first_name': firstName});
    }
    if (lastName != null) {
      result.addAll({'last_name': lastName});
    }
    if (email != null) {
      result.addAll({'email': email});
    }
    if (birth != null) {
      result.addAll({'birth': birth});
    }
    if (username != null) {
      result.addAll({'username': username});
    }
    if (token != null) {
      result.addAll({'token': token});
    }
    if (address != null) {
      result.addAll({'address': address});
    }

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id']?.toInt() ?? 0,
      phoneNumber: map['phone_number'] ?? '',
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      birth: map['birth'],
      username: map['username'],
      token: map['token'] ?? "",
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, phoneNumber: $phoneNumber, firstName: $firstName, lastName: $lastName, email: $email, birth: $birth, username: $username, token: $token, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.phoneNumber == phoneNumber &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.email == email &&
        other.birth == birth &&
        other.username == username &&
        other.token == token &&
        other.address == address;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        phoneNumber.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        email.hashCode ^
        birth.hashCode ^
        username.hashCode ^
        token.hashCode ^
        address.hashCode;
  }
}
