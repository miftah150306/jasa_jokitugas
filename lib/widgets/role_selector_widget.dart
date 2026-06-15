import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../models/education_level_model.dart';
import 'package:provider/provider.dart';
import '../controllers/dashboard_provider.dart';
import 'dart:ui';

class RoleSelectorWidget extends StatelessWidget {
  final String? selectedLevelId;
  final ValueChanged<String> onLevelSelected;

  const RoleSelectorWidget({
    super.key,
    required this.selectedLevelId,
    required this.onLevelSelected,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih Jenjang Pendidikanmu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: provider.textColor,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          'Katalog layanan akan disesuaikan otomatis dengan jenjangmu.',
          style: TextStyle(color: provider.textMuted, fontSize: 13),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final isVeryNarrow = constraints.maxWidth < 450;
            
            if (isVeryNarrow) {
              // 2x2 Grid untuk layar HP yang sangat kecil
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: educationLevels.length,
                itemBuilder: (context, index) {
                  final level = educationLevels[index];
                  return _RoleChip(
                    level: level,
                    isSelected: selectedLevelId == level.id,
                    onTap: () => onLevelSelected(level.id),
                    expanded: true,
                  );
                },
              );
            }
            
            // Flex Row untuk layar tablet/desktop/HP sedang (memenuhi ruang penuh)
            return Row(
              children: educationLevels.asMap().entries.map((entry) {
                final level = entry.value;
                final i = entry.key;
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      right: i < educationLevels.length - 1 ? 12 : 0,
                    ),
                    child: _RoleChip(
                      level: level,
                      isSelected: selectedLevelId == level.id,
                      onTap: () => onLevelSelected(level.id),
                      expanded: true,
                    ),
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}

class _RoleChip extends StatefulWidget {
  final EducationLevel level;
  final bool isSelected;
  final VoidCallback onTap;
  final bool expanded;

  const _RoleChip({
    required this.level,
    required this.isSelected,
    required this.onTap,
    this.expanded = false,
  });

  @override
  State<_RoleChip> createState() => _RoleChipState();
}

class _RoleChipState extends State<_RoleChip> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    final color = widget.level.accentColor;
    final isActive = widget.isSelected || _hovered;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: isActive ? 8.0 : 0.0, sigmaY: isActive ? 8.0 : 0.0),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTap,
              borderRadius: BorderRadius.circular(16),
              splashColor: color.withOpacity(0.3),
              highlightColor: color.withOpacity(0.1),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                width: widget.expanded ? double.infinity : null,
                padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? color.withOpacity(0.15)
                      : provider.cardColor.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: widget.isSelected ? color : provider.borderColor.withOpacity(0.5),
                    width: widget.isSelected ? 2 : 1,
                  ),
                  boxShadow: widget.isSelected
                      ? [
                          BoxShadow(
                            color: color.withOpacity(0.25),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : [],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: color.withOpacity(isActive ? 0.2 : 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        widget.level.icon,
                        color: color,
                        size: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      widget.level.emoji,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.level.label,
                      style: TextStyle(
                        color: widget.isSelected ? color : provider.textMuted,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ).animate(target: widget.isSelected ? 1 : 0).scaleXY(
        end: 1.03,
        duration: 200.ms,
        curve: Curves.easeOut,
      ),
    );
  }
}
