import 'package:flutter/material.dart';

class MajorInfor extends StatelessWidget {
  const MajorInfor({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              "assets/images/huit.png",
              width: 50,
              height: 50,
              fit: BoxFit.scaleDown,
            ),
          ),
          Center(
            child: Text(
              'Mã ngành: 12345',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Tên ngành: Công nghệ thông tin',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Số lượng sinh viên: 1000',
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              'Thông tin về khoa: chuyên giảng dạy về bộ môn máy tính website',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Địa chỉ: 140 Lê Trọng Tấn TP.HCM',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Image.asset(
              "assets/images/Thu_vien_HUIT.jpg",
              width: 50,
              height: 50,
              fit: BoxFit.scaleDown,
            ),
          ),
          Center(
            child: Text(
              'Mã ngành: 270504',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Tên ngành: An toàn thông tin',
              style: TextStyle(fontSize: 18),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Số lượng sinh viên: 2000',
              style: TextStyle(fontSize: 18, color: Colors.redAccent),
            ),
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              'Thông tin về khoa: chuyên giảng dạy về bộ môn bảo mật thông tin',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Center(
            child: Text(
              'Địa chỉ: 140 Lê Trọng Tấn TP.HCM',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
