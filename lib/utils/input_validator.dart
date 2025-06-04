// Utility class for input validation
class InputValidator {
  /// Validates temperature input string
  /// Returns null if valid, error message if invalid
  static String? validateTemperatureInput(String input) {
    if (input.trim().isEmpty) {
      return 'Please enter a temperature value';
    }

    final double? value = double.tryParse(input.trim());
    if (value == null) {
      return 'Please enter a valid number';
    }

    return null;
  }

  /// Parses temperature input string to double
  /// Returns null if parsing fails
  static double? parseTemperature(String input) {
    return double.tryParse(input.trim());
  }
}
