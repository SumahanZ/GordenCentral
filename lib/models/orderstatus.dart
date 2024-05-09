import 'package:freezed_annotation/freezed_annotation.dart';

part 'orderstatus.freezed.dart';
part 'orderstatus.g.dart';

@freezed
class OrderStatus with _$OrderStatus {
  @JsonSerializable(explicitToJson: true)
  factory OrderStatus({
    required int id,
    required String name,
  }) = _OrderStatus;

  factory OrderStatus.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusFromJson(json);
}
