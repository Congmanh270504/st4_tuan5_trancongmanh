import 'package:flutter/material.dart';

class MyListView extends StatefulWidget {
  const MyListView({super.key});

  @override
  State<MyListView> createState() => _MyListViewState();
}

class Item {
  final IconData leading;
  final String title;
  final String subtitle;
  final String dialogMessage;
  Item(this.leading, this.title, this.subtitle, this.dialogMessage);
}

List<Item> listItem = [
  Item(
    Icons.business,
    "Hệ thống thông tin",
    "Phát triển các kỹ thuật xử lý thông tin trong tổ chức",
    "Bạn chọn HTTT",
  ),
  Item(
    Icons.account_balance,
    "Khoa học máy tính",
    "Nghiên cứu về các phương pháp tính toán",
    "Bạn chọn Khoa học máy tính",
  ),
  Item(
    Icons.account_circle,
    "Công nghệ phần mềm",
    "Phát triển phần mềm chất lượng cao",
    "Bạn chọn Công nghệ phần mềm",
  ),
  Item(
    Icons.account_box,
    "Kỹ thuật máy tính",
    "Nghiên cứu về cấu trúc và hoạt động của máy tính",
    "Bạn chọn Kỹ thuật máy tính",
  ),
];

class _MyListViewState extends State<MyListView> {
  void _showDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
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

  static const TextStyle _textStyle = TextStyle(
    fontSize: 20,
    color: Colors.red,
    fontWeight: FontWeight.bold,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Demo'),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.home),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: listItem.length,
        itemBuilder: (context, index) {
          Item item = listItem[index];
          return ListTile(
            leading: Icon(item.leading),
            title: Text(item.title, style: _textStyle),
            subtitle: Text(item.subtitle),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              _showDialog('Thông báo', item.dialogMessage);
            },
          );
        },
      ),
    );
  }
}
