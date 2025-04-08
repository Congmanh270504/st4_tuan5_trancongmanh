import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  const MyDialog({super.key});
  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Thông báo'),
          content: const Text('Bạn có chắc chắn muốn thoát không?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Không'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Có'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: ElevatedButton(
              onPressed: _showDialog,
              child: const Text('Thoát'),
            ),
          ),
        ],
      ),
    );
  }
}
