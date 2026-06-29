import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../utils/constants.dart';
import '../controllers/dashboard_provider.dart';

class StatusCheckerPage extends StatelessWidget {
  const StatusCheckerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 860),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // === HERO CARD ===
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 32),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1E1B4B), Color(0xFF1E293B)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  border: Border.all(color: provider.primaryColor.withOpacity(0.3)),
                  boxShadow: [
                    BoxShadow(
                      color: provider.primaryColor.withOpacity(0.12),
                      blurRadius: 40,
                      offset: const Offset(0, 12),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Avatar
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [provider.primaryColor, provider.secondaryColor],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: provider.primaryColor.withOpacity(0.4),
                            blurRadius: 24,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          'M',
                          style: GoogleFonts.outfit(
                            fontSize: 42,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).animate().scale(duration: 600.ms, curve: Curves.easeOutBack),
                    const SizedBox(height: 20),
                    Text(
                      'Miftah',
                      style: GoogleFonts.outfit(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2),
                    const SizedBox(height: 6),
                    ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        colors: [provider.primaryColor, provider.secondaryColor],
                      ).createShader(bounds),
                      child: Text(
                        'Flutter Developer & Founder DevConnect',
                        style: GoogleFonts.outfit(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.06),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.white10),
                      ),
                      child: const Text(
                        '📍 Indonesia  ·  💻 Open to Work  ·  🚀 Building Cool Stuff',
                        style: TextStyle(color: Colors.white60, fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                    ).animate().fadeIn(delay: 400.ms),
                    const SizedBox(height: 24),
                    // Social Buttons
                    Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      alignment: WrapAlignment.center,
                      children: [
                        _SocialBtn(
                          icon: FontAwesomeIcons.whatsapp,
                          label: 'WhatsApp',
                          color: const Color(0xFF25D366),
                          onTap: () => launchWA('Halo Miftah! Saya tertarik dengan layanan DevConnect 👋'),
                        ),
                        _SocialBtn(
                          icon: FontAwesomeIcons.instagram,
                          label: 'Instagram',
                          color: const Color(0xFFE1306C),
                          onTap: () => launchWA('Halo dari Instagram!'),
                        ),
                        _SocialBtn(
                          icon: FontAwesomeIcons.github,
                          label: 'GitHub',
                          color: const Color(0xFF6E7681),
                          onTap: () => launchWA('Halo, saya lihat GitHub kamu!'),
                        ),
                      ],
                    ).animate().fadeIn(delay: 500.ms),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // === STATS ROW ===
              LayoutBuilder(builder: (context, c) {
                final cols = c.maxWidth > 600 ? 3 : 1;
                return GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: cols,
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                  childAspectRatio: cols == 3 ? 2.4 : 3.5,
                  children: const [
                    _StatItem(value: '1,240+', label: 'Proyek Selesai', icon: FontAwesomeIcons.checkDouble, color: Color(0xFF818CF8)),
                    _StatItem(value: '3+ Tahun', label: 'Pengalaman Dev', icon: FontAwesomeIcons.laptop, color: Color(0xFF34D399)),
                    _StatItem(value: '850+', label: 'Klien Puas', icon: FontAwesomeIcons.users, color: Color(0xFFFBBF24)),
                  ],
                );
              }),
              const SizedBox(height: 24),

              // === ABOUT ===
              _SectionCard(
                title: '👨‍💻 Tentang Saya',
                child: Text(
                  'Halo! Saya Miftah, seorang Flutter Developer yang passionate dalam membangun aplikasi mobile dan web yang indah dan fungsional. '
                  'Saya mendirikan DevConnect sebagai platform freelance IT untuk membantu bisnis, startup, dan individu mewujudkan proyek teknologi mereka dengan kualitas terbaik.\n\n'
                  'Dengan pengalaman lebih dari 3 tahun di dunia pengembangan aplikasi, saya telah menyelesaikan ratusan proyek mulai dari aplikasi sederhana hingga sistem enterprise.',
                  style: TextStyle(color: provider.textMuted, fontSize: 13.5, height: 1.7),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.08),
              const SizedBox(height: 16),

              // === SKILLS ===
              _SectionCard(
                title: '🛠️ Tech Stack',
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    _SkillBadge('Flutter', const Color(0xFF54C5F8)),
                    _SkillBadge('Dart', const Color(0xFF0553B1)),
                    _SkillBadge('React', const Color(0xFF61DAFB)),
                    _SkillBadge('Next.js', const Color(0xFFFFFFFF)),
                    _SkillBadge('Laravel', const Color(0xFFFF2D20)),
                    _SkillBadge('Python', const Color(0xFF3776AB)),
                    _SkillBadge('MySQL', const Color(0xFF4479A1)),
                    _SkillBadge('Firebase', const Color(0xFFFFA000)),
                    _SkillBadge('Node.js', const Color(0xFF68A063)),
                    _SkillBadge('Git', const Color(0xFFF05032)),
                  ],
                ),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.08),
              const SizedBox(height: 16),

              // === SERVICES ===
              _SectionCard(
                title: '🎯 Layanan Unggulan',
                child: Column(
                  children: [
                    _ServiceRow(FontAwesomeIcons.mobileScreen, 'Mobile App (Flutter)', 'Android & iOS, state management, REST API'),
                    const SizedBox(height: 12),
                    _ServiceRow(FontAwesomeIcons.globe, 'Web Development', 'React, Next.js, Laravel, PHP, HTML/CSS/JS'),
                    const SizedBox(height: 12),
                    _ServiceRow(FontAwesomeIcons.brain, 'Data Science', 'Python, Pandas, ML, Data Visualization'),
                    const SizedBox(height: 12),
                    _ServiceRow(FontAwesomeIcons.bookBookmark, 'Skripsi / TA', 'Sistem berbasis IT, dokumentasi lengkap'),
                  ],
                ),
              ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.08),
              const SizedBox(height: 24),

              // === CTA ===
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => launchWA(
                    'Halo Miftah! Saya ingin bekerjasama / konsultasi tentang proyek saya 🙏',
                  ),
                  icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.white, size: 18),
                  label: Text(
                    'Hubungi Developer Langsung',
                    style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF25D366),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                ),
              ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Widgets Helper ──────────────────────────────────────────────────

class _SocialBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;
  const _SocialBtn({required this.icon, required this.label, required this.color, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onTap,
      icon: Icon(icon, size: 16, color: Colors.white),
      label: Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600)),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 0,
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value, label;
  final IconData icon;
  final Color color;
  const _StatItem({required this.value, required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: provider.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: provider.borderColor),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(value, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: provider.textColor)),
              Text(label, style: TextStyle(color: provider.textMuted, fontSize: 11)),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: provider.cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: provider.borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: GoogleFonts.outfit(fontSize: 16, fontWeight: FontWeight.bold, color: provider.textColor)),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _SkillBadge extends StatelessWidget {
  final String label;
  final Color color;
  const _SkillBadge(this.label, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
    );
  }
}

class _ServiceRow extends StatelessWidget {
  final IconData icon;
  final String title, subtitle;
  const _ServiceRow(this.icon, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: provider.primaryColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: provider.primaryColor, size: 16),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: provider.textColor)),
              Text(subtitle, style: TextStyle(color: provider.textMuted, fontSize: 12)),
            ],
          ),
        ),
      ],
    );
  }
}
