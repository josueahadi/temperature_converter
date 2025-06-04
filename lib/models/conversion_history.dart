import '../utils/format_utils.dart';

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
    return FormatUtils.formatConversion(
      type: type,
      input: inputValue,
      output: outputValue,
    );
  }
}
