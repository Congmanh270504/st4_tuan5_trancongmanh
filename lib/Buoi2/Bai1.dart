// ignore_for_file: avoid_print

import 'dart:io';
import 'package:intl/intl.dart';

int calculate() {
  return 6 * 7;
}

abstract class KhachHang {
  late String _maKhachHang;
  late String _tenKhachHang;
  late int _soLuong;
  late int _donGia;
  KhachHang.full(
    this._maKhachHang,
    this._tenKhachHang,
    this._soLuong,
    this._donGia,
  );
  KhachHang() {
    _maKhachHang = '';
    _tenKhachHang = '';
    _soLuong = 0;
    _donGia = 0;
  }
  void nhapTTKH() {
    print("Nhập mã khách hàng: ");
    maKhachHang = stdin.readLineSync()!;
    print("Nhập tên khách hàng: ");
    tenKhachHang = stdin.readLineSync()!;
    print("Nhập số lượng: ");
    soLuong = int.parse(stdin.readLineSync()!);
    print("Nhập đơn giá: ");
    donGia = int.parse(stdin.readLineSync()!);
  }

  void inTTKH();

  get maKhachHang => _maKhachHang;
  set maKhachHang(value) {
    if (_maKhachHang.length != 6 ||
        !_maKhachHang.startsWith("KH") ||
        !_maKhachHang.substring(2).contains(RegExp(r'^\d{4}$'))) {
      print("Mã KH không hợp lệ");
      return;
    }
    _maKhachHang = value;
  }

  get tenKhachHang => _tenKhachHang;
  set tenKhachHang(value) {
    if (value.toString().isEmpty) {
      print("Tên KH không hợp lệ");
      return;
    }
    _tenKhachHang = value;
  }

  get soLuong => _soLuong;
  set soLuong(value) {
    if (value < 1) {
      print("Số lượng không hợp lệ");
      return;
    }
    _soLuong = value;
  }

  get donGia => _donGia;
  set donGia(value) {
    if (value < 1) {
      print("Đơn giá không hợp lệ");
      return;
    }
    _donGia = value;
  }

  double tinhChietKhau();
  double troGia();
  double tinhTien() {
    return _soLuong * _donGia -
        _soLuong * _donGia * tinhChietKhau() +
        _soLuong * _donGia * 0.1 -
        troGia();
  }
}

class KhachHangCaNhan extends KhachHang {
  int khoangCach;
  KhachHangCaNhan(
    this.khoangCach,
    String maKhachHang,
    String tenKhachHang,
    int soLuong,
    int donGia,
  ) : super.full(maKhachHang, tenKhachHang, soLuong, donGia);
  void nhapKhachHang() {
    print("Nhập khoảng cách: ");
    khoangCach = int.parse(stdin.readLineSync()!);
  }

  @override
  void inTTKH() {
    print(
      "===================== Thông Tin Khách Hàng ========================",
    );
    print('||${'Khoảng cách: $khoangCach'.padLeft(30).padRight(60)}||');
    print('||${'Mã khách hàng: $maKhachHang'.padLeft(30).padRight(60)}||');
    print('||${'Tên khách hàng: $tenKhachHang'.padLeft(30).padRight(60)}||');
    print('||${'Số lượng: $soLuong cái'.padLeft(30).padRight(60)}||');
    print('||${'Đơn giá: $donGia đ'.padLeft(30).padRight(60)}||');
    print("||${'Thành tiền ${tinhTien()}đ'.padLeft(30).padRight(60)}||");
    print("||${'Trợ giá: ${troGia()}đ'.padLeft(30).padRight(60)}||");
    print(
      "============================= End ================================\n",
    );
  }

  @override
  double troGia() {
    if (_soLuong > 2) return 100000;
    return _soLuong * _donGia * 0.2;
  }

  @override
  double tinhChietKhau() {
    if (khoangCach < 10) {
      return _soLuong * _donGia * 50000;
    }
    if (_soLuong < 3) {
      return 0;
    } else {
      return _soLuong * _donGia * 0.05;
    }
  }
}

class DaiLyC1 extends KhachHang {
  DateTime tgHopTac;
  DaiLyC1(
    this.tgHopTac,
    String maKhachHang,
    String tenKhachHang,
    int soLuong,
    int donGia,
  ) : super.full(maKhachHang, tenKhachHang, soLuong, donGia);

  void nhapDaiLyC1() {
    print("Nhập thời gian hợp tác: ");
    tgHopTac = DateTime.parse(stdin.readLineSync()!);
  }

  @override
  void inTTKH() {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formattedDate = formatter.format(tgHopTac);
    print(
      "===================== Thông Tin Đại Lý Cấp 1 ======================",
    );
    print(
      '||${'Thời gian hợp tác: $formattedDate'.padLeft(30).padRight(60)}||',
    );
    print('||${'Mã khách hàng: $maKhachHang'.padLeft(30).padRight(60)}||');
    print('||${'Tên khách hàng: $tenKhachHang'.padLeft(30).padRight(60)}||');
    print('||${'Số lượng: $soLuong cái'.padLeft(30).padRight(60)}||');
    print('||${'Đơn giá: $donGia đ'.padLeft(30).padRight(60)}||');
    print("||${'Thành tiền ${tinhTien()}đ'.padLeft(30).padRight(60)}||");
    print(
      "============================= End ================================\n",
    );
  }

  @override
  double troGia() {
    return 0;
  }

  @override
  double tinhChietKhau() {
    int year = DateTime.now().year - tgHopTac.year;
    double time = year - 5;
    if (time > 5 && time <= 10) {
      return _soLuong * _donGia * (0.3 + time / 100);
    } else if (time > 10) {
      return _soLuong * _donGia * 0.35;
    } else {
      return _soLuong * _donGia * 0.3;
    }
  }
}

class CongTy extends KhachHang {
  int soLuongNV;
  CongTy(
    this.soLuongNV,
    String maKhachHang,
    String tenKhachHang,
    int soLuong,
    int donGia,
  ) : super.full(maKhachHang, tenKhachHang, soLuong, donGia);
  void nhapCongTy() {
    print("Nhập số lượng nhân viên: ");
    soLuongNV = int.parse(stdin.readLineSync()!);
  }

  @override
  void inTTKH() {
    print("===================== Thông Tin Công Ty ========================");
    print('||${'Số lượng nhân viên: $soLuongNV'.padLeft(30).padRight(60)}||');
    print('||${'Mã khách hàng: $maKhachHang'.padLeft(30).padRight(60)}||');
    print('||${'Tên khách hàng: $tenKhachHang'.padLeft(30).padRight(60)}||');
    print('||${'Số lượng: $soLuong cái'.padLeft(30).padRight(60)}||');
    print('||${'Đơn giá: $donGia đ'.padLeft(30).padRight(60)}||');
    print("||${'Thành tiền ${tinhTien()}đ'.padLeft(30).padRight(60)}||");
    print("||${'Trợ giá: ${troGia()}đ'.padLeft(30).padRight(60)}||");
    print(
      "============================= End ================================\n",
    );
  }

  @override
  double troGia() {
    return 200000;
  }

  @override
  double tinhChietKhau() {
    if (soLuongNV > 5000) {
      return _soLuong * _donGia * 0.7;
    }
    if (soLuongNV > 1000) {
      return _soLuong * _donGia * 0.5;
    }
    return 0.0;
  }
}
