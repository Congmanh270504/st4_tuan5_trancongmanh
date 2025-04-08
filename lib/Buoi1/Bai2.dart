import 'dart:math';
import 'dart:io';

void menu() {
  print("***************Chọn bài muốn làm******************\n");
  print("*             1.Xuất chuỗi                       *\n");
  print("*             2.Số lượng kí tự nguyên âm         *\n");
  print("*             3.Số lượng từ                      *\n");
  print("*             4.Kiểm tra đối xứng                *\n");
  print("*             5.Đảo ngược từ trong chuỗi         *\n");
  print("*             0.Thoat chuong trinh               *\n");
  print("*********************End**************************\n");
}

bool isSymmetry(String text) {
  for (int i = 0; i < text.length / 2; i++) {
    if (text[i] != text[text.length - i - 1]) {
      return false;
    }
  }
  return true;
}

void BT2() {
  int choose;
  String text = "";
  List<String> nguyenAm = ["a", "e", "i", "o", "u"];
  menu();
  do {
    stdout.write("Chọn bài: ");
    choose = int.parse(stdin.readLineSync()!);
    switch (choose) {
      case 1:
        stdout.write("Nhập chuỗi: ");
        text = stdin.readLineSync()!;
        stdout.write("$text \n");
        break;
      case 2:
        if (text.isEmpty) {
          stdout.write("Chưa nhập chuỗi. Mời chọn lại câu 1!! \n");
        } else {
          int count = 0;
          for (var char in text.toLowerCase().split('')) {
            if (nguyenAm.contains(char)) {
              count++;
            }
          }
          stdout.write("Số lượng nguyên âm trong chuỗi là: $count\n");
        }
        break;
      case 3:
        if (text.isEmpty) {
          stdout.write("Chưa nhập chuỗi. Mời chọn lại câu 1!! \n");
        } else {
          int count = text.toLowerCase().split(' ').length;
          stdout.write("Số lượng từ trong chuỗi là: $count\n");
        }
        break;
      case 4:
        if (text.isEmpty) {
          stdout.write("Chưa nhập chuỗi. Mời chọn lại câu 1!! \n");
        } else {
          if (isSymmetry(text)) {
            stdout.write("Chuỗi đối xứng\n");
          } else {
            stdout.write("Chuỗi không đối xứng\n");
          }
        }
        break;
      case 5:
        if (text.isEmpty) {
          stdout.write("Chưa nhập chuỗi. Mời chọn lại câu 1!! \n");
        } else {
          stdout.write(
            "Chuỗi sau khi đảo ngược lại là : ${text.split('').reversed.join()}\n",
          );
        }
        break;
      case 0:
        stdout.write("Chương trình đã tắt!!\n");
        break;
      default:
        stdout.write("Không có sự lựa chọn số $choose!! \n");
        break;
    }
  } while (choose != 0);
}
