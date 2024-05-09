// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TokoInformationRequest {
  final int? id;
  final String name;
  final String phoneNumber;
  final String streetAddress;
  final int cityId;
  final String country;
  final String postalCode;
  final String bio;
  final String whatsAppURL;
  final String? profilePhotoURL;
  final String inviteCode;

  TokoInformationRequest({
    this.id,
    required this.name,
    required this.phoneNumber,
    required this.streetAddress,
    required this.cityId,
    required this.country,
    required this.postalCode,
    required this.bio,
    required this.whatsAppURL,
    this.profilePhotoURL,
    required this.inviteCode,
  });

  @override
  bool operator ==(covariant TokoInformationRequest other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.streetAddress == streetAddress &&
        other.cityId == cityId &&
        other.country == country &&
        other.postalCode == postalCode &&
        other.bio == bio &&
        other.whatsAppURL == whatsAppURL &&
        other.profilePhotoURL == profilePhotoURL &&
        other.inviteCode == inviteCode;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        phoneNumber.hashCode ^
        streetAddress.hashCode ^
        cityId.hashCode ^
        country.hashCode ^
        postalCode.hashCode ^
        bio.hashCode ^
        whatsAppURL.hashCode ^
        profilePhotoURL.hashCode ^
        inviteCode.hashCode;
  }

  TokoInformationRequest copyWith({
    int? id,
    String? name,
    String? phoneNumber,
    String? streetAddress,
    int? cityId,
    String? country,
    String? postalCode,
    String? bio,
    String? whatsAppURL,
    String? profilePhotoURL,
    String? inviteCode,
  }) {
    return TokoInformationRequest(
      id: id ?? this.id,
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      streetAddress: streetAddress ?? this.streetAddress,
      cityId: cityId ?? this.cityId,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      bio: bio ?? this.bio,
      whatsAppURL: whatsAppURL ?? this.whatsAppURL,
      profilePhotoURL: profilePhotoURL ?? this.profilePhotoURL,
      inviteCode: inviteCode ?? this.inviteCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'streetAddress': streetAddress,
      'cityId': cityId,
      'country': country,
      'postalCode': postalCode,
      'bio': bio,
      'whatsAppURL': whatsAppURL,
      'profilePhotoURL': profilePhotoURL,
      'inviteCode': inviteCode,
    };
  }

  factory TokoInformationRequest.fromMap(Map<String, dynamic> map) {
    return TokoInformationRequest(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      streetAddress: map['streetAddress'] as String,
      cityId: map['cityId'] as int,
      country: map['country'] as String,
      postalCode: map['postalCode'] as String,
      bio: map['bio'] as String,
      whatsAppURL: map['whatsAppURL'] as String,
      profilePhotoURL: map['profilePhotoURL'] != null
          ? map['profilePhotoURL'] as String
          : null,
      inviteCode: map['inviteCode'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TokoInformationRequest.fromJson(String source) =>
      TokoInformationRequest.fromMap(
          json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TokoInformationRequest(id: $id, name: $name, phoneNumber: $phoneNumber, streetAddress: $streetAddress, cityId: $cityId, country: $country, postalCode: $postalCode, bio: $bio, whatsAppURL: $whatsAppURL, profilePhotoURL: $profilePhotoURL, inviteCode: $inviteCode)';
  }
}
