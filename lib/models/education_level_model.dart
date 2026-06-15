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
    label: 'SD',
    emoji: '🎒',
    icon: FontAwesomeIcons.school,
    accentColor: const Color(0xFFFFD700),
    services: [
      ServiceModel(
        title: 'Pengenalan Komputer & Internet',
        description:
            'Tugas dasar komputer, mengenal perangkat keras & lunak, dan cara berinternet dengan aman.',
        icon: FontAwesomeIcons.computer,
        basePrice: 25000,
      ),
      ServiceModel(
        title: 'Membuat Presentasi',
        description:
            'Desain slide PowerPoint yang menarik dan informatif sesuai materi pelajaran SD.',
        icon: FontAwesomeIcons.filePowerpoint,
        basePrice: 30000,
      ),
      ServiceModel(
        title: 'Logika Dasar & Algoritma Sederhana',
        description:
            'Pengenalan logika berpikir, urutan langkah penyelesaian masalah, dan flowchart.',
        icon: FontAwesomeIcons.diagramProject,
        basePrice: 35000,
      ),
    ],
  ),
  EducationLevel(
    id: 'smp',
    label: 'SMP',
    emoji: '📘',
    icon: FontAwesomeIcons.bookOpen,
    accentColor: const Color(0xFF2DD4BF),
    services: [
      ServiceModel(
        title: 'Tugas TIK (Word, Excel, PowerPoint)',
        description:
            'Pengerjaan tugas Microsoft Office: dokumen, tabel data, dan presentasi sekolah.',
        icon: FontAwesomeIcons.fileWord,
        basePrice: 40000,
      ),
      ServiceModel(
        title: 'HTML & CSS Dasar',
        description:
            'Membuat halaman web sederhana menggunakan HTML dan styling CSS sesuai kurikulum.',
        icon: FontAwesomeIcons.html5,
        basePrice: 50000,
      ),
      ServiceModel(
        title: 'Scratch / Coding Visual Dasar',
        description:
            'Proyek Scratch, pembuatan game atau animasi sederhana berbasis blok kode visual.',
        icon: FontAwesomeIcons.puzzlePiece,
        basePrice: 45000,
      ),
    ],
  ),
  EducationLevel(
    id: 'smk',
    label: 'SMK',
    emoji: '🖥️',
    icon: FontAwesomeIcons.laptop,
    accentColor: const Color(0xFF60A5FA),
    services: [
      ServiceModel(
        title: 'Web Development',
        description:
            'HTML, CSS, JavaScript, PHP & MySQL. Proyek web statis maupun dinamis.',
        icon: FontAwesomeIcons.globe,
        basePrice: 150000,
      ),
      ServiceModel(
        title: 'Basis Data & MySQL',
        description:
            'ERD, normalisasi, query SQL, stored procedure, dan desain database relasional.',
        icon: FontAwesomeIcons.database,
        basePrice: 100000,
      ),
      ServiceModel(
        title: 'Jaringan Komputer',
        description:
            'Konfigurasi Cisco Packet Tracer, subnetting, routing, dan laporan praktikum jaringan.',
        icon: FontAwesomeIcons.networkWired,
        basePrice: 120000,
      ),
      ServiceModel(
        title: 'Rekayasa Perangkat Lunak (RPL)',
        description:
            'UML diagram, use case, DFD, flowchart, dan dokumentasi proyek RPL.',
        icon: FontAwesomeIcons.sitemap,
        basePrice: 130000,
      ),
      ServiceModel(
        title: 'Pemrograman Desktop',
        description:
            'Aplikasi GUI menggunakan Java (NetBeans), C++, atau Python Tkinter.',
        icon: FontAwesomeIcons.desktop,
        basePrice: 200000,
      ),
    ],
  ),
  EducationLevel(
    id: 'kuliah',
    label: 'Kuliah',
    emoji: '🎓',
    icon: FontAwesomeIcons.graduationCap,
    accentColor: const Color(0xFF818CF8),
    services: [
      ServiceModel(
        title: 'Algoritma & Struktur Data',
        description:
            'Sorting, searching, linked list, tree, graph, dan analisis kompleksitas.',
        icon: FontAwesomeIcons.codeBranch,
        basePrice: 100000,
      ),
      ServiceModel(
        title: 'Web Fullstack',
        description:
            'React, Vue, Next.js, Laravel, Node.js — end-to-end web application development.',
        icon: FontAwesomeIcons.layerGroup,
        basePrice: 500000,
      ),
      ServiceModel(
        title: 'Mobile App (Flutter)',
        description:
            'Aplikasi Android/iOS dengan Flutter, state management, dan integrasi API.',
        icon: FontAwesomeIcons.mobileScreen,
        basePrice: 750000,
      ),
      ServiceModel(
        title: 'Data Science & Machine Learning',
        description:
            'Python, Pandas, Scikit-learn, TensorFlow — analisis data dan model ML.',
        icon: FontAwesomeIcons.brain,
        basePrice: 400000,
      ),
      ServiceModel(
        title: 'Skripsi / Tugas Akhir',
        description:
            'Bab 1–5, jurnal, implementasi sistem, dan dokumentasi lengkap berbasis IT.',
        icon: FontAwesomeIcons.bookBookmark,
        basePrice: 1500000,
      ),
      ServiceModel(
        title: 'Bug Fixing & Code Review',
        description:
            'Analisis dan perbaikan error, optimasi kode, serta code review profesional.',
        icon: FontAwesomeIcons.bug,
        basePrice: 75000,
      ),
    ],
  ),
];
