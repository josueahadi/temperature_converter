/// Utility class for formatting temperature conversions
class FormatUtils {
  /// Creates a formatted temperature conversion string
  static String formatConversion({
    required String type,
    required double input,
    required double output,
    int decimals = 1,
  }) {
    return '$type: ${input.toStringAsFixed(decimals)} ⇒ ${output.toStringAsFixed(decimals)}';
  }
}
