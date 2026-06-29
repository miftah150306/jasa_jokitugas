import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/service_model.dart';
import '../models/education_level_model.dart';
import '../models/comment_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardProvider extends ChangeNotifier {
  // ── Theme (Light/Dark Mode & Colors) ─────────────────────────────────
  bool _isDarkMode = true;
  Color _primaryColor = const Color(0xFF6366F1); // Indigo
  Color _secondaryColor = const Color(0xFFEC4899); // Pink

  bool get isDarkMode => _isDarkMode;
  Color get primaryColor => _primaryColor;
  Color get secondaryColor => _secondaryColor;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void updateThemeColor(Color primary, Color secondary) {
    _primaryColor = primary;
    _secondaryColor = secondary;
    notifyListeners();
  }

  Color get bgColor => _isDarkMode ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9);
  Color get cardColor => _isDarkMode ? const Color(0xFF1E293B) : Colors.white;
  Color get textColor => _isDarkMode ? Colors.white : const Color(0xFF0F172A);
  Color get textMuted => _isDarkMode ? Colors.white54 : Colors.black54;
  Color get borderColor => _isDarkMode ? Colors.white10 : Colors.black12;

  // ── Navigation ─────────────────────────────────────────────
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  // ── Role Selector (V1.3) ────────────────────────────────────
  String _selectedLevelId = 'smk'; // default ke Paket Pro
  String get selectedLevelId => _selectedLevelId;

  EducationLevel get selectedLevel =>
      educationLevels.firstWhere((l) => l.id == _selectedLevelId);

  void setSelectedLevel(String levelId) {
    if (_selectedLevelId != levelId) {
      _selectedLevelId = levelId;
      notifyListeners();
    }
  }

  // ── Calculator Logic ────────────────────────────────────────
  String _selectedTaskType = "Web Statis";
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
    double base = 300000;

    // Paket Digital & Desain
    if (_selectedTaskType.contains("Landing Page")) base = 350000;
    if (_selectedTaskType.contains("Company Profile")) base = 700000;
    if (_selectedTaskType.contains("Desain Presentasi")) base = 250000;
    if (_selectedTaskType.contains("Otomatisasi Dokumen")) base = 200000;

    // Paket Development
    if (_selectedTaskType.contains("Web Statis")) base = 500000;
    if (_selectedTaskType.contains("Web Dinamis")) base = 1500000;
    if (_selectedTaskType.contains("Mobile App")) base = 3000000;
    if (_selectedTaskType.contains("Data Science")) base = 1500000;

    double multiplier = 1 + (14 - _deadline) / 13;
    return (base * _difficulty * multiplier).round();
  }

  String get formattedPrice =>
      NumberFormat.decimalPattern('id-ID').format(estimatedPrice);

  // ── Status Checker Logic ────────────────────────────────────
  String _statusResult = "";
  String get statusResult => _statusResult;
  bool _isLoadingStatus = false;
  bool get isLoadingStatus => _isLoadingStatus;

  Future<void> checkStatus(String jobId) async {
    _isLoadingStatus = true;
    _statusResult = "";
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (jobId.toUpperCase().startsWith("DC-")) {
      _statusResult = "Status: Sedang Dikerjakan (65%)";
    } else {
      _statusResult = "ID Proyek tidak ditemukan. Silakan hubungi tim DevConnect.";
    }

    _isLoadingStatus = false;
    notifyListeners();
  }

  // ── Comments Logic ──────────────────────────────────────────
  final List<CommentModel> _comments = [];

  List<CommentModel> get comments => _comments;

  void addComment(CommentModel comment) {
    _comments.insert(0, comment);
    notifyListeners();
  }

  // ── Legacy Static Services (kept for compatibility) ─────────
  final List<ServiceModel> services = [
    ServiceModel(
        title: "Web Development",
        description:
            "Website profesional: company profile, toko online, portal bisnis.",
        icon: FontAwesomeIcons.globe,
        basePrice: 750000),
    ServiceModel(
        title: "Mobile App",
        description:
            "Aplikasi Android/iOS siap publish: Flutter, React Native.",
        icon: FontAwesomeIcons.mobileScreen,
        basePrice: 3000000),
    ServiceModel(
        title: "Data Science & AI",
        description:
            "Analisis data bisnis, model prediktif, Python, ML.",
        icon: FontAwesomeIcons.brain,
        basePrice: 1500000),
    ServiceModel(
        title: "Desktop App",
        description:
            "Sistem manajemen internal: inventory, kasir, absensi.",
        icon: FontAwesomeIcons.desktop,
        basePrice: 800000),
    ServiceModel(
        title: "Sistem Informasi",
        description:
            "ERP, HRMS, CRM skala bisnis dengan dokumentasi lengkap.",
        icon: FontAwesomeIcons.buildingColumns,
        basePrice: 5000000),
    ServiceModel(
        title: "Bug Fixing & Audit",
        description:
            "Perbaikan error kritis, refactoring, dan code review standar industri.",
        icon: FontAwesomeIcons.bug,
        basePrice: 300000),
  ];
}
