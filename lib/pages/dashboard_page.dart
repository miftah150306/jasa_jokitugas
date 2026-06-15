import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';

// Internal Imports
import '../controllers/dashboard_provider.dart';
import '../models/education_level_model.dart';
import '../widgets/role_selector_widget.dart';
import '../widgets/service_card_widget.dart';
import 'status_checker_page.dart';
import '../widgets/settings_dialog.dart';
import '../widgets/add_comment_dialog.dart';
import '../utils/constants.dart';

class DashboardLayout extends StatelessWidget {
  const DashboardLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    final List<Widget> pages = [
      const DashboardHomePage(),
      const ServicesPage(),
      const CalculatorPage(),
      const StatusCheckerPage(),
      const PortfolioPage(),
      const ContactPage(),
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;

          return Row(
            children: [
              if (!isMobile) Sidebar(provider: provider),
              Expanded(
                child: Container(
                  color: provider.bgColor,
                  child: Column(
                    children: [
                      TopHeader(isMobile: isMobile, provider: provider),
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: pages[provider.selectedIndex],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
      drawer: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 900) {
            return Drawer(child: Sidebar(provider: provider));
          }
          return const SizedBox();
        },
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          final isMobile = constraints.maxWidth < 900;
          if (!isMobile) return const SizedBox.shrink();

          return SafeArea(
            top: false,
            child: BottomNavigationBar(
              backgroundColor: provider.cardColor,
              selectedItemColor: provider.primaryColor,
              unselectedItemColor: provider.textMuted,
              type: BottomNavigationBarType.fixed,
              currentIndex: provider.selectedIndex.clamp(0, 3),
              onTap: (i) {
                final target = [0, 1, 2, 3][i];
                provider.setSelectedIndex(target);
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.chartPie),
                  label: 'Dashboard',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.laptopCode),
                  label: 'Layanan',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.calculator),
                  label: 'Cek Harga',
                ),
                BottomNavigationBarItem(
                  icon: Icon(FontAwesomeIcons.userGear),
                  label: 'Developer',
                ),
              ],
              selectedFontSize: 12,
              unselectedFontSize: 12,
            ),
          );
        },
      ),
    );
  }
}

