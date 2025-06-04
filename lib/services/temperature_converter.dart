// Service class that handles temperature conversion calculations
class TemperatureConverter {
  /// Convert Fahrenheit to Celsius using formula: °C = (°F - 32) × 5/9
  static double fahrenheitToCelsius(double fahrenheit) {
    return (fahrenheit - 32) * 5 / 9;
  }

  /// Convert Celsius to Fahrenheit using formula: °F = °C × 9/5 + 32
  static double celsiusToFahrenheit(double celsius) {
    return celsius * 9 / 5 + 32;
  }

  /// Performs conversion based on the specified type
  /// Returns a tuple of (result, conversionType)
  static ConversionResult performConversion({
    required double inputValue,
    required bool isFahrenheitToCelsius,
  }) {
    if (isFahrenheitToCelsius) {
      return ConversionResult(
        result: fahrenheitToCelsius(inputValue),
        conversionType: 'F to C',
      );
    } else {
      return ConversionResult(
        result: celsiusToFahrenheit(inputValue),
        conversionType: 'C to F',
      );
    }
  }
}

/// Data class to hold conversion result and type
class ConversionResult {
  final double result;
  final String conversionType;

  ConversionResult({required this.result, required this.conversionType});
}
