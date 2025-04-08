// ignore: file_names
import 'package:flutter/material.dart';

class GroupInfo extends StatelessWidget {
  const GroupInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mã nhóm: 12345',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Tên nhóm: Nhóm MobleDev', style: TextStyle(fontSize: 18)),
          SizedBox(height: 8),
          Text('Số lượng thành viên: 3', style: TextStyle(fontSize: 18)),
          SizedBox(height: 16),
          Text(
            'Thành viên:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          MemberTable(),
        ],
      ),
    );
  }
}

class MemberTable extends StatelessWidget {
  const MemberTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Mã sinh viên',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Tên sinh viên',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Vai trò',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
        MemberTableRow(
          studentId: '001',
          studentName: 'Trần Công Mạnh',
          role: 'Nhóm trưởng',
        ),
        MemberTableRow(
          studentId: '002',
          studentName: 'Nguyễn Minh Sơn',
          role: 'Thành viên',
        ),
        MemberTableRow(
          studentId: '003',
          studentName: 'Cao Hoàng Tấn',
          role: 'Thành viên',
        ),
      ],
    );
  }
}

class MemberTableRow extends TableRow {
  MemberTableRow({
    required String studentId,
    required String studentName,
    required String role,
  }) : super(
         children: [
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(child: Text(studentId)),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(child: Text(studentName)),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Center(child: Text(role)),
           ),
         ],
       );
}
