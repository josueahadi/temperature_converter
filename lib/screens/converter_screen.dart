import 'package:flutter/material.dart';
import '../models/conversion_history.dart';
import '../widgets/conversion_section.dart';
import '../widgets/history_section.dart';

/// Main screen containing the temperature converter functionality
class ConverterScreen extends StatefulWidget {
  const ConverterScreen({super.key});

  @override
  State<ConverterScreen> createState() => _ConverterScreenState();
}

class _ConverterScreenState extends State<ConverterScreen> {
  final List<ConversionHistory> _history = [];

  /// Adds a new conversion to the history
  void _addToHistory(ConversionHistory conversion) {
    setState(() {
      // Add to history with most recent at the top
      _history.insert(0, conversion);
    });
  }

  /// Clears the conversion history
  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Temperature Converter',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 2,
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return _buildPortraitLayout();
          } else {
            return _buildLandscapeLayout();
          }
        },
      ),
    );
  }

  /// Builds the portrait orientation layout
  Widget _buildPortraitLayout() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ConversionSection(onConversionComplete: _addToHistory),
          const SizedBox(height: 24),
          HistorySection(history: _history, onClearHistory: _clearHistory),
        ],
      ),
    );
  }

  /// Builds the landscape orientation layout
  Widget _buildLandscapeLayout() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ConversionSection(onConversionComplete: _addToHistory),
          ),
          const SizedBox(width: 16),
          Expanded(
            flex: 1,
            child: HistorySection(
              history: _history,
              onClearHistory: _clearHistory,
            ),
          ),
        ],
      ),
    );
  }
}
