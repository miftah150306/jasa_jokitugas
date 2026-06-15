import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/service_model.dart';
import '../utils/constants.dart';
import 'package:provider/provider.dart';
import '../controllers/dashboard_provider.dart';
import 'dart:ui';

class ServiceCardWidget extends StatefulWidget {
  final ServiceModel service;
  final Color accentColor;
  final String educationLabel;
  final int animationIndex;

  const ServiceCardWidget({
    super.key,
    required this.service,
    required this.accentColor,
    required this.educationLabel,
    required this.animationIndex,
  });

  @override
  State<ServiceCardWidget> createState() => _ServiceCardWidgetState();
}

class _ServiceCardWidgetState extends State<ServiceCardWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final color = widget.accentColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: _hovered ? 8.0 : 0.0, sigmaY: _hovered ? 8.0 : 0.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                // You can add navigation or dialog here if needed when card is tapped
              },
              borderRadius: BorderRadius.circular(20),
              splashColor: color.withOpacity(0.3),
              highlightColor: color.withOpacity(0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: _hovered
                      ? color.withOpacity(0.1)
                      : provider.cardColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: _hovered ? color.withOpacity(0.4) : provider.borderColor.withOpacity(0.5),
                    width: _hovered ? 1.5 : 1,
                  ),
                  boxShadow: _hovered
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.15),
                            blurRadius: 20,
                            offset: const Offset(0, 6),
                          )
                        ]
                      : [],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
              Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(_hovered ? 0.2 : 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(widget.service.icon, color: color, size: 22),
                  ),
                  const Spacer(),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      widget.educationLabel,
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                widget.service.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: provider.textColor,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  widget.service.description,
                  style: TextStyle(
                    color: provider.textMuted,
                    fontSize: 12.5,
                    height: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Mulai dari',
                        style: TextStyle(color: provider.textMuted, fontSize: 11),
                      ),
                      Text(
                        'Rp ${_formatPrice(widget.service.basePrice.toInt())}',
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    child: ElevatedButton(
                      onPressed: () {
                        final msg =
                            'Halo Admin JokiPro 👋\n\nSaya *${widget.educationLabel}* ingin konsultasi mengenai:\n*${widget.service.title}*\n\nMohon info lebih lanjut ya 🙏';
                        launchWA(msg);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: _hovered ? 4 : 0,
                      ),
                      child: const Text(
                        'Konsultasi',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    ),
    ),
    )
    .animate()
          .fadeIn(
            delay: (widget.animationIndex * 60).ms,
            duration: 350.ms,
          )
          .slideY(
            begin: 0.15,
            end: 0,
            delay: (widget.animationIndex * 60).ms,
            duration: 350.ms,
            curve: Curves.easeOut,
          ),
    );
  }

  String _formatPrice(int price) {
    final str = price.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if (i > 0 && (str.length - i) % 3 == 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return buffer.toString();
  }
}
