import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:st4_tuan5_trancongmanh/database/db_helper_SpendingEntry.dart';
import 'package:st4_tuan5_trancongmanh/model/SpendingEntry.dart';

class EntryDetailsScreen extends StatelessWidget {
  final DatabaseHelperSpendingEntry db = DatabaseHelperSpendingEntry();
  @override
  Widget build(BuildContext context) {
    final SpendingEntry entry =
        ModalRoute.of(context)!.settings.arguments as SpendingEntry;

    Future<void> _deleteEntry(int id) async {
      await db.deleteSpendingEntry(id);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Entry deleted successfully"),
          duration: Duration(seconds: 2),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Spending Details'),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              // TODO: Navigate to edit screen
              
            },
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              // TODO: Implement delete functionality
              showDialog(
                context: context,
                builder:
                    (ctx) => AlertDialog(
                      title: Text('Delete Entry'),
                      content: Text(
                        'Are you sure you want to delete this entry?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(ctx).pop();
                          },
                          child: Text('CANCEL'),
                        ),
                        TextButton(
                          onPressed: () {
                            // TODO: Delete entry
                            Navigator.of(ctx).pop(); // off dialog
                            _deleteEntry(entry.id!);
                            Navigator.pop(
                              context,
                              true,
                            ); // back to previous screen
                          },
                          child: Text('DELETE'),
                        ),
                      ],
                    ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: entry.categoryColor.withOpacity(0.2),
                          child: Icon(
                            entry.categoryIcon,
                            color: entry.categoryColor,
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
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                entry.categoryName,
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Amount',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          '\$${entry.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                        Text(
                          DateFormat('MMMM dd, yyyy').format(entry.date),
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            if (entry.notes.isNotEmpty) ...[
              SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Notes',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        entry.notes,
                        style: TextStyle(fontSize: 16, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
