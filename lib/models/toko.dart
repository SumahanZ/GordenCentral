import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/address.dart';
import 'package:tugas_akhir_project/models/beranda_toko.dart';

part 'toko.freezed.dart';
part 'toko.g.dart';

@freezed
class Toko with _$Toko {
  @JsonSerializable(explicitToJson: true)
  factory Toko({
    int? id,
    String? name,
    String? phoneNumber,
    String? bio,
    String? whatsAppURL,
    String? profilePhotoURL,
    String? inviteCode,
    @JsonKey(fromJson: Toko._addressFromJson, toJson: Toko._addressToJson)
    Address? address,
    @JsonKey(
        fromJson: Toko._listBerandaFromJson,
        toJson: Toko._listBerandaToJson,
        name: "promotionals")
    @Default([])
    List<BerandaToko> berandaToko,
  }) = _Toko;

  factory Toko.fromJson(Map<String, dynamic> json) => _$TokoFromJson(json);

  static Address? _addressFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Address.fromJson(json);
  }

  static Map<String, dynamic>? _addressToJson(Address? address) {
    if (address == null) return null;

    return address.toJson();
  }

  static List<BerandaToko> _listBerandaFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => BerandaToko.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listBerandaToJson(
      List<BerandaToko> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }
}
