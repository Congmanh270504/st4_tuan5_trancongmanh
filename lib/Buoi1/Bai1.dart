// ignore_for_file: avoid_print

import 'dart:math';
import 'dart:io';

void menu() {
  print("***************Chọn bài muốn làm******************\n");
  print("*             1.Xuất mảng                        *\n");
  print("*             2.Trung bình cộng số lẻ            *\n");
  print("*             3.Kiểm tra mảng đối xứng           *\n");
  print("*             4.Kiểm tra tăng dần                *\n");
  print("*             5.Phần tử lớn nhất trong mảng      *\n");
  print("*             6.Phần tử chẵn lớn nhất trong mảng *\n");
  print("*             7.Tìm và xóa phần tử tương ứng     *\n");
  print("*             0.Thoat chuong trinh               *\n");
  print("*********************End**************************\n");
}

void init(List<int> arr, int large) {
  arr.clear(); // Clear the list if it has any existing elements
  Random random = Random();
  for (int i = 0; i < large; i++) {
    arr.add(random.nextInt(100)); // Add random numbers to the list
  }
}

void printArray(List<int> arr) {
  for (var num in arr) {
    stdout.write("$num ");
  }
  print("");
}

double averageOdd(List<int> arr) {
  double average = 0;
  int count = 0;
  for (var num in arr) {
    if (num % 2 != 0) {
      average += num;
      count++;
    }
  }
  if (average == 0) return 0;
  average /= count;
  return average;
}

bool checkSymmetry(List<int> arr) {
  for (int i = 0; i < arr.length / 2; i++) {
    if (arr[i] != arr[arr.length - i - 1]) {
      return false;
    }
  }
  return true;
}

bool isIncrease(List<int> arr) {
  for (int i = 0; i < arr.length - 1; i++) {
    if (arr[i] > arr[i + 1]) {
      return false;
    }
  }
  return true;
}

int findMax(List<int> arr) {
  int max = arr[0];
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] > max) {
      max = arr[i];
    }
  }
  return max;
}

bool anyEven(List<int> arr) {
  for (var num in arr) {
    if (num % 2 != 0) {
      return false;
    }
  }
  return true;
}

bool isEven(int number) {
  return number % 2 == 0 ? true : false;
}

int findMaxEven(List<int> arr) {
  int max = 0;
  for (var i = 0; i < arr.length; i++) {
    if (isEven(arr[i])) {
      max = arr[i];
      break;
    }
  }
  for (int i = 1; i < arr.length; i++) {
    if (arr[i] > max && arr[i] % 2 == 0) {
      max = arr[i];
    }
  }
  return max;
}

bool isExist(List<int> arr, int number) {
  for (var num in arr) {
    if (num == number) {
      return true;
    }
  }
  return false;
}

void BT1() {
  int choose;
  menu();
  int large;
  int number;
  List<int> arr = [];
  do {
    stdout.write("Nhập bài muốn làm: ");
    choose = int.parse(stdin.readLineSync()!);
    stdout.write("\n");
    switch (choose) {
      case 1:
        stdout.write("Nhập số phần tử của mảng: ");
        large = int.parse(stdin.readLineSync()!);
        init(arr, large);
        if (arr.isEmpty) {
          stdout.write("Mảng rỗng\n");
          return;
        }
        printArray(arr);
        break;
      case 2:
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
        } else {
          double average = averageOdd(arr);
          if (average == 0) {
            stdout.write("Danh sách không có số lẻ \n");
          } else {
            stdout.write(
              "Trung bình cộng của các số lẻ trong mảng là: $average \n",
            );
          }
        }
      case 3:
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
          break;
        }
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
        } else {
          if (checkSymmetry(arr)) {
            stdout.write("Mảng đối xứng\n");
          } else {
            stdout.write("Mảng không đối xứng\n");
          }
        }
        break;
      case 4:
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
          break;
        }
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
        } else {
          if (isIncrease(arr)) {
            stdout.write("Mảng tăng dần\n");
          } else {
            stdout.write("Mảng không tăng dần\n");
          }
        }
        break;
      case 5:
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
          break;
        }
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
        } else {
          stdout.write("Giá trị lớn nhất trong mảng là : ${findMax(arr)} \n");
        }
        break;
      case 6:
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
          break;
        }
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
        } else {
          if (anyEven(arr)) {
            stdout.write("Mảng không có số chẵn\n");
          } else {
            stdout.write(
              "Giá trị chẵn lớn nhất trong mảng là : ${findMaxEven(arr)} \n",
            );
          }
        }
        break;
      case 7:
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
          break;
        }
        if (arr.isEmpty) {
          stdout.write("Hãy chọn câu 1 trước\n");
        } else {
          stdout.write("Nhập số để xóa: ");
          number = int.parse(stdin.readLineSync()!);
          arr.any((i) => i == number)
              ? arr.removeWhere((i) => (i == number))
              : stdout.write("Số $number không tồn tại trong mảng\n");
        }
        printArray(arr);
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
