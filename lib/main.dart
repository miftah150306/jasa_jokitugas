import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

// Internal Imports
import 'controllers/dashboard_provider.dart';
import 'pages/status_checker_page.dart';
import 'pages/review_page.dart';

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
    return MaterialApp(
      title: 'JokiPro Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF6366F1),
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        textTheme: GoogleFonts.outfitTextTheme(ThemeData.dark().textTheme),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF6366F1),
          secondary: Color(0xFFEC4899),
          surface: Color(0xFF1E293B),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white.withOpacity(0.05),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF6366F1))),
        ),
      ),
      home: const DashboardLayout(),
    );
  }
}

const String waNumber = "6287865307837";

Future<void> launchWA(String message) async {
  final url = Uri.parse("https://wa.me/$waNumber?text=${Uri.encodeComponent(message)}");
  if (!await launchUrl(url)) {
    debugPrint("Error launching WA: $url");
  }
}

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
      const ReviewPage(),
      const ContactPage(),
    ];

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isMobile = constraints.maxWidth < 900;
          
          return Row(
            children: [
              if (!isMobile) Sidebar(provider: provider),
              Expanded(
                child: Container(
                  color: const Color(0xFF0F172A),
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
      drawer: LayoutBuilder(builder: (context, constraints) {
        if (constraints.maxWidth < 900) {
          return Drawer(child: Sidebar(provider: provider));
        }
        return const SizedBox();
      }),
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
      decoration: const BoxDecoration(
        color: Color(0xFF1E293B),
        border: Border(right: BorderSide(color: Colors.white10)),
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
                    gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFFEC4899)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(FontAwesomeIcons.code, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 12),
                Text("JokiPro", style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _navItem(0, FontAwesomeIcons.chartPie, "Dashboard"),
          _navItem(1, FontAwesomeIcons.laptopCode, "Layanan"),
          _navItem(2, FontAwesomeIcons.calculator, "Cek Harga"),
          _navItem(3, FontAwesomeIcons.magnifyingGlassChart, "Cek Progres"),
          _navItem(4, FontAwesomeIcons.folderOpen, "Portofolio"),
          _navItem(5, FontAwesomeIcons.star, "Beri Ulasan"),
          _navItem(6, FontAwesomeIcons.headset, "Hubungi Kami"),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(24),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(16)),
              child: const Row(
                children: [
                  CircleAvatar(backgroundColor: Colors.purpleAccent, child: Text("A")),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Admin JokiPro", style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Online 24/7", style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
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
      child: ListTile(
        onTap: () => provider.setSelectedIndex(index),
        leading: Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.white54),
        title: Text(title, style: TextStyle(color: isSelected ? Colors.white : Colors.white54, fontSize: 14)),
        selected: isSelected,
        selectedTileColor: const Color(0xFF6366F1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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
            IconButton(icon: const Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
          const Expanded(child: SizedBox()),
          ElevatedButton.icon(
            onPressed: () => launchWA("Halo Admin JokiPro, saya ingin order."),
            icon: const Icon(FontAwesomeIcons.whatsapp, size: 16),
            label: const Text("Pesan Sekarang"),
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF6366F1), padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15)),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [Color(0xFF1E293B), Color(0xFF0F172A)]),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Solusi Coding #1", style: TextStyle(color: Colors.indigoAccent.shade100, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text("Upgrade Tugasmu ke\nLevel Expert", style: GoogleFonts.outfit(fontSize: 32, fontWeight: FontWeight.bold, height: 1.2)),
                      const SizedBox(height: 16),
                      const Text("Pengerjaan super cepat, kode bersih, dan dokumentasi lengkap. Tanpa perlu login, langsung chat admin.", style: TextStyle(color: Colors.white54)),
                    ],
                  ),
                ),
                if (MediaQuery.of(context).size.width > 1200)
                  const Icon(FontAwesomeIcons.laptopCode, size: 100, color: Colors.white10),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              StatCard(icon: FontAwesomeIcons.tasks, value: "1,240+", label: "Tugas Selesai", color: Colors.purpleAccent),
              StatCard(icon: FontAwesomeIcons.users, value: "850+", label: "Klien Puas", color: Colors.blueAccent),
              StatCard(icon: FontAwesomeIcons.star, value: "4.9/5", label: "Rating Klien", color: Colors.orangeAccent),
              StatCard(icon: FontAwesomeIcons.clock, value: "~24 Jam", label: "Pengerjaan", color: Colors.greenAccent),
            ],
          ),
          const SizedBox(height: 32),
          const FAQSection(),
        ],
      ),
    );
  }
}

class StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  const StatCard({super.key, required this.icon, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 20)),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
            ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Pertanyaan Umum (FAQ)", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        _faqItem("Berapa lama waktu pengerjaan?", "Tergantung tingkat kesulitan, biasanya berkisar antara 12-48 jam."),
        _faqItem("Apakah bisa revisi?", "Ya, kami memberikan garansi revisi gratis sampai tugas diterima."),
        _faqItem("Bahas pemrograman apa saja yang dilayani?", "Hampir semua, mulai dari Python, Java, C++, PHP, JavaScript, hingga Dart/Flutter."),
      ],
    );
  }
  Widget _faqItem(String q, String a) {
    return Card(
      color: Colors.white.withOpacity(0.03),
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        title: Text(q, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        children: [Padding(padding: const EdgeInsets.all(16), child: Text(a, style: const TextStyle(color: Colors.white54, fontSize: 13)))]
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(maxCrossAxisExtent: 400, mainAxisSpacing: 20, crossAxisSpacing: 20, childAspectRatio: 1.3),
      itemCount: provider.services.length,
      itemBuilder: (context, index) {
        final s = provider.services[index];
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: const Color(0xFF1E293B), borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.white10)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(s.icon, color: const Color(0xFF6366F1), size: 32),
              const SizedBox(height: 16),
              Text(s.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(s.description, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white54, fontSize: 12)),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: () => launchWA("Halo, saya mau joki ${s.title}"), child: const Text("Konsultasi")),
            ],
          ),
        );
      },
    );
  }
}

class CalculatorPage extends StatelessWidget {
  const CalculatorPage({super.key});
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              children: [
                DropdownButtonFormField<String>(
                  value: provider.selectedTaskType,
                  decoration: const InputDecoration(labelText: "Jenis Tugas"),
                  items: ["Pemrograman Dasar", "Web Statis", "Web Dinamis", "Mobile App", "Data Science"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (v) => provider.updateCalculator(type: v),
                ),
                const SizedBox(height: 20),
                const Text("Deadline (Hari)"),
                Slider(value: provider.deadline, min: 1, max: 14, onChanged: (v) => provider.updateCalculator(dl: v)),
                Text("${provider.deadline.toInt()} Hari", style: const TextStyle(color: Color(0xFF6366F1))),
              ],
            ),
          ),
          const SizedBox(width: 40),
          Container(
            width: 300,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.03), borderRadius: BorderRadius.circular(24)),
            child: Column(
              children: [
                const Text("Estimasi Biaya:"),
                Text("Rp ${provider.formattedPrice}", style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF6366F1))),
                const SizedBox(height: 32),
                ElevatedButton(onPressed: () => launchWA("Estimasi saya: Rp ${provider.formattedPrice}"), child: const Text("Hubungi Admin")),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Portofolio Section (Coming Soon)"));
  }
}

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Contact Section"));
  }
}
