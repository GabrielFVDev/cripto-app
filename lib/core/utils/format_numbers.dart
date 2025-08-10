import 'dart:math' as math;

/// Formata números grandes com sufixos K, M, B, T e pontos separando milhares
String formatLargeNumber(double value) {
  if (value >= 1e12) {
    return '\$${formatNumberWithDots(value / 1e12, decimals: 2)}T';
  } else if (value >= 1e9) {
    return '\$${formatNumberWithDots(value / 1e9, decimals: 2)}B';
  } else if (value >= 1e6) {
    return '\$${formatNumberWithDots(value / 1e6, decimals: 2)}M';
  } else if (value >= 1e3) {
    return '\$${formatNumberWithDots(value / 1e3, decimals: 2)}K';
  } else {
    return '\$${formatNumberWithDots(value, decimals: 2)}';
  }
}

/// Formata números com pontos separando milhares (padrão brasileiro)
/// Exemplo: 1234567.89 -> "1.234.567,89"
String formatNumberWithDots(double value, {int decimals = 2}) {
  // Separar parte inteira e decimal
  final integerPart = value.truncate();
  final decimalPart = value - integerPart;

  // Formatar parte inteira com pontos
  String integerString = integerPart.toString();
  String formattedInteger = '';

  // Adicionar pontos de trás para frente
  for (int i = 0; i < integerString.length; i++) {
    if (i > 0 && (integerString.length - i) % 3 == 0) {
      formattedInteger += '.';
    }
    formattedInteger += integerString[i];
  }

  // Formatar parte decimal
  String decimalString = '';
  if (decimals > 0 && decimalPart > 0) {
    final decimalValue = (decimalPart * math.pow(10, decimals)).round();
    decimalString = ',${decimalValue.toString().padLeft(decimals, '0')}';
  } else if (decimals > 0) {
    decimalString = ',${'0' * decimals}';
  }

  return formattedInteger + decimalString;
}

/// Formata preço de moeda com símbolo de dólar e pontos separando milhares
String formatPrice(double price) {
  if (price < 1) {
    // Para preços menores que 1, mostrar mais casas decimais
    return '\$${formatNumberWithDots(price, decimals: 4)}';
  } else {
    return '\$${formatNumberWithDots(price, decimals: 2)}';
  }
}

/// Formata percentual com sinal + ou -
String formatPercentage(double percentage) {
  final sign = percentage >= 0 ? '+' : '';
  return '$sign${formatNumberWithDots(percentage, decimals: 2)}%';
}
