// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:st4_tuan5_trancongmanh/database/db_helper.dart';
import 'package:st4_tuan5_trancongmanh/model/sinhvien.dart';
import 'package:st4_tuan5_trancongmanh/view/v_adSinhVien.dart';

// Define the missing SinhVienListScreen00 class
class SinhVienListScreen00 extends StatefulWidget {
  const SinhVienListScreen00({super.key});
  @override
  State<SinhVienListScreen00> createState() => _SinhVienListScreen00State();
}

class _SinhVienListScreen00State extends State<SinhVienListScreen00> {
  late Future<List<SinhVien>> sinhVienList = Future.value([]);
  final DatabaseHelper db = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _initDatabase();
  }

  Future<void> _initDatabase() async {
    try {
      // Fetch all students from the database
      List<SinhVien> sinhViens = await db.getAllSinhVien();
      print("Initial students: $sinhViens"); // Log the initial list

      if (sinhViens.isEmpty) {
        // If the list is empty, add default students
        SinhVien sv = SinhVien(name: "Nguyen Van A", email: "a@example.com");
        await db.insertSinhVien(sv);

        SinhVien sv1 = SinhVien(name: "Nguyen Van B", email: "b@example.com");
        await db.insertSinhVien(sv1);

        // Fetch the updated list
        sinhViens = await db.getAllSinhVien();
        print("Updated students: $sinhViens"); // Log the updated list
      }

      // Update the state with the fetched list
      setState(() {
        sinhVienList = Future.value(sinhViens);
      });
    } catch (e) {
      print("Error initializing database: $e"); // Log any errors
      setState(() {
        sinhVienList = Future.value([]);
      });
    }
  }

  Future<void> _loadSinhVien() async {
    List<SinhVien> list = await db.getAllSinhVien();
    setState(() {
      sinhVienList = Future.value(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách sinh viên"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Thêm sinh viên',
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddSinhVien()),
              );
              if (result == true) {
                await _loadSinhVien();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Thêm sinh viên thành công"),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<SinhVien>>(
        future: sinhVienList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("Chưa có thông tin sinh viên"));
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              SinhVien sv = snapshot.data![index];
              return Card(
                child: ListTile(
                  title: Text(
                    sv.name,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    sv.email,
                    style: TextStyle(color: Colors.lightBlue),
                  ),
                  trailing: Icon(Icons.email, color: Colors.blue),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
