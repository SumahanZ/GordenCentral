import 'package:freezed_annotation/freezed_annotation.dart';

part 'customer_notification_type.freezed.dart';
part 'customer_notification_type.g.dart';

@freezed
class CustomerNotificationType with _$CustomerNotificationType {
  @JsonSerializable(explicitToJson: true)
  factory CustomerNotificationType({
    required int id,
    required String name,
  }) = _CustomerNotificationType;

  factory CustomerNotificationType.fromJson(Map<String, dynamic> json) =>
      _$CustomerNotificationTypeFromJson(json);
}