class Sidebar extends StatelessWidget {
  final DashboardProvider provider;
  const Sidebar({super.key, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      decoration: BoxDecoration(
        color: provider.cardColor,
        border: Border(right: BorderSide(color: provider.borderColor)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [provider.primaryColor, provider.secondaryColor],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    FontAwesomeIcons.code,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  "JokiPro",
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: provider.textColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _navItem(0, FontAwesomeIcons.chartPie, "Dashboard"),
          _navItem(1, FontAwesomeIcons.laptopCode, "Layanan"),
          _navItem(2, FontAwesomeIcons.calculator, "Cek Harga"),
          _navItem(3, FontAwesomeIcons.userGear, "Developer"),
          _navItem(4, FontAwesomeIcons.folderOpen, "Portofolio"),
          _navItem(5, FontAwesomeIcons.headset, "Hubungi Kami"),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    provider.primaryColor.withOpacity(0.12),
                    provider.secondaryColor.withOpacity(0.08),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: provider.primaryColor.withOpacity(0.2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [provider.primaryColor, provider.secondaryColor],
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(FontAwesomeIcons.userGear, color: Colors.white, size: 14),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Miftah Dev",
                            style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          const Text(
                            "Flutter Developer",
                            style: TextStyle(color: Colors.white38, fontSize: 11),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.white10, height: 1),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(FontAwesomeIcons.code, size: 11, color: provider.primaryColor),
                      const SizedBox(width: 6),
                      Text(
                        "JokiPro v1.3",
                        style: TextStyle(
                          color: provider.primaryColor.withOpacity(0.8),
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        width: 7, height: 7,
                        decoration: const BoxDecoration(
                          color: Colors.greenAccent,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Text("Live", style: TextStyle(color: Colors.greenAccent, fontSize: 10)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(int index, IconData icon, String title) {
    bool isSelected = provider.selectedIndex == index;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: isSelected ? 8.0 : 0.0, sigmaY: isSelected ? 8.0 : 0.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => provider.setSelectedIndex(index),
              borderRadius: BorderRadius.circular(12),
              splashColor: provider.primaryColor.withOpacity(0.3),
              highlightColor: provider.primaryColor.withOpacity(0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: isSelected 
                      ? provider.primaryColor.withOpacity(provider.isDarkMode ? 0.15 : 0.08) 
                      : Colors.transparent,
                  border: Border.all(
                    color: isSelected 
                        ? provider.primaryColor.withOpacity(0.4) 
                        : Colors.transparent,
                    width: 1,
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: provider.primaryColor.withOpacity(0.15),
                            blurRadius: 12,
                            spreadRadius: 1,
                          )
                        ]
                      : [],
                ),
                child: ListTile(
                  leading: Icon(
                    icon,
                    size: 18,
                    color: isSelected ? provider.primaryColor : provider.textMuted,
                  ),
                  title: Text(
                    title,
                    style: TextStyle(
                      color: isSelected ? provider.primaryColor : provider.textMuted,
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TopHeader extends StatelessWidget {
  final bool isMobile;
  final DashboardProvider provider;
  const TopHeader({super.key, required this.isMobile, required this.provider});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          if (isMobile)
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          const Expanded(child: SizedBox()),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (_) => const SettingsDialog(),
            ),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: provider.primaryColor,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: provider.primaryColor.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(FontAwesomeIcons.gear, color: Colors.white, size: 20),
            ),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
            begin: const Offset(1.0, 1.0),
            end: const Offset(1.1, 1.1),
            duration: 1.seconds,
            curve: Curves.easeInOut,
          ),
        ],
      ),
    );
  }
}

class DashboardHomePage extends StatelessWidget {
  const DashboardHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final w = MediaQuery.of(context).size.width;
    final isMobile = w < 600;

    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        children: [
          // Hero Banner
          Container(
            padding: EdgeInsets.all(isMobile ? 20 : 32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E1B4B), Color(0xFF1E293B), Color(0xFF0F172A)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: provider.primaryColor.withOpacity(0.3)),
              boxShadow: [
                BoxShadow(color: provider.primaryColor.withOpacity(0.1), blurRadius: 40, offset: const Offset(0, 10)),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: provider.primaryColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(color: provider.primaryColor.withOpacity(0.4)),
                  ),
                  child: Text('✨ Platform Joki Terpercaya #1 Indonesia',
                      style: TextStyle(color: provider.primaryColor, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 16),
                Text(
                  'Upgrade Tugasmu ke\nLevel Expert 🚀',
                  style: GoogleFonts.outfit(fontSize: 34, fontWeight: FontWeight.bold, height: 1.2, color: provider.textColor),
                ),
                const SizedBox(height: 12),
                Text(
                  'Pengerjaan super cepat, kode bersih, dan dokumentasi lengkap.\nTersedia untuk SD, SMP, SMK, hingga Mahasiswa.',
                  style: TextStyle(color: provider.textMuted, fontSize: 14, height: 1.6),
                ),
                const SizedBox(height: 24),
                Wrap(spacing: 12, runSpacing: 12, children: [
                  ElevatedButton.icon(
                    onPressed: () => launchWA('Halo Admin JokiPro! Saya ingin konsultasi 👋'),
                    icon: const Icon(FontAwesomeIcons.whatsapp, size: 16),
                    label: const Text('Konsultasi Gratis'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF25D366), foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () => provider.setSelectedIndex(1),
                    icon: Icon(FontAwesomeIcons.laptopCode, size: 14, color: provider.primaryColor),
                    label: Text('Lihat Layanan', style: TextStyle(color: provider.primaryColor)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: provider.primaryColor),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    ),
                  ),
                ]),
              ],
            ),
          ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.05),
          const SizedBox(height: 28),
          // Stats Grid
          const Wrap(
            spacing: 16, runSpacing: 16,
            children: [
              StatCard(icon: FontAwesomeIcons.checkDouble, value: '1,240+', label: 'Tugas Selesai', color: Colors.purpleAccent),
              StatCard(icon: FontAwesomeIcons.users, value: '850+', label: 'Klien Puas', color: Colors.blueAccent),
              StatCard(icon: FontAwesomeIcons.solidStar, value: '4.9/5', label: 'Rating Klien', color: Colors.orangeAccent),
              StatCard(icon: FontAwesomeIcons.bolt, value: '< 24 Jam', label: 'Pengerjaan', color: Colors.greenAccent),
            ],
          ),
          const SizedBox(height: 28),
          // Testimonials
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Kata Klien Kami 💬', style: GoogleFonts.outfit(fontSize: 20, fontWeight: FontWeight.bold, color: provider.textColor)),
              ElevatedButton.icon(
                onPressed: () => showDialog(context: context, builder: (_) => const AddCommentDialog()),
                icon: const Icon(FontAwesomeIcons.penToSquare, size: 14),
                label: const Text('Tulis Ulasan'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: provider.primaryColor.withOpacity(0.15),
                  foregroundColor: provider.primaryColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const _TestimonialRow(),
          const SizedBox(height: 28),
          const FAQSection(),
        ],
      ),
    );
  }
}

class _TestimonialRow extends StatelessWidget {
  const _TestimonialRow();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final comments = provider.comments;

    if (comments.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: provider.cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: provider.borderColor),
        ),
        child: Center(
          child: Text(
            'Belum ada ulasan. Jadilah yang pertama!',
            style: TextStyle(color: provider.textMuted),
          ),
        ),
      );
    }

    return LayoutBuilder(builder: (context, c) {
      final cols = c.maxWidth > 900 ? 3 : c.maxWidth > 600 ? 2 : 1;
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols, mainAxisSpacing: 14, crossAxisSpacing: 14, childAspectRatio: 2.2,
        ),
        itemCount: comments.length,
        itemBuilder: (context, i) {
          final cmt = comments[i];
          return Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: provider.cardColor,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: provider.borderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(children: List.generate(cmt.rating,
                    (_) => const Icon(FontAwesomeIcons.solidStar, color: Colors.orangeAccent, size: 13))),
                const SizedBox(height: 10),
                Expanded(child: Text(cmt.text,
                    style: TextStyle(color: provider.textColor.withOpacity(0.8), fontSize: 12, height: 1.5),
                    overflow: TextOverflow.ellipsis, maxLines: 3)),
                const SizedBox(height: 10),
                Row(children: [
                  CircleAvatar(radius: 12, backgroundColor: provider.primaryColor,
                      child: const Icon(Icons.person, size: 12, color: Colors.white)),
                  const SizedBox(width: 8),
                  Text(cmt.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: provider.textColor)),
                  const SizedBox(width: 6),
                  Text('· ${cmt.level}', style: TextStyle(color: provider.textMuted, fontSize: 11)),
                ]),
              ],
            ),
          ).animate().fadeIn(delay: (i * 100).ms);
        },
      );
    });
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final w = MediaQuery.of(context).size.width;
    final cardW = w < 500 ? (w - 48) / 2 : 220.0;
    
    return Container(
      width: cardW,
      padding: EdgeInsets.all(w < 500 ? 12 : 20),
      decoration: BoxDecoration(
        color: provider.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: provider.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: provider.textColor,
                    ),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    label,
                    style: TextStyle(color: provider.textMuted, fontSize: 11),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FAQSection extends StatelessWidget {
  const FAQSection({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pertanyaan Umum (FAQ)",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: provider.textColor),
        ),
        const SizedBox(height: 16),
        _faqItem(
          "Berapa lama waktu pengerjaan tugas atau project?",
          "Waktu pengerjaan sangat bergantung pada tingkat kesulitan dan lingkup (scope) dari project tersebut. Untuk tugas sederhana, biasanya selesai dalam 12-24 jam. Untuk project skala menengah seperti website atau aplikasi mobile, memakan waktu 3-7 hari. Kami juga melayani sistem prioritas jika deadline Anda sangat ketat.",
          provider,
        ),
        _faqItem(
          "Bagaimana sistem pembayaran di JokiPro?",
          "Pembayaran dapat dilakukan setelah kesepakatan harga. Kami menerapkan sistem DP (Down Payment) sebesar 50% di awal sebagai tanda jadi, dan sisa 50% dibayarkan setelah project selesai didemokan atau kode/file siap dikirim ke Anda. Pembayaran bisa via Transfer Bank, e-Wallet (Gopay, OVO, Dana, ShopeePay), maupun QRIS.",
          provider,
        ),
        _faqItem(
          "Apakah ada garansi jika program error atau ada revisi?",
          "Tentu! Kami memberikan garansi revisi gratis selama 7-14 hari setelah project diserahkan (tergantung kesepakatan). Garansi ini mencakup bug fixing, perbaikan error yang tidak terduga, atau sedikit perubahan logika yang masih masuk dalam scope awal. Jika ada penambahan fitur baru di luar kesepakatan, akan dikenakan biaya tambahan.",
          provider,
        ),
        _faqItem(
          "Bahasa pemrograman dan teknologi apa saja yang dikuasai?",
          "Tim kami terdiri dari developer berpengalaman di berbagai tech stack. Kami menangani Python, Java, C++, C#, PHP (Laravel/CodeIgniter), JavaScript/TypeScript (React, Next.js, Node.js, Express), Dart (Flutter), dan pengelolaan Database (MySQL, PostgreSQL, MongoDB, Firebase).",
          provider,
        ),
        _faqItem(
          "Apakah privasi dan kerahasiaan tugas saya aman?",
          "Sangat aman. Kami menjamin 100% kerahasiaan identitas klien dan detail project. Kode yang kami buat tidak akan didistribusikan ulang, dipublikasikan, atau dijual kepada pihak ketiga tanpa izin Anda.",
          provider,
        ),
        _faqItem(
          "Bagaimana jika saya tidak mengerti kodenya? Apakah dijelaskan?",
          "Tentu saja. Anda tidak hanya menerima source code (file jadi), tapi kami juga akan memberikan panduan cara menjalankan (run) program tersebut. Jika Anda butuh penjelasan kodingan baris-per-baris untuk keperluan presentasi/sidang, kami juga melayani jasa sesi konsultasi via Zoom/Google Meet (dengan biaya tambahan khusus mentoring).",
          provider,
        ),
        _faqItem(
          "Apakah menerima joki untuk ujian atau live coding?",
          "Mohon maaf, JokiPro berfokus pada pembuatan project, tugas akhir, skripsi, dan bug fixing. Kami tidak menerima jasa joki untuk ujian tertulis, ujian online, maupun live coding test yang bersifat real-time.",
          provider,
        ),
      ],
    );
  }

  Widget _faqItem(String q, String a, DashboardProvider provider) {
    return Card(
      color: provider.cardColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        title: Text(
          q,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: provider.textColor),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              a,
              style: TextStyle(color: provider.textMuted, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final level = provider.selectedLevel;
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [level.accentColor.withOpacity(0.15), provider.bgColor],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: level.accentColor.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: level.accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(level.icon, color: level.accentColor, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${level.emoji} Layanan untuk ${level.label}',
                          style: GoogleFonts.outfit(fontSize: 22, fontWeight: FontWeight.bold, color: provider.textColor)),
                      const SizedBox(height: 4),
                      Text('${level.services.length} layanan tersedia · Pilih jenjang lain di bawah',
                          style: TextStyle(color: provider.textMuted, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          // Role Selector
          RoleSelectorWidget(
            selectedLevelId: provider.selectedLevelId,
            onLevelSelected: provider.setSelectedLevel,
          ),
          const SizedBox(height: 28),
          // Service Grid
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            child: LayoutBuilder(
              key: ValueKey(level.id),
              builder: (context, constraints) {
                final crossAxis = constraints.maxWidth > 900 ? 3 : constraints.maxWidth > 600 ? 2 : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxis,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    childAspectRatio: 1.1,
                  ),
                  itemCount: level.services.length,
                  itemBuilder: (context, index) => ServiceCardWidget(
                    service: level.services[index],
                    accentColor: level.accentColor,
                    educationLabel: level.label,
                    animationIndex: index,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: provider.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(FontAwesomeIcons.calculator, color: provider.primaryColor),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Kalkulator Estimasi Biaya',
                    style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold, color: provider.textColor),
                  ),
                  Text(
                    'Hitung perkiraan harga untuk project Anda secara transparan.',
                    style: TextStyle(color: provider.textMuted, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          
          LayoutBuilder(
            builder: (context, constraints) {
              final isNarrow = constraints.maxWidth < 1000;
              final form = _buildForm(provider, context);
              final priceCard = _PriceCard(
                formattedPrice: provider.formattedPrice,
                onSend: () {
                  launchWA("Halo Admin JokiPro 👋\nSaya ingin konsultasi project:\n- Jenis: *${provider.selectedTaskType}*\n- Deadline: *${provider.deadline.toInt()} Hari*\n- Estimasi Harga: *Rp ${provider.formattedPrice}*\n\nMohon info lebih lanjut 🙏");
                },
              );

              if (isNarrow) {
                return Column(
                  children: [form, const SizedBox(height: 32), priceCard],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(flex: 3, child: form),
                  const SizedBox(width: 40),
                  Expanded(flex: 2, child: priceCard),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildForm(DashboardProvider provider, BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      padding: EdgeInsets.all(isMobile ? 16 : 28),
      decoration: BoxDecoration(
        color: provider.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: provider.borderColor),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Jenis Project / Tugas", style: TextStyle(fontWeight: FontWeight.bold, color: provider.textColor, fontSize: 15)),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: provider.bgColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: provider.borderColor),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: provider.selectedTaskType,
                isExpanded: true,
                dropdownColor: provider.cardColor,
                icon: Icon(Icons.keyboard_arrow_down, color: provider.textMuted),
                items: [
                  "Tugas Harian Umum",
                  "Tugas Matematika",
                  "Pembuatan Makalah",
                  "Pembuatan PPT",
                  "Pemrograman Dasar",
                  "Web Statis",
                  "Web Dinamis",
                  "Mobile App",
                  "Data Science",
                ].map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: provider.textColor)))).toList(),
                onChanged: (v) => provider.updateCalculator(type: v),
              ),
            ),
          ),
          const SizedBox(height: 28),
          Text("Tingkat Kesulitan / Skala Project", style: TextStyle(fontWeight: FontWeight.bold, color: provider.textColor, fontSize: 15)),
          const SizedBox(height: 12),
          Row(
            children: [
              _diffBtn("Mudah", 1.0, provider),
              const SizedBox(width: 12),
              _diffBtn("Menengah", 1.5, provider),
              const SizedBox(width: 12),
              _diffBtn("Sulit", 2.0, provider),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "Deadline (Tenggat Waktu)",
                  style: TextStyle(fontWeight: FontWeight.bold, color: provider.textColor, fontSize: 15),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                decoration: BoxDecoration(
                  color: provider.primaryColor.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: provider.primaryColor.withOpacity(0.3)),
                ),
                child: Text(
                  "${provider.deadline.toInt()} Hari",
                  style: TextStyle(color: provider.primaryColor, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SliderTheme(
            data: SliderThemeData(
              activeTrackColor: provider.primaryColor,
              inactiveTrackColor: provider.primaryColor.withOpacity(0.2),
              thumbColor: provider.primaryColor,
              overlayColor: provider.primaryColor.withOpacity(0.2),
              trackHeight: 8,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 10),
            ),
            child: Slider(
              value: provider.deadline,
              min: 1,
              max: 14,
              divisions: 13,
              onChanged: (v) => provider.updateCalculator(dl: v),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("🔥 Express (1 Hari)", style: TextStyle(color: provider.textMuted, fontSize: 12)),
                Text("Santai (14 Hari) ☕", style: TextStyle(color: provider.textMuted, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _diffBtn(String label, double val, DashboardProvider provider) {
    bool isSel = provider.difficulty == val;
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: isSel ? 5.0 : 0.0, sigmaY: isSel ? 5.0 : 0.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => provider.updateCalculator(diff: val),
              borderRadius: BorderRadius.circular(12),
              splashColor: provider.primaryColor.withOpacity(0.3),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSel ? provider.primaryColor.withOpacity(0.15) : provider.bgColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSel ? provider.primaryColor : provider.borderColor,
                    width: isSel ? 1.5 : 1,
                  ),
                ),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSel ? provider.primaryColor : provider.textMuted,
                      fontWeight: isSel ? FontWeight.bold : FontWeight.normal,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PriceCard extends StatelessWidget {
  final String formattedPrice;
  final VoidCallback onSend;

  const _PriceCard({required this.formattedPrice, required this.onSend});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(isMobile ? 20 : 32),
          decoration: BoxDecoration(
            color: provider.cardColor.withOpacity(0.7),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: provider.primaryColor.withOpacity(0.3), width: 1.5),
            boxShadow: [
              BoxShadow(
                color: provider.primaryColor.withOpacity(0.15),
                blurRadius: 30,
                spreadRadius: -5,
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(FontAwesomeIcons.wallet, size: 40, color: provider.primaryColor),
              const SizedBox(height: 24),
              Text("Estimasi Total Biaya", style: TextStyle(color: provider.textMuted, fontSize: 16)),
              const SizedBox(height: 12),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "Rp $formattedPrice",
                  style: GoogleFonts.outfit(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: provider.primaryColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Harga dapat berubah setelah diskusi lebih lanjut mengenai spesifikasi detail.",
                style: TextStyle(color: provider.textMuted, fontSize: 12),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: onSend,
                  icon: const Icon(FontAwesomeIcons.whatsapp, size: 18),
                  label: const Text("Pesan Sekarang", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                    elevation: 5,
                    shadowColor: provider.primaryColor.withOpacity(0.5),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});
  static const _items = [
    {'title': 'Sistem Kasir Flutter', 'tag': 'Mobile App', 'level': 'Kuliah', 'color': 0xFF818CF8, 'icon': 0xf10b},
    {'title': 'Web E-Commerce PHP', 'tag': 'Web Dinamis', 'level': 'SMK', 'color': 0xFF60A5FA, 'icon': 0xf0ac},
    {'title': 'Analisis Data Python', 'tag': 'Data Science', 'level': 'Kuliah', 'color': 0xFF34D399, 'icon': 0xf201},
    {'title': 'Aplikasi Absensi Java', 'tag': 'Desktop App', 'level': 'SMK', 'color': 0xFFFBBF24, 'icon': 0xf108},
    {'title': 'Landing Page React', 'tag': 'Web Statis', 'level': 'Kuliah', 'color': 0xFFF472B6, 'icon': 0xf15c},
    {'title': 'Tugas HTML/CSS SMP', 'tag': 'Web Dasar', 'level': 'SMP', 'color': 0xFF2DD4BF, 'icon': 0xf13b},
  ];
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Portofolio Hasil Kerja', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: provider.textColor)),
          const SizedBox(height: 6),
          Text('Beberapa proyek yang telah berhasil diselesaikan oleh tim JokiPro.', style: TextStyle(color: provider.textMuted)),
          const SizedBox(height: 28),
          LayoutBuilder(builder: (context, c) {
            final cols = c.maxWidth > 900 ? 3 : c.maxWidth > 600 ? 2 : 1;
            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: cols, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: 1.4,
              ),
              itemCount: _items.length,
              itemBuilder: (context, i) {
                final item = _items[i];
                final color = Color(item['color'] as int);
                return Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: provider.cardColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: provider.borderColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
                            child: Icon(FontAwesomeIcons.code, color: color, size: 18)),
                          const Spacer(),
                          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(30)),
                            child: Text(item['level'] as String, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold))),
                        ],
                      ),
                      const Spacer(),
                      Text(item['title'] as String, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: provider.textColor)),
                      const SizedBox(height: 6),
                      Text(item['tag'] as String, style: TextStyle(color: provider.textMuted, fontSize: 12)),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Icon(FontAwesomeIcons.circleCheck, color: Colors.greenAccent, size: 13),
                          const SizedBox(width: 6),
                          const Text('Selesai & Diterima', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ).animate().fadeIn(delay: (i * 80).ms).slideY(begin: 0.1, end: 0, delay: (i * 80).ms);
              },
            );
          }),
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton.icon(
              onPressed: () => launchWA('Halo Admin JokiPro, saya ingin melihat lebih banyak portofolio 🙏'),
              icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white),
              label: const Text('Minta Portofolio Lengkap'),
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF25D366), foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14)),
            ),
          ),
        ],
      ),
    );
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final isMobile = MediaQuery.of(context).size.width < 600;
    return SingleChildScrollView(
      padding: EdgeInsets.all(isMobile ? 16 : 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Hubungi Kami', style: GoogleFonts.outfit(fontSize: 28, fontWeight: FontWeight.bold, color: provider.textColor)),
          const SizedBox(height: 6),
          Text('Tim kami siap membantu 24/7. Pilih metode kontak yang paling nyaman.', style: TextStyle(color: provider.textMuted)),
          const SizedBox(height: 28),
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 680),
              child: Column(
                children: [
                  _ContactCard(
                    icon: FontAwesomeIcons.whatsapp,
                    color: const Color(0xFF25D366),
                    title: 'WhatsApp (Utama)',
                    subtitle: '+62 858-2961-8913 · Respon < 5 menit',
                    buttonText: 'Mulai Chat',
                    onTap: () => launchWA('Halo Admin JokiPro! 👋 Saya ingin konsultasi mengenai layanan joki tugas.'),
                  ),
                  const SizedBox(height: 16),
                  _ContactCard(
                    icon: FontAwesomeIcons.instagram,
                    color: const Color(0xFFE1306C),
                    title: 'Instagram',
                    subtitle: '@jokipro.id · DM untuk konsultasi',
                    buttonText: 'Buka Instagram',
                    onTap: () => launchWA('Halo, saya dari Instagram'),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: provider.cardColor,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: provider.borderColor),
                    ),
                    child: Column(
                      children: [
                        Text('Jam Operasional', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: provider.textColor)),
                        const SizedBox(height: 16),
                        _TimeRow('Senin – Jumat', '08.00 – 23.00 WIB', provider),
                        _TimeRow('Sabtu – Minggu', '09.00 – 21.00 WIB', provider),
                        _TimeRow('Deadline Urgent', '24 Jam (hubungi WA)', provider),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _TimeRow(String label, String value, DashboardProvider provider) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(color: provider.textMuted, fontSize: 13)),
        Text(value, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13, color: provider.textColor)),
      ],
    ),
  );
}

class _ContactCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title, subtitle, buttonText;
  final VoidCallback onTap;
  const _ContactCard({required this.icon, required this.color, required this.title, required this.subtitle, required this.buttonText, required this.onTap});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: provider.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: provider.borderColor),
      ),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(14)),
            child: Icon(icon, color: color, size: 24)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: provider.textColor)),
                const SizedBox(height: 4),
                Text(subtitle, style: TextStyle(color: provider.textMuted, fontSize: 12)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(backgroundColor: color, foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            child: Text(buttonText, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
