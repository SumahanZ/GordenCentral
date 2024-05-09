import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
  locale: 'id',
  decimalDigits: 0,
  symbol: 'Rp ',
);

extension PriceFormatter on double {
  static String getFormattedValue2(double value) {
    if (value < 1000) {
      return 'Rp ${value.toStringAsFixed(0)}';
    } else if (value < 1000000) {
      double newValue = value / 1000; // Convert to ribu
      return 'Rp ${newValue.toStringAsFixed(0)} ribu';
    } else if (value < 1000000000) {
      double newValue = value / 1000000;
      return 'Rp ${newValue.toStringAsFixed(0)} juta'; 
    } else {
      double newValue = value / 1000000000;
      return 'Rp ${newValue.toStringAsFixed(0)} miliar';
    }
  }

  static String getFormattedValue(double value) {
    CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      locale: 'id',
      decimalDigits: 0,
      symbol: 'Rp ',
    );

    return formatter.formatDouble(value);
  }

  static double getUnformattedValue() {
    CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      locale: 'id',
      decimalDigits: 0,
      symbol: 'Rp ',
    );

    return formatter.getUnformattedValue() as double;
  }

  String formatOrderCount() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    } else {
      return toString();
    }
  }
}
