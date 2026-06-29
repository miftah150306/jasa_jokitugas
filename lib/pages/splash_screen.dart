import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:async';
import 'dart:math' as math;

// Internal Imports
import 'dashboard_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.of(context).pushReplacement(
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const DashboardLayout(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
            transitionDuration: const Duration(milliseconds: 1000),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF6366F1).withOpacity(0.08),
              ),
            ).animate().scale(duration: 2.seconds, curve: Curves.easeOut),
          ),
          Positioned(
            bottom: -150,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFFEC4899).withOpacity(0.08),
              ),
            ).animate().scale(duration: 2.seconds, curve: Curves.easeOut),
          ),

          // Flying Documents Layer
          ...List.generate(30, (index) => _FlyingDocument(index: index)),

          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 350,
                  height: 350,
                  child: Lottie.network(
                    'https://assets3.lottiefiles.com/packages/lf20_sk5h17nd.json',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        FontAwesomeIcons.laptopCode,
                        size: 100,
                        color: Colors.white24,
                      );
                    },
                  ),
                ).animate().fadeIn(duration: 800.ms).scale(
                      begin: const Offset(0.8, 0.8),
                      curve: Curves.easeOutBack,
                    ),
                const SizedBox(height: 20),
                Text(
                  "DevConnect",
                  style: GoogleFonts.outfit(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2),
                const SizedBox(height: 8),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                  ).createShader(bounds),
                  child: Text(
                    "FREELANCE IT SERVICES",
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ).animate().fadeIn(delay: 800.ms),
                const SizedBox(height: 40),
                const SizedBox(
                  width: 150,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white10,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF6366F1)),
                  ),
                ).animate().fadeIn(delay: 1200.ms),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FlyingDocument extends StatelessWidget {
  final int index;
  const _FlyingDocument({required this.index});

  @override
  Widget build(BuildContext context) {
    final random = math.Random(index);
    final startX = (random.nextDouble() * 600) - 300;
    final startY = -600.0 - (random.nextDouble() * 400);

    final startPos = Offset(startX, startY);
    final endPos = Offset(
      (random.nextDouble() * 40) - 20,
      (random.nextDouble() * 80) - 200,
    );

    return Center(
      child: Icon(
        random.nextBool() ? FontAwesomeIcons.fileLines : FontAwesomeIcons.fileCode,
        color: Colors.white.withOpacity(0.4),
        size: 18 + random.nextDouble() * 10,
      )
          .animate(onPlay: (controller) => controller.repeat())
          .move(
            begin: startPos,
            end: endPos,
            duration: (1000 + random.nextInt(1500)).ms,
            curve: Curves.easeInSine,
            delay: (random.nextInt(3000)).ms,
          )
          .rotate(begin: 0, end: random.nextDouble() * 8, duration: 2.seconds)
          .fadeOut(begin: 0.7)
          .scale(begin: const Offset(1.0, 1.0), end: Offset.zero),
    );
  }
}
