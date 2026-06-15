import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/dashboard_provider.dart';
import '../models/comment_model.dart';

class AddCommentDialog extends StatefulWidget {
  const AddCommentDialog({super.key});

  @override
  State<AddCommentDialog> createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  final _nameController = TextEditingController();
  final _levelController = TextEditingController();
  final _textController = TextEditingController();
  int _rating = 5;

  void _submit(DashboardProvider provider) {
    if (_nameController.text.trim().isEmpty || _textController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Nama dan Ulasan harus diisi!')),
      );
      return;
    }

    final comment = CommentModel(
      name: _nameController.text.trim(),
      level: _levelController.text.trim().isEmpty ? 'Klien' : _levelController.text.trim(),
      text: _textController.text.trim(),
      rating: _rating,
    );

    provider.addComment(comment);
    Navigator.pop(context);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Terima kasih atas ulasannya!')),
    );
  }

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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Beri Ulasan',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: provider.textColor,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: provider.textMuted),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Bagaimana pengalamanmu menggunakan layanan kami?',
                style: TextStyle(color: provider.textMuted, fontSize: 13),
              ),
              const SizedBox(height: 24),
              
              // Rating Selector
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return IconButton(
                    onPressed: () => setState(() => _rating = index + 1),
                    icon: Icon(
                      index < _rating ? FontAwesomeIcons.solidStar : FontAwesomeIcons.star,
                      color: Colors.orangeAccent,
                      size: 28,
                    ),
                  );
                }),
              ),
              const SizedBox(height: 24),

              // Inputs
              _buildInput('Nama Anda', _nameController, provider),
              const SizedBox(height: 16),
              _buildInput('Status (mis. Mahasiswa IT)', _levelController, provider),
              const SizedBox(height: 16),
              _buildInput('Ulasan', _textController, provider, maxLines: 4),
              const SizedBox(height: 32),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _submit(provider),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: provider.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Kirim Ulasan', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInput(String hint, TextEditingController controller, DashboardProvider provider, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      style: TextStyle(color: provider.textColor, fontSize: 14),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: provider.textMuted),
        filled: true,
        fillColor: provider.bgColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: provider.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: provider.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: provider.primaryColor),
        ),
      ),
    );
  }
}
