import 'package:flutter/material.dart';
import 'package:st4_tuan5_trancongmanh/model/sinhvien.dart';
import '../database/db_helper.dart';

class AddSinhVien extends StatefulWidget {
  const AddSinhVien({super.key});

  @override
  State<AddSinhVien> createState() => _AddSinhVienState();
}

class _AddSinhVienState extends State<AddSinhVien> {
  final TextEditingController _txtTen = TextEditingController();
  final TextEditingController _txtEmail = TextEditingController();
  final FocusNode _focusTen = FocusNode(); // FocusNode to manage focus
  final DatabaseHelper db = DatabaseHelper();

  Future<void> _saveSinhVien() async {
    String name = _txtTen.text.trim();
    String email = _txtEmail.text.trim();

    if (name.isEmpty || email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin")),
      );
      return;
    }

    SinhVien sv = SinhVien(name: name, email: email);
    await db.insertSinhVien(sv);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context, true); // Return to the previous screen
          },
        ),
        title: const Text(
          'Thêm sinh viên',
          style: TextStyle(color: Color.fromRGBO(15, 100, 197, 1)),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Lưu sinh viên',
            onPressed: () {
              _saveSinhVien();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Thêm sinh viên thành công")),
              );

              Navigator.pop(context, true); // Return to the previous screen
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            TextField(
              controller: _txtTen,
              focusNode: _focusTen,
              decoration: const InputDecoration(
                labelText: "Nhập tên",
                hintText: "Nhập tên của bạn...",
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _txtEmail,
              decoration: const InputDecoration(
                labelText: "Nhập email",
                hintText: "Nhập email của bạn...",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
