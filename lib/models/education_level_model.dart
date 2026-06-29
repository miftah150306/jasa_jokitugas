import 'package:flutter/material.dart';
import 'service_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EducationLevel {
  final String id;
  final String label;
  final String emoji;
  final IconData icon;
  final Color accentColor;
  final List<ServiceModel> services;

  const EducationLevel({
    required this.id,
    required this.label,
    required this.emoji,
    required this.icon,
    required this.accentColor,
    required this.services,
  });
}

final List<EducationLevel> educationLevels = [
  EducationLevel(
    id: 'sd',
    label: 'Starter',
    emoji: '🚀',
    icon: FontAwesomeIcons.rocket,
    accentColor: const Color(0xFFFFD700),
    services: [
      ServiceModel(
        title: 'Landing Page Sederhana',
        description:
            'Website satu halaman profesional: profil bisnis, portofolio personal, atau landing page promosi.',
        icon: FontAwesomeIcons.computer,
        basePrice: 150000,
      ),
      ServiceModel(
        title: 'Desain Presentasi Bisnis',
        description:
            'Slide deck profesional untuk pitch bisnis, proposal klien, atau company profile yang menarik.',
        icon: FontAwesomeIcons.filePowerpoint,
        basePrice: 100000,
      ),
      ServiceModel(
        title: 'Flowchart & Dokumentasi Teknis',
        description:
            'Diagram alur proses bisnis, SOP digital, dan dokumentasi teknis untuk kebutuhan internal perusahaan.',
        icon: FontAwesomeIcons.diagramProject,
        basePrice: 120000,
      ),
    ],
  ),
  EducationLevel(
    id: 'smp',
    label: 'Basic',
    emoji: '⚡',
    icon: FontAwesomeIcons.bolt,
    accentColor: const Color(0xFF2DD4BF),
    services: [
      ServiceModel(
        title: 'Otomatisasi Dokumen Office',
        description:
            'Pembuatan template Word, Excel, dan PowerPoint otomatis dengan macro untuk efisiensi kerja.',
        icon: FontAwesomeIcons.fileWord,
        basePrice: 200000,
      ),
      ServiceModel(
        title: 'Website Company Profile',
        description:
            'Website bisnis modern dengan HTML/CSS/JS: profil perusahaan, produk, dan form kontak.',
        icon: FontAwesomeIcons.html5,
        basePrice: 300000,
      ),
      ServiceModel(
        title: 'Mini Game / Aplikasi Interaktif',
        description:
            'Aplikasi interaktif ringan untuk keperluan edukasi, event, atau promosi brand bisnis Anda.',
        icon: FontAwesomeIcons.puzzlePiece,
        basePrice: 250000,
      ),
    ],
  ),
  EducationLevel(
    id: 'smk',
    label: 'Pro',
    emoji: '💎',
    icon: FontAwesomeIcons.gem,
    accentColor: const Color(0xFF60A5FA),
    services: [
      ServiceModel(
        title: 'Web Development Profesional',
        description:
            'Website dinamis full-featured: toko online, sistem manajemen konten, atau portal bisnis.',
        icon: FontAwesomeIcons.globe,
        basePrice: 750000,
      ),
      ServiceModel(
        title: 'Desain & Migrasi Database',
        description:
            'Perancangan ERD, normalisasi, query SQL optimal, dan migrasi data untuk sistem bisnis.',
        icon: FontAwesomeIcons.database,
        basePrice: 400000,
      ),
      ServiceModel(
        title: 'Konfigurasi Infrastruktur IT',
        description:
            'Setup jaringan kantor, konfigurasi server, subnetting, routing, dan dokumentasi infrastruktur.',
        icon: FontAwesomeIcons.networkWired,
        basePrice: 500000,
      ),
      ServiceModel(
        title: 'Analisis & Arsitektur Sistem',
        description:
            'UML diagram, use case, DFD, flowchart, dan dokumen spesifikasi kebutuhan perangkat lunak.',
        icon: FontAwesomeIcons.sitemap,
        basePrice: 350000,
      ),
      ServiceModel(
        title: 'Aplikasi Desktop Bisnis',
        description:
            'Sistem manajemen internal berbasis desktop: inventory, kasir, absensi, dengan Java, C++, atau Python.',
        icon: FontAwesomeIcons.desktop,
        basePrice: 800000,
      ),
    ],
  ),
  EducationLevel(
    id: 'kuliah',
    label: 'Enterprise',
    emoji: '🏆',
    icon: FontAwesomeIcons.buildingColumns,
    accentColor: const Color(0xFF818CF8),
    services: [
      ServiceModel(
        title: 'Algoritma & Optimasi Sistem',
        description:
            'Implementasi algoritma efisien, optimasi performa, dan analisis kompleksitas untuk sistem skala besar.',
        icon: FontAwesomeIcons.codeBranch,
        basePrice: 500000,
      ),
      ServiceModel(
        title: 'Web App Fullstack',
        description:
            'Aplikasi web end-to-end: React, Vue, Next.js, Laravel, Node.js — siap produksi & deploy.',
        icon: FontAwesomeIcons.layerGroup,
        basePrice: 2000000,
      ),
      ServiceModel(
        title: 'Mobile App (Flutter)',
        description:
            'Aplikasi Android/iOS siap publish: state management, REST API, notifikasi push, dan Play Store release.',
        icon: FontAwesomeIcons.mobileScreen,
        basePrice: 3000000,
      ),
      ServiceModel(
        title: 'Data Science & Machine Learning',
        description:
            'Pipeline data end-to-end: Python, Pandas, Scikit-learn, TensorFlow — analisis & model prediktif.',
        icon: FontAwesomeIcons.brain,
        basePrice: 1500000,
      ),
      ServiceModel(
        title: 'Sistem Informasi Perusahaan',
        description:
            'Pengembangan sistem ERP, HRMS, atau CRM skala enterprise dengan dokumentasi teknis lengkap.',
        icon: FontAwesomeIcons.buildingColumns,
        basePrice: 5000000,
      ),
      ServiceModel(
        title: 'Bug Fixing & Code Review',
        description:
            'Audit kode, perbaikan bug kritis, refactoring, dan code review standar industri untuk proyek Anda.',
        icon: FontAwesomeIcons.bug,
        basePrice: 300000,
      ),
    ],
  ),
];
