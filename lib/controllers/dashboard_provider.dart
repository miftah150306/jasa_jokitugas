import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/service_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardProvider extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // Calculator Logic
  String _selectedTaskType = "Pemrograman Dasar";
  double _difficulty = 1.0;
  double _deadline = 7.0;
  
  String get selectedTaskType => _selectedTaskType;
  double get difficulty => _difficulty;
  double get deadline => _deadline;

  void updateCalculator({String? type, double? diff, double? dl}) {
    if (type != null) _selectedTaskType = type;
    if (diff != null) _difficulty = diff;
    if (dl != null) _deadline = dl;
    notifyListeners();
  }

  int get estimatedPrice {
    double base = 50000;
    if (_selectedTaskType.contains("Web Statis")) base = 150000;
    if (_selectedTaskType.contains("Web Dinamis")) base = 500000;
    if (_selectedTaskType.contains("Mobile")) base = 750000;
    if (_selectedTaskType.contains("Data Science")) base = 400000;

    double multiplier = 1 + (14 - _deadline) / 13;
    return (base * _difficulty * multiplier).round();
  }

  String get formattedPrice => NumberFormat.decimalPattern('id-ID').format(estimatedPrice);

  // Status Checker Logic
  String _statusResult = "";
  String get statusResult => _statusResult;
  bool _isLoadingStatus = false;
  bool get isLoadingStatus => _isLoadingStatus;

  Future<void> checkStatus(String jobId) async {
    _isLoadingStatus = true;
    _statusResult = "";
    notifyListeners();

    // Simulating API call
    await Future.delayed(const Duration(seconds: 2));
    
    if (jobId.toUpperCase().startsWith("JP-")) {
      _statusResult = "Status: Sedang Dikerjakan (65%)";
    } else {
      _statusResult = "ID Tugas tidak ditemukan. Silakan hubungi admin.";
    }
    
    _isLoadingStatus = false;
    notifyListeners();
  }

  // Static Data
  final List<ServiceModel> services = [
    ServiceModel(title: "Web Development", description: "HTML, CSS, JS, React, Next.js, Laravel, PHP, MySQL.", icon: FontAwesomeIcons.globe, basePrice: 150000),
    ServiceModel(title: "Mobile App", description: "Flutter, Android Native, React Native.", icon: FontAwesomeIcons.mobileScreen, basePrice: 750000),
    ServiceModel(title: "Data Science & AI", description: "Python, Machine Learning, Data Scraping.", icon: FontAwesomeIcons.brain, basePrice: 400000),
    ServiceModel(title: "Desktop App", description: "Java GUI, C++, C#, Python Tkinter.", icon: FontAwesomeIcons.desktop, basePrice: 200000),
    ServiceModel(title: "Tugas Akademik", description: "Algoritma, Struktur Data, Basis Data.", icon: FontAwesomeIcons.book, basePrice: 50000),
    ServiceModel(title: "Bug Fixing", description: "Perbaikan error pada kode yang sudah ada.", icon: FontAwesomeIcons.bug, basePrice: 75000),
  ];
}
