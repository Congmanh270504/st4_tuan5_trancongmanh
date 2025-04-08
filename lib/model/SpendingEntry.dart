import 'package:flutter/material.dart';

enum SpendingCategory {
  food,
  transportation,
  entertainment,
  shopping,
  utilities,
  health,
  education,
  other,
}

class SpendingEntry {
  final int? id;
  final String content;
  final double amount;
  final String notes;
  final DateTime date;
  final SpendingCategory category;

  SpendingEntry({
    this.id,
    required this.content,
    required this.amount,
    this.notes = '',
    required this.date,
    required this.category,
  });
  @override
  String toString() {
    return 'SpendingEntry(id: $id, content: $content, amount: $amount, notes: $notes, date: $date, category: $category)';
  }

  // Get icon based on category
  IconData get categoryIcon {
    switch (category) {
      case SpendingCategory.food:
        return Icons.restaurant;
      case SpendingCategory.transportation:
        return Icons.directions_car;
      case SpendingCategory.entertainment:
        return Icons.movie;
      case SpendingCategory.shopping:
        return Icons.shopping_bag;
      case SpendingCategory.utilities:
        return Icons.power;
      case SpendingCategory.health:
        return Icons.medical_services;
      case SpendingCategory.education:
        return Icons.school;
      case SpendingCategory.other:
        return Icons.category;
    }
  }

  // Get color based on category
  Color get categoryColor {
    switch (category) {
      case SpendingCategory.food:
        return Colors.orange;
      case SpendingCategory.transportation:
        return Colors.blue;
      case SpendingCategory.entertainment:
        return Colors.purple;
      case SpendingCategory.shopping:
        return Colors.pink;
      case SpendingCategory.utilities:
        return Colors.amber;
      case SpendingCategory.health:
        return Colors.red;
      case SpendingCategory.education:
        return Colors.green;
      case SpendingCategory.other:
        return Colors.grey;
    }
  }

  // Convert category to string
  String get categoryName {
    return category.toString().split('.').last;
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'amount': amount,
      'notes': notes,
      'date': date.toIso8601String(),
      'category': category.toString().split('.').last,
    };
  }

  factory SpendingEntry.fromMap(Map<String, dynamic> map) {
    return SpendingEntry(
      id: map['id'],
      content: map['content'],
      amount: map['amount'],
      notes: map['notes'],
      date: DateTime.parse(map['date']),
      category: SpendingCategory.values.firstWhere(
        (e) => e.toString() == 'SpendingCategory.${map['category']}',
        orElse: () => SpendingCategory.other,
      ),
    );
  }
}

// Sample data
List<SpendingEntry> sampleEntries = [
  SpendingEntry(
    content: 'Grocery Shopping',
    amount: 85.50,
    notes: 'Weekly groceries from Whole Foods',
    date: DateTime.now().subtract(Duration(days: 1)),
    category: SpendingCategory.food,
  ),
  SpendingEntry(
    content: 'Uber Ride',
    amount: 24.75,
    notes: 'Trip to downtown',
    date: DateTime.now().subtract(Duration(days: 2)),
    category: SpendingCategory.transportation,
  ),
  SpendingEntry(
    content: 'Movie Tickets',
    amount: 32.00,
    notes: 'Avengers with friends',
    date: DateTime.now().subtract(Duration(days: 3)),
    category: SpendingCategory.entertainment,
  ),
  SpendingEntry(
    content: 'Electricity Bill',
    amount: 120.45,
    notes: 'Monthly payment',
    date: DateTime.now().subtract(Duration(days: 5)),
    category: SpendingCategory.utilities,
  ),
  SpendingEntry(
    content: 'New Shoes',
    amount: 89.99,
    notes: 'Nike running shoes',
    date: DateTime.now().subtract(Duration(days: 7)),
    category: SpendingCategory.shopping,
  ),
];
