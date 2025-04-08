import 'dart:io';

import 'package:flutter/material.dart';
import 'package:st4_tuan5_trancongmanh/Buoi6/screens/add_entry_screen.dart';
import 'package:st4_tuan5_trancongmanh/Buoi6/screens/entry_details_screen.dart';
import 'package:st4_tuan5_trancongmanh/Buoi6/screens/home_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:flutter/foundation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfiWeb;
  } else if (Platform.isWindows || Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  runApp(SpendingManagerApp());
}

class SpendingManagerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Spending Manager',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        appBarTheme: AppBarTheme(backgroundColor: Colors.teal, elevation: 0),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.teal,
        ),
      ),
      home: HomeScreen(),
      routes: {
        '/add': (context) => AddEntryScreen(),
        '/details': (context) => EntryDetailsScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
