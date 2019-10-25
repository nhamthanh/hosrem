import 'package:flutter_money_formatter/flutter_money_formatter.dart';

/// Currency utils.
class CurrencyUtils {
  CurrencyUtils._();

  /// Format [amount] as currency.
  static String formatAsCurrency(double amount) {
    final MoneyFormatterSettings moneyFormatterSettings = MoneyFormatterSettings(
      thousandSeparator: '.',
      decimalSeparator: ',',
      symbolAndNumberSeparator: ' '
    );
    return FlutterMoneyFormatter(amount: amount, settings: moneyFormatterSettings).output.withoutFractionDigits;
  }
}

