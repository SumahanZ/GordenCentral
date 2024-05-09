import 'package:freezed_annotation/freezed_annotation.dart';

part 'toko_notification_type.freezed.dart';
part 'toko_notification_type.g.dart';

@freezed
class TokoNotificationType with _$TokoNotificationType {
  @JsonSerializable(explicitToJson: true)
  factory TokoNotificationType({
    required int id,
    required String name,
  }) = _TokoNotificationType;

  factory TokoNotificationType.fromJson(Map<String, dynamic> json) =>
      _$TokoNotificationTypeFromJson(json);
}
