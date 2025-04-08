import 'package:flutter/material.dart';

class GridItem {
  final IconData leading;
  final String title;
  GridItem(this.leading, this.title);
}

class MyGridView02 extends StatefulWidget {
  const MyGridView02({super.key});
  @override
  State<MyGridView02> createState() => _MyGridView02State();
}

class _MyGridView02State extends State<MyGridView02> {
  static List<GridItem> gridItemList = [
    GridItem(Icons.business, "Hệ thống thông tin"),
    GridItem(Icons.account_balance, "Khoa học máy tính"),
    GridItem(Icons.account_circle, "Công nghệ phần mềm"),
    GridItem(Icons.account_box, "Kỹ thuật máy tính"),
    GridItem(Icons.business, "Hệ thống thông tin"),
    GridItem(Icons.account_balance, "Khoa học máy tính"),
    GridItem(Icons.account_circle, "Công nghệ phần mềm"),
    GridItem(Icons.account_box, "Kỹ thuật máy tính"),
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: gridItemList.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(gridItemList[index].title),
                  content: Text("Bạn chọn ${gridItemList[index].title}"),
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
          },
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(gridItemList[index].leading, size: 50, color: Colors.red),
                Text(gridItemList[index].title),
              ],
            ),
          ),
        );
      },
    );
  }
}
