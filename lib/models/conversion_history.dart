// Data class to store conversion history entries
class ConversionHistory {
  final String type;
  final double inputValue;
  final double outputValue;

  ConversionHistory({
    required this.type,
    required this.inputValue,
    required this.outputValue,
  });

  /// Creates a formatted string representation of the conversion
  String get formattedConversion {
    return '$type: ${inputValue.toStringAsFixed(1)} ⇒ ${outputValue.toStringAsFixed(1)}';
  }

  /// Creates a detailed string representation for result display
  String get detailedConversion {
    return '$type: ${inputValue.toStringAsFixed(1)} ⇒ ${outputValue.toStringAsFixed(1)}';
  }
}
