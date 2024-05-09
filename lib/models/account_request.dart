// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class AccountRequest {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;
  final String? profilePhotoUrl;
  
  AccountRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
    this.profilePhotoUrl,
  });


  AccountRequest copyWith({
    String? name,
    String? email,
    String? password,
    String? phoneNumber,
    String? profilePhotoUrl,
  }) {
    return AccountRequest(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePhotoUrl: profilePhotoUrl ?? this.profilePhotoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'profilePhotoUrl': profilePhotoUrl,
    };
  }

  factory AccountRequest.fromMap(Map<String, dynamic> map) {
    return AccountRequest(
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profilePhotoUrl: map['profilePhotoUrl'] != null ? map['profilePhotoUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AccountRequest.fromJson(String source) => AccountRequest.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'AccountRequest(name: $name, email: $email, password: $password, phoneNumber: $phoneNumber, profilePhotoUrl: $profilePhotoUrl)';
  }

  @override
  bool operator ==(covariant AccountRequest other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.password == password &&
      other.phoneNumber == phoneNumber &&
      other.profilePhotoUrl == profilePhotoUrl;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      password.hashCode ^
      phoneNumber.hashCode ^
      profilePhotoUrl.hashCode;
  }
}
