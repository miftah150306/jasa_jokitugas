import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// Internal Imports
import 'controllers/dashboard_provider.dart';
import 'pages/splash_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => DashboardProvider(),
      child: const JokiProApp(),
    ),
  );
}

class JokiProApp extends StatelessWidget {
  const JokiProApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    
    return MaterialApp(
      title: 'JokiPro Dashboard',
      debugShowCheckedModeBanner: false,
      themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: provider.primaryColor,
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.light().textTheme),
        colorScheme: ColorScheme.light(
          primary: provider.primaryColor,
          secondary: provider.secondaryColor,
          surface: Colors.white,
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: provider.primaryColor,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        colorScheme: ColorScheme.dark(
          primary: provider.primaryColor,
          secondary: provider.secondaryColor,
          surface: const Color(0xFF1E293B),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}
