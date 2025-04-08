import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyGridView01 extends StatefulWidget {
  const MyGridView01({super.key});
  @override
  State<MyGridView01> createState() => _MyGridView01State();
}

class _MyGridView01State extends State<MyGridView01> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GridView Demo'),
        backgroundColor: Colors.redAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pop(context);
          },
        ),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            child: Center(child: Text('Item $index')),
          );
        },
      ),
    );
  }
}
