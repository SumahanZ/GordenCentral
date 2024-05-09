
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  @JsonSerializable(explicitToJson: true)
  factory User({
    required int id,
    required String name,
    required String email,
    required String password,
    String? phoneNumber,
    required String type,
    required String? token,
    @Default(false) bool personalizationFinished,
  }) = _User;
	
  factory User.fromJson(Map<String, dynamic> json) =>
			_$UserFromJson(json);
}
