import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/toko.dart';
import 'package:tugas_akhir_project/models/user.dart';

part 'internal.freezed.dart';
part 'internal.g.dart';

@freezed
class Internal with _$Internal {
  const Internal._();
  factory Internal({
    int? id,
    String? userCode,
    String? status,
    String? profilePhotoURL,
    @JsonKey(fromJson: Internal._userFromJson, toJson: Internal._userToJson)
    User? user,
    @JsonKey(fromJson: Internal._tokoFromJson, toJson: Internal._tokoToJson)
    Toko? toko,
    String? role,
  }) = _Internal;

  static User? _userFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return User.fromJson(json);
  }

  static Map<String, dynamic>? _userToJson(User? user) {
    if (user == null) return null;

    return user.toJson();
  }

  static Toko? _tokoFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Toko.fromJson(json);
  }

  static Map<String, dynamic>? _tokoToJson(Toko? toko) {
    if (toko == null) return null;

    return toko.toJson();
  }

  factory Internal.fromJson(Map<String, dynamic> json) =>
      _$InternalFromJson(json);
}
