import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:st4_tuan5_trancongmanh/model/SpendingEntry.dart';

class SpendingList extends StatelessWidget {
  final List<SpendingEntry> entries;
  
  final dynamic callback;

  const SpendingList({super.key, required this.entries, required this.callback});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 64, color: Colors.grey[400]),
            SizedBox(height: 16),
            Text(
              'No spending entries found',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Text(
              'Tap the + button to add a new entry',
              style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            ),
          ],
        ),
      );
    }

    // Group entries by date
    Map<String, List<SpendingEntry>> groupedEntries = {};
    for (var entry in entries) {
      String dateKey = DateFormat('yyyy-MM-dd').format(entry.date);
      if (!groupedEntries.containsKey(dateKey)) {
        groupedEntries[dateKey] = [];
      }
      groupedEntries[dateKey]!.add(entry);
    }

    // Sort dates in descending order
    List<String> sortedDates =
        groupedEntries.keys.toList()..sort((a, b) => b.compareTo(a));

    return ListView.builder(
      itemCount: sortedDates.length,
      itemBuilder: (context, index) {
        String dateKey = sortedDates[index];
        List<SpendingEntry> dayEntries = groupedEntries[dateKey]!;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(
                children: [
                  Text(
                    _formatDateHeader(dateKey),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(child: Divider(color: Colors.grey[300])),
                  SizedBox(width: 8),
                  Text(
                    '\$${_calculateDailyTotal(dayEntries).toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: dayEntries.length,
              itemBuilder: (context, i) {
                return _buildSpendingItem(context, dayEntries[i]);
              },
            ),
          ],
        );
      },
    );
  }

  String _formatDateHeader(String dateKey) {
    DateTime date = DateTime.parse(dateKey);
    DateTime now = DateTime.now();
    DateTime yesterday = DateTime.now().subtract(Duration(days: 1));

    if (DateFormat('yyyy-MM-dd').format(now) == dateKey) {
      return 'Today';
    } else if (DateFormat('yyyy-MM-dd').format(yesterday) == dateKey) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }

  double _calculateDailyTotal(List<SpendingEntry> entries) {
    return entries.fold(0, (sum, entry) => sum + entry.amount);
  }

  Widget _buildSpendingItem(BuildContext context, SpendingEntry entry) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () async {
          final result = await Navigator.pushNamed(
            context,
            '/details',
            arguments: entry,
          );
          if (result == true) {
            callback();
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: entry.categoryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  entry.categoryIcon,
                  color: entry.categoryColor,
                  size: 24,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.content,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (entry.notes.isNotEmpty)
                      Text(
                        entry.notes,
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
              SizedBox(width: 16),
              Text(
                '\$${entry.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.red[700],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
