String formatLargeNumber(double value) {
  if (value >= 1e12) {
    return '\$${(value / 1e12).toStringAsFixed(2)}T';
  } else if (value >= 1e9) {
    return '\$${(value / 1e9).toStringAsFixed(2)}B';
  } else if (value >= 1e6) {
    return '\$${(value / 1e6).toStringAsFixed(2)}M';
  } else if (value >= 1e3) {
    return '\$${(value / 1e3).toStringAsFixed(2)}K';
  } else {
    return '\$${value.toStringAsFixed(2)}';
  }
}
