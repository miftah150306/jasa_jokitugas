import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controllers/dashboard_provider.dart';
import '../utils/constants.dart';

class SettingsDialog extends StatelessWidget {
  const SettingsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 450),
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: provider.cardColor,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: provider.borderColor),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: provider.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(FontAwesomeIcons.gear, color: provider.primaryColor, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pengaturan',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: provider.textColor,
                        ),
                      ),
                      Text(
                        'Sesuaikan preferensi tampilanmu',
                        style: TextStyle(color: provider.textMuted, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close, color: provider.textMuted),
                ),
              ],
            ),
            const SizedBox(height: 32),
            
            // Dark Mode Toggle
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: provider.bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: provider.borderColor),
              ),
              child: Row(
                children: [
                  Icon(
                    provider.isDarkMode ? FontAwesomeIcons.moon : FontAwesomeIcons.sun,
                    color: provider.isDarkMode ? Colors.indigoAccent : Colors.orangeAccent,
                    size: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Tema Gelap',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: provider.textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Ubah ke tampilan ${provider.isDarkMode ? 'terang' : 'gelap'}',
                          style: TextStyle(color: provider.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: provider.isDarkMode,
                    onChanged: (val) => provider.toggleTheme(),
                    activeColor: provider.primaryColor,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1),
            
            const SizedBox(height: 20),

            // Notification Toggle (Mock)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: provider.bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: provider.borderColor),
              ),
              child: Row(
                children: [
                  const Icon(FontAwesomeIcons.bell, color: Colors.blueAccent, size: 24),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Notifikasi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: provider.textColor,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Terima info diskon & promo',
                          style: TextStyle(color: provider.textMuted, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Switch.adaptive(
                    value: true,
                    onChanged: (val) {},
                    activeColor: provider.primaryColor,
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1),

            const SizedBox(height: 20),

            // Color Theme Picker
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: provider.bgColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: provider.borderColor),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.palette, color: provider.primaryColor, size: 20),
                      const SizedBox(width: 12),
                      Text(
                        'Warna Aksen',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: provider.textColor,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      _ColorCircle(color: const Color(0xFF6366F1), secondary: const Color(0xFFEC4899), provider: provider), // Indigo
                      _ColorCircle(color: const Color(0xFFEF4444), secondary: const Color(0xFFF59E0B), provider: provider), // Red
                      _ColorCircle(color: const Color(0xFF10B981), secondary: const Color(0xFF3B82F6), provider: provider), // Green
                      _ColorCircle(color: const Color(0xFF8B5CF6), secondary: const Color(0xFFEC4899), provider: provider), // Purple
                      _ColorCircle(color: const Color(0xFF0EA5E9), secondary: const Color(0xFF3B82F6), provider: provider), // Light Blue
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn(delay: 250.ms).slideY(begin: 0.1),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: provider.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                child: const Text('Simpan & Tutup', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              ),
            ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 200.ms).scale(begin: const Offset(0.95, 0.95));
  }
}

class _ColorCircle extends StatelessWidget {
  final Color color;
  final Color secondary;
  final DashboardProvider provider;

  const _ColorCircle({required this.color, required this.secondary, required this.provider});

  @override
  Widget build(BuildContext context) {
    final isSelected = provider.primaryColor.value == color.value;
    return GestureDetector(
      onTap: () => provider.updateThemeColor(color, secondary),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: isSelected ? provider.textColor : Colors.transparent,
            width: 3,
          ),
          boxShadow: isSelected
              ? [BoxShadow(color: color.withOpacity(0.4), blurRadius: 10, offset: const Offset(0, 4))]
              : [],
        ),
        child: isSelected
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : null,
      ),
    );
  }
}
