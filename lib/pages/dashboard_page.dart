import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_animate/flutter_animate.dart';

// Internal Imports
import '../controllers/dashboard_provider.dart';
import 'status_checker_page.dart';
import 'review_page.dart';
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
      const ReviewPage(),
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
                  color: AppColors.background,
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
              backgroundColor: AppColors.sidebar,
              selectedItemColor: AppColors.primary,
              unselectedItemColor: Colors.white54,
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
                  icon: Icon(FontAwesomeIcons.magnifyingGlassChart),
                  label: 'Cek Progres',
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
      decoration: const BoxDecoration(
        color: AppColors.sidebar,
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
                    gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.secondary],
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
                  ),
                ),
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
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.03),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.purpleAccent,
                    child: Text("A"),
                  ),
                  SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Admin JokiPro",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Online 24/7",
                        style: TextStyle(
                          color: Colors.greenAccent,
                          fontSize: 12,
                        ),
                      ),
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
        leading: Icon(
          icon,
          size: 18,
          color: isSelected ? Colors.white : Colors.white54,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.white54,
            fontSize: 14,
          ),
        ),
        selected: isSelected,
        selectedTileColor: AppColors.primary,
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
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          const Expanded(child: SizedBox()),
          IconButton(
            onPressed: () => launchWA("Halo Admin JokiPro, saya ingin konsultasi."),
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: const BoxDecoration(
                color: Color(0xFF25D366),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 24),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.sidebar, AppColors.background],
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Solusi Coding #1",
                        style: TextStyle(
                          color: Colors.indigoAccent.shade100,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Upgrade Tugasmu ke\nLevel Expert",
                        style: GoogleFonts.outfit(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        "Pengerjaan super cepat, kode bersih, dan dokumentasi lengkap. Tanpa perlu login, langsung chat admin.",
                        style: TextStyle(color: Colors.white54),
                      ),
                    ],
                  ),
                ),
                if (MediaQuery.of(context).size.width > 1200)
                  const Icon(
                    FontAwesomeIcons.laptopCode,
                    size: 100,
                    color: Colors.white10,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              StatCard(
                icon: FontAwesomeIcons.tasks,
                value: "1,240+",
                label: "Tugas Selesai",
                color: Colors.purpleAccent,
              ),
              StatCard(
                icon: FontAwesomeIcons.users,
                value: "850+",
                label: "Klien Puas",
                color: Colors.blueAccent,
              ),
              StatCard(
                icon: FontAwesomeIcons.star,
                value: "4.9/5",
                label: "Rating Klien",
                color: Colors.orangeAccent,
              ),
              StatCard(
                icon: FontAwesomeIcons.clock,
                value: "~24 Jam",
                label: "Pengerjaan",
                color: Colors.greenAccent,
              ),
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
  const StatCard({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 220,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.sidebar,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white54, fontSize: 11),
              ),
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
        const Text(
          "Pertanyaan Umum (FAQ)",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _faqItem(
          "Berapa lama waktu pengerjaan?",
          "Tergantung tingkat kesulitan, biasanya berkisar antara 12-48 jam.",
        ),
        _faqItem(
          "Apakah bisa revisi?",
          "Ya, kami memberikan garansi revisi gratis sampai tugas diterima.",
        ),
        _faqItem(
          "Bahas pemrograman apa saja yang dilayani?",
          "Hampir semua, mulai dari Python, Java, C++, PHP, JavaScript, hingga Dart/Flutter.",
        ),
      ],
    );
  }

  Widget _faqItem(String q, String a) {
    return Card(
      color: Colors.white.withOpacity(0.03),
      margin: const EdgeInsets.only(bottom: 10),
      child: ExpansionTile(
        title: Text(
          q,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              a,
              style: const TextStyle(color: Colors.white54, fontSize: 13),
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
    return GridView.builder(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.85,
      ),
      itemCount: provider.services.length,
      itemBuilder: (context, index) {
        final s = provider.services[index];
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: AppColors.sidebar,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(s.icon, color: AppColors.primary, size: 32),
                const SizedBox(height: 16),
                Text(
                  s.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  s.description,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white54, fontSize: 12),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => launchWA("Halo, saya mau joki ${s.title}"),
                  child: const Text("Konsultasi"),
                ),
              ],
            ),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(32),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 1000;
          return Flex(
            direction: isNarrow ? Axis.vertical : Axis.horizontal,
            crossAxisAlignment: isNarrow
                ? CrossAxisAlignment.stretch
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (isNarrow)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    DropdownButtonFormField<String>(
                      value: provider.selectedTaskType,
                      decoration: const InputDecoration(
                        labelText: "Jenis Tugas",
                      ),
                      items: [
                        "Pemrograman Dasar",
                        "Web Statis",
                        "Web Dinamis",
                        "Mobile App",
                        "Data Science",
                      ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                      onChanged: (v) => provider.updateCalculator(type: v),
                    ),
                    const SizedBox(height: 20),
                    const Text("Deadline (Hari)"),
                    Slider(
                      value: provider.deadline,
                      min: 1,
                      max: 14,
                      onChanged: (v) => provider.updateCalculator(dl: v),
                    ),
                    Text(
                      "${provider.deadline.toInt()} Hari",
                      style: const TextStyle(color: AppColors.primary),
                    ),
                    const SizedBox(height: 24),
                    _PriceCard(
                      formattedPrice: provider.formattedPrice,
                      onSend: () {
                        launchWA("Estimasi saya: Rp ${provider.formattedPrice}");
                      },
                    ),
                  ],
                )
              else ...[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DropdownButtonFormField<String>(
                        value: provider.selectedTaskType,
                        decoration: const InputDecoration(
                          labelText: "Jenis Tugas",
                        ),
                        items: [
                          "Pemrograman Dasar",
                          "Web Statis",
                          "Web Dinamis",
                          "Mobile App",
                          "Data Science",
                        ].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                        onChanged: (v) => provider.updateCalculator(type: v),
                      ),
                      const SizedBox(height: 20),
                      const Text("Deadline (Hari)"),
                      Slider(
                        value: provider.deadline,
                        min: 1,
                        max: 14,
                        onChanged: (v) => provider.updateCalculator(dl: v),
                      ),
                      Text(
                        "${provider.deadline.toInt()} Hari",
                        style: const TextStyle(color: AppColors.primary),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 40),
                SizedBox(
                  width: 300,
                  child: _PriceCard(
                    formattedPrice: provider.formattedPrice,
                    onSend: () {
                      launchWA("Estimasi saya: Rp ${provider.formattedPrice}");
                    },
                  ),
                ),
              ],
            ],
          );
        },
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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          const Text("Estimasi Biaya:"),
          Text(
            "Rp $formattedPrice",
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.primary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onSend,
              child: const Text("Hubungi Admin"),
            ),
          ),
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
