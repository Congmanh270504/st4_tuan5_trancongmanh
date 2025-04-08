import 'package:flutter/material.dart';

List<String> name = [
  'Học lập trình Flutter',
  'Học lập trình Flutter cùng Group 1',
  'Học lập trình Flutter cùng Group 2',
  'Học lập trình Flutter cùng Group 3',
  'Học lập trình Flutter cùng Group 4',
];

class MyListViewDemo extends StatefulWidget {
  const MyListViewDemo({super.key});

  @override
  State<MyListViewDemo> createState() => _MyListViewDemo();
}

class _MyListViewDemo extends State<MyListViewDemo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ListView Demo'),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: name.length,
        itemBuilder: (context, index) {
          return MyListItem(name: name[index]);
        },
      ),
    );
  }
}

class MyListItem extends StatelessWidget {
  const MyListItem({super.key, required this.name});
  final String name;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      child: IntrinsicHeight(
        child: ListTile(
          title: Text(name),
          subtitle: Text('Học lập trình Flutter cùng Group 1'),
          leading: Icon(Icons.account_balance_wallet),
          trailing: Icon(Icons.arrow_forward),
        ),
      ),
    );
  }
}
