import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:st4_tuan5_trancongmanh/database/db_helper.dart';
import 'package:st4_tuan5_trancongmanh/database/db_helper_SpendingEntry.dart';
import 'package:st4_tuan5_trancongmanh/model/SpendingEntry.dart';

class AddEntryScreen extends StatefulWidget {
  const AddEntryScreen({super.key});
  @override
  _AddEntryScreenState createState() => _AddEntryScreenState();
}

class _AddEntryScreenState extends State<AddEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _contentController = TextEditingController();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final DatabaseHelperSpendingEntry db = DatabaseHelperSpendingEntry();

  DateTime _selectedDate = DateTime.now();
  SpendingCategory _selectedCategory = SpendingCategory.food;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(Duration(days: 1)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _saveThuChi() async {
    String contentController = _contentController.text.trim();
    String amountController = _amountController.text.trim();
    String notesController = _notesController.text.trim();

    if (contentController.isEmpty || contentController.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }
    SpendingEntry se = SpendingEntry(
      content: contentController,
      amount: double.parse(amountController),
      date: _selectedDate,
      notes: notesController,
      category: _selectedCategory,
    );
    await db.insertSpendingEntry(se);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Spending')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Spending Details',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _contentController,
                        decoration: InputDecoration(
                          labelText: 'Spending Content',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.shopping_cart),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter spending content';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _amountController,
                        decoration: InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.attach_money),
                        ),
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'^\d+\.?\d{0,2}'),
                          ),
                        ],
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an amount';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Please enter a valid number';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Category & Date',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      DropdownButtonFormField<SpendingCategory>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          labelText: 'Category',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items:
                            SpendingCategory.values.map((category) {
                              return DropdownMenuItem(
                                value: category,
                                child: Row(
                                  children: [
                                    Icon(
                                      SpendingEntry(
                                        id: 0,
                                        content: '',
                                        amount: 0,
                                        category: category,
                                        date: DateTime.now(),
                                      ).categoryIcon,
                                      color:
                                          SpendingEntry(
                                            id: 0,
                                            content: '',
                                            amount: 0,
                                            category: category,
                                            date: DateTime.now(),
                                          ).categoryColor,
                                    ),
                                    SizedBox(width: 8),
                                    Text(category.toString().split('.').last),
                                  ],
                                ),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                      SizedBox(height: 16),
                      InkWell(
                        onTap: () => _selectDate(context),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            labelText: 'Date',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          child: Text(
                            DateFormat('MMM dd, yyyy').format(_selectedDate),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Additional Information',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextFormField(
                        controller: _notesController,
                        decoration: InputDecoration(
                          labelText: 'Notes',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.note),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // TODO: Save the entry
                      _saveThuChi();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Entry saved")),
                      );
                      Navigator.pop(context, true);
                    }
                  },
                  child: Text('SAVE', style: TextStyle(fontSize: 16)),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _contentController.dispose();
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }
}
