// ignore_for_file: avoid_print

import 'dart:io';
import 'package:xml/xml.dart';
import 'package:st4_tuan5_trancongmanh/Buoi2/Bai1.dart';

Future<List<KhachHang>> readData(String fileName) async {
  List<KhachHang> list = [];
  try {
    File file = File(fileName);
    String xmlString = await file.readAsString();
    final document = XmlDocument.parse(xmlString);

    for (var khachHang in document.findAllElements('khachHangCaNhan')) {
      KhachHangCaNhan kh = KhachHangCaNhan(
        int.parse(khachHang.findElements('khoangCach').single.text),
        khachHang.findElements('maKhachHang').single.text,
        khachHang.findElements('tenKhachHang').single.text,
        int.parse(khachHang.findElements('soLuong').single.text),
        int.parse(khachHang.findElements('giaBan').single.text),
      );
      list.add(kh);
    }

    for (var daiLy in document.findAllElements('daiLyC1')) {
      DaiLyC1 dl = DaiLyC1(
        DateTime.parse(daiLy.findElements('tgHopTac').single.text),
        daiLy.findElements('maKhachHang').single.text,
        daiLy.findElements('tenKhachHang').single.text,
        int.parse(daiLy.findElements('soLuong').single.text),
        int.parse(daiLy.findElements('giaBan').single.text),
      );
      list.add(dl);
    }

    for (var congTy in document.findAllElements('congTy')) {
      CongTy ct = CongTy(
        int.parse(congTy.findElements('soLuongNV').single.text),
        congTy.findElements('maKhachHang').single.text,
        congTy.findElements('tenKhachHang').single.text,
        int.parse(congTy.findElements('soLuong').single.text),
        int.parse(congTy.findElements('giaBan').single.text),
      );
      list.add(ct);
    }
  } catch (e) {
    print(e);
  }
  return list;
}

void menu() {
  print("****************** Chọn bài muốn làm *********************\n");
  print("*        1.Nhập thông tin khách hàng                     *\n");
  print("*        2.Xuất thông tin khách hàng                     *\n");
  print("*        2.Tổng thành tiền của các đơn hàng              *\n");
  print("*        3.Tổng tiền trợ giá mà công ty đã hỗ trợ        *\n");
  print("*        4.Thông tin KH có số lượng mua nhiều nhất.      *\n");
  print("*        5.Tổng số tiền chiết khấu của công ty           *\n");
  print("*        6.Sắp xếp danh sách tăng dần theo số lượng      *\n");
  print("*        7.Thông tin khách hàng mua nhiều nhất           *\n");
  print("*        0.Thoat chuong trinh                            *\n");
  print("********************* End ********************************\n");
}

double total(List<KhachHang> list) {
  double sum = 0;
  for (KhachHang x in list) {
    sum += x.tinhTien();
  }
  return sum;
}

void xuatTTKH(List<KhachHang> list) {
  for (KhachHang x in list) {
    x.inTTKH();
  }
}

double tongChieuKhau(List<KhachHang> list) {
  double sum = 0;
  for (KhachHang x in list) {
    sum += x.tinhChietKhau();
  }
  return sum;
}

void sort(List<KhachHang> list) {
  list.sort(
    (a, b) =>
        a.soLuong == b.soLuong
            ? a.tinhTien().compareTo(b.tinhTien())
            : a.soLuong.compareTo(b.soLuong),
  );
  xuatTTKH(list);
}

KhachHang? findCustommer(List<KhachHang> list, String maKhachHang) {
  try {
    return list.firstWhere((element) => element.maKhachHang == maKhachHang);
  } catch (e) {
    return null;
  }
}

Future<void> main() async {
  List<KhachHang> ds = await readData('./lib/Buoi2/data.xml');
  String maKhachHang = "";
  int choose = 0;
  do {
    menu();
    stdout.write("Chọn bài: ");
    choose = int.parse(stdin.readLineSync()!);
    switch (choose) {
      case 1:
        stdout.write("Nhập thông tin khách hàng thành công\n");
        break;
      case 2:
        xuatTTKH(ds);
        break;
      case 3:
        stdout.write("Tổng thành tiền của các đơn hàng: ${total(ds)}\n");
        break;
      case 4:
        double sum = 0;
        for (KhachHang x in ds) {
          sum += x.troGia();
        }
        stdout.write("Tổng tiền trợ giá mà công ty đã hỗ trợ: $sum đ\n");
        break;
      case 5:
        stdout.write(
          "Tổng số tiền chiết khấu của công ty: ${tongChieuKhau(ds)} đ\n",
        );
        break;
      case 6:
        sort(ds);
        stdout.write(
          "Sắp xếp danh sách tăng dần theo số lượng thành công!! \n",
        );
        break;
      case 7:
        stdout.write("Nhập mã khách hàng cần tìm: ");
        maKhachHang = stdin.readLineSync()!;
        KhachHang? kh = findCustommer(ds, maKhachHang);
        if (kh == null) {
          stdout.write("Khách hàng không tồn tại\n");
        } else {
          stdout.write("Thông tin KH có số lượng mua nhiều nhất\n");
          kh.inTTKH();
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
