import 'package:flutter/material.dart';
import 'package:st4_tuan5_trancongmanh/Buoi6/screens/add_entry_screen.dart';
import 'package:st4_tuan5_trancongmanh/Buoi6/widgets/category_filter.dart';
import 'package:st4_tuan5_trancongmanh/Buoi6/widgets/spending_list.dart';
import 'package:st4_tuan5_trancongmanh/Buoi6/widgets/spending_summary.dart';
import 'package:st4_tuan5_trancongmanh/database/db_helper_SpendingEntry.dart';
import 'package:st4_tuan5_trancongmanh/model/SpendingEntry.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SpendingEntry> entries = [];
  SpendingCategory? selectedCategory;
  final DatabaseHelperSpendingEntry db = DatabaseHelperSpendingEntry();

  void _filterByCategory(SpendingCategory? category) {
    setState(() {
      selectedCategory = category;
    });
  }

  List<SpendingEntry> get filteredEntries {
    if (selectedCategory == null) {
      return entries;
    }
    return entries
        .where((entry) => entry.category == selectedCategory)
        .toList();
  }

  double get totalSpending {
    return filteredEntries.fold(0, (sum, entry) => sum + entry.amount);
  }

  Future<void> _loadSpendEntry() async {
    List<SpendingEntry> list = await db.getAllSpendingEntry();

    if (list.isEmpty) {
      for (var entry in sampleEntries) {
        await db.insertSpendingEntry(entry);
      }
    }

    list = await db.getAllSpendingEntry(); // Reload entries from the database

    setState(() {
      entries = list;
    });
    print("List spending entry: $entries");
  }

  @override
  void initState() {
    super.initState();
    _loadSpendEntry(); // Load entries from the database
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Spending Manager'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              // TODO: Implement date filter
            },
          ),
          IconButton(
            icon: Icon(Icons.pie_chart),
            onPressed: () {
              // TODO: Implement statistics view
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SpendingSummary(totalAmount: totalSpending),
          CategoryFilter(
            selectedCategory: selectedCategory,
            onCategorySelected: _filterByCategory,
          ),
          Expanded(
            child: SpendingList(
              entries: filteredEntries,
              callback: () async {
                await _loadSpendEntry(); // Reload entries from the database
                print("List spending entry: $entries");
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddEntryScreen()),
          );
          if (result == true) {
            await _loadSpendEntry();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Thêm thu nhập thành công"),
                duration: Duration(seconds: 2),
              ),
            );
          }
        },
        child: Icon(Icons.add),
        tooltip: 'Add new spending',
      ),
    );
  }
}
