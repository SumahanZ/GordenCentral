import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/models/promo.dart';

part 'promo_selection_notifier.g.dart';

@Riverpod(keepAlive: true)
class PromoSelectionNotifier
    extends _$PromoSelectionNotifier {
  @override
  Promo? build() {
    return null;
  }

  void selectPromo(Promo? promo) {
    state = promo;
  }
}
