import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/address.dart';
import 'package:tugas_akhir_project/models/user.dart';

part 'customer.freezed.dart';
part 'customer.g.dart';

@freezed
class Customer with _$Customer {
  const Customer._();
  factory Customer({
    required int id,
    String? customerCode,
    String? profilePhotoURL,
    @JsonKey(fromJson: Customer._userFromJson, toJson: Customer._userToJson)
    User? user,
    @JsonKey(
        fromJson: Customer._addressFromJson, toJson: Customer._addressToJson)
    Address? address,
  }) = _Customer;

  static Address? _addressFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Address.fromJson(json);
  }

  static Map<String, dynamic>? _addressToJson(Address? address) {
    if (address == null) return null;

    return address.toJson();
  }

  //so we can decode from custom objects and to encode to custom objects
  static User? _userFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return User.fromJson(json);
  }

  static Map<String, dynamic>? _userToJson(User? user) {
    if (user == null) return null;

    return user.toJson();
  }

  factory Customer.fromJson(Map<String, dynamic> json) =>
      _$CustomerFromJson(json);
}
