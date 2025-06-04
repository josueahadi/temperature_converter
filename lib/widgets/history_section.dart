import 'package:flutter/material.dart';
import '../models/conversion_history.dart';

/// Widget that displays the conversion history
class HistorySection extends StatelessWidget {
  final List<ConversionHistory> history;
  final VoidCallback onClearHistory;

  const HistorySection({
    super.key,
    required this.history,
    required this.onClearHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_buildHeader(context), _buildHistoryList()],
      ),
    );
  }

  /// Builds the history section header with clear button
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceVariant,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(12),
          topRight: Radius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'History',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          if (history.isNotEmpty)
            TextButton(onPressed: onClearHistory, child: const Text('Clear')),
        ],
      ),
    );
  }

  /// Builds the scrollable history list
  Widget _buildHistoryList() {
    return Container(
      constraints: const BoxConstraints(maxHeight: 300),
      child: history.isEmpty
          ? const Padding(
              padding: EdgeInsets.all(32),
              child: Text(
                'No conversions yet',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            )
          : ListView.separated(
              shrinkWrap: true,
              itemCount: history.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final conversion = history[index];
                return ListTile(
                  dense: true,
                  title: Text(
                    conversion.formattedConversion,
                    style: const TextStyle(
                      fontSize: 14,
                      fontFamily: 'monospace',
                    ),
                  ),
                );
              },
            ),
    );
  }
}
