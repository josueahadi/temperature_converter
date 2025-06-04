import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/conversion_history.dart';
import '../services/temperature_converter.dart';
import '../utils/input_validator.dart';
import '../utils/format_utils.dart';
import 'app_card.dart';

/// Widget that handles the main conversion functionality
class ConversionSection extends StatefulWidget {
  final Function(ConversionHistory) onConversionComplete;

  const ConversionSection({super.key, required this.onConversionComplete});

  @override
  State<ConversionSection> createState() => _ConversionSectionState();
}

class _ConversionSectionState extends State<ConversionSection> {
  final TextEditingController _temperatureController = TextEditingController();
  bool _isFahrenheitToCelsius = true;
  double? _convertedValue;

  @override
  void dispose() {
    _temperatureController.dispose();
    super.dispose();
  }

  /// Performs temperature conversion and updates state
  void _performConversion() {
    final String inputText = _temperatureController.text.trim();

    // Validate input
    final String? validationError = InputValidator.validateTemperatureInput(
      inputText,
    );
    if (validationError != null) {
      _showErrorDialog(validationError);
      return;
    }

    final double inputValue = InputValidator.parseTemperature(inputText)!;

    // Perform conversion
    final ConversionResult result = TemperatureConverter.performConversion(
      inputValue: inputValue,
      isFahrenheitToCelsius: _isFahrenheitToCelsius,
    );

    setState(() {
      _convertedValue = result.result;
    });

    // Add to history
    final ConversionHistory historyEntry = ConversionHistory(
      type: result.conversionType,
      inputValue: inputValue,
      outputValue: result.result,
    );

    widget.onConversionComplete(historyEntry);
  }

  /// Shows error dialog for validation failures
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Invalid Input'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildConversionTypeSelection(),
          const SizedBox(height: 20),
          _buildTemperatureInputSection(),
          const SizedBox(height: 20),
          _buildConvertButton(),
          if (_convertedValue != null) ...[
            const SizedBox(height: 20),
            _buildResultDisplay(),
          ],
        ],
      ),
    );
  }

  /// Builds the conversion type selection radio buttons
  Widget _buildConversionTypeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Conversion:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        RadioListTile<bool>(
          title: const Text('Fahrenheit to Celsius'),
          value: true,
          groupValue: _isFahrenheitToCelsius,
          onChanged: (bool? value) {
            setState(() {
              _isFahrenheitToCelsius = value ?? true;
              _convertedValue = null;
            });
          },
          dense: true,
        ),
        RadioListTile<bool>(
          title: const Text('Celsius to Fahrenheit'),
          value: false,
          groupValue: _isFahrenheitToCelsius,
          onChanged: (bool? value) {
            setState(() {
              _isFahrenheitToCelsius = value ?? true;
              _convertedValue = null;
            });
          },
          dense: true,
        ),
      ],
    );
  }

  /// Builds the temperature input section with equals sign
  Widget _buildTemperatureInputSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _temperatureController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*')),
            ],
            decoration: InputDecoration(
              hintText: 'Enter temperature',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey[50],
            ),
            style: const TextStyle(fontSize: 18),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '=',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[100],
            ),
            child: Text(
              _convertedValue?.toStringAsFixed(2) ?? '',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  /// Builds the convert button
  Widget _buildConvertButton() {
    return ElevatedButton(
      onPressed: _performConversion,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      child: const Text(
        'CONVERT',
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Builds the result display section
  Widget _buildResultDisplay() {
    if (_convertedValue == null) return const SizedBox.shrink();

    final inputValue =
        InputValidator.parseTemperature(_temperatureController.text) ?? 0;
    final type = _isFahrenheitToCelsius ? 'F to C' : 'C to F';

    final conversionText = FormatUtils.formatConversion(
      type: type,
      input: inputValue,
      output: _convertedValue!,
    );

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        conversionText,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.onPrimaryContainer,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
