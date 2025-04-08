import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DeTai {
  final String maDeTai;
  final String tenDeTai;
  final String tenGiangVien;
  final String noiDung;
  final String chuyenNganh;
  DeTai(
    this.maDeTai,
    this.tenDeTai,
    this.tenGiangVien,
    this.noiDung,
    this.chuyenNganh,
  );
}

class DeTaiItem extends StatelessWidget {
  final DeTai deTai;
  const DeTaiItem({Key? key, required this.deTai}) : super(key: key);
  static const TextStyle _textStyle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Colors.red,
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: Colors.blue,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(deTai.maDeTai, style: _textStyle),
            subtitle: Text(
              deTai.tenDeTai,
              style: TextStyle(fontSize: 18, color: Colors.blue),
              maxLines: 2,
            ),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Thông báo"),
                    content: Text("Bạn chọn ${deTai.tenDeTai}"),
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
          ),
          const Divider(
            color: Colors.black,
            height: 5,
            thickness: 2,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              "Chuyên ngành: ${deTai.chuyenNganh}",
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            "Giáo viên: ${deTai.tenGiangVien}",
            textAlign: TextAlign.end,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class ListDeTai extends StatefulWidget {
  const ListDeTai({super.key});
  @override
  State<ListDeTai> createState() => _ListDeTaiState();
}

class _ListDeTaiState extends State<ListDeTai> {
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

  static List<DeTai> deTaiList = [
    DeTai(
      "DT01",
      "Ứng dụng công nghệ thông tin trong giáo dục",
      "Nguyễn Văn A",
      "Nghiên cứu và phát triển ứng dụng công nghệ thông tin trong giáo dục",
      "Hệ thống thông tin",
    ),
    DeTai(
      "DT02",
      "Phân tích dữ liệu",
      "Nguyễn Văn B",
      "Nghiên cứu và phát triển ứng dụng phân tích dữ liệu",
      "Khoa học máy tính",
    ),
    DeTai(
      "DT03",
      "Phát triển ứng dụng di động",
      "Nguyễn Văn C",
      "Nghiên cứu và phát triển ứng dụng di động",
      "Công nghệ phần mềm",
    ),
    DeTai(
      "DT04",
      "Phát triển ứng dụng web",
      "Nguyễn Văn D",
      "Nghiên cứu và phát triển ứng dụng web",
      "Kỹ thuật máy tính",
    ),
    DeTai(
      "DT05",
      "Phát triển ứng dụng web",
      "Nguyễn Văn D",
      "Nghiên cứu và phát triển ứng dụng web",
      "Kỹ thuật máy tính",
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách đề tài'),
        leading: IconButton(icon: Icon(Icons.home), onPressed: () {}),
        backgroundColor: Colors.redAccent,
      ),
      body: ListView.builder(
        itemCount: deTaiList.length,
        itemBuilder: (BuildContext context, int index) {
          return DeTaiItem(deTai: deTaiList[index]);
        },
      ),
    );
  }
}
