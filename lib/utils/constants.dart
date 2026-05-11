import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const String waNumber = "6285829618913";

Future<void> launchWA(String message) async {
  final url = Uri.parse(
    "https://wa.me/$waNumber?text=${Uri.encodeComponent(message)}",
  );
  if (!await launchUrl(url)) {
    debugPrint("Error launching WA: $url");
  }
}

class AppColors {
  static const Color background = Color(0xFF0F172A);
  static const Color sidebar = Color(0xFF1E293B);
  static const Color primary = Color(0xFF6366F1);
  static const Color secondary = Color(0xFFEC4899);
}
