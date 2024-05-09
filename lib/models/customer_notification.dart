import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/customer_notification_type.dart';

part 'customer_notification.freezed.dart';
part 'customer_notification.g.dart';

@freezed
class CustomerNotification with _$CustomerNotification {
  @JsonSerializable(explicitToJson: true)
  factory CustomerNotification({
    int? id,
    String? description,
    DateTime? createdAt,
    @JsonKey(
        fromJson: CustomerNotification._typeFromJson,
        toJson: CustomerNotification._typeToJson)
    CustomerNotificationType? customernotificationtype,
  }) = _CustomerNotification;

  factory CustomerNotification.fromJson(Map<String, dynamic> json) =>
      _$CustomerNotificationFromJson(json);

  static CustomerNotificationType? _typeFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return CustomerNotificationType.fromJson(json);
  }

  static Map<String, dynamic>? _typeToJson(CustomerNotificationType? type) {
    if (type == null) return null;

    return type.toJson();
  }
}
