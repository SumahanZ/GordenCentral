import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/toko_notification_type.dart';

part 'toko_notification.freezed.dart';
part 'toko_notification.g.dart';

@freezed
class TokoNotification with _$TokoNotification {
  @JsonSerializable(explicitToJson: true)
  factory TokoNotification({
    int? id,
    String? description,
    DateTime? createdAt,
    @JsonKey(
        fromJson: TokoNotification._typeFromJson,
        toJson: TokoNotification._typeToJson)
    TokoNotificationType? tokonotificationtype,
  }) = _TokoNotification;

  factory TokoNotification.fromJson(Map<String, dynamic> json) =>
      _$TokoNotificationFromJson(json);

  static TokoNotificationType? _typeFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return TokoNotificationType.fromJson(json);
  }

  static Map<String, dynamic>? _typeToJson(TokoNotificationType? type) {
    if (type == null) return null;

    return type.toJson();
  }
}
