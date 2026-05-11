import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../utils/constants.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({super.key});

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  double _rating = 5.0;
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Berikan Ulasan", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Kepuasan Anda adalah prioritas kami. Bagikan pengalaman Anda menggunakan layanan JokiPro.", style: TextStyle(color: Colors.white54)),
          const SizedBox(height: 40),
          
          Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              padding: const EdgeInsets.all(40),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: Colors.white10),
              ),
              child: Column(
                children: [
                  const Icon(FontAwesomeIcons.solidStar, size: 50, color: Colors.orangeAccent),
                  const SizedBox(height: 20),
                  Text("Rating: ${_rating.toInt()} / 5", style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Slider(
                    value: _rating,
                    min: 1, max: 5,
                    divisions: 4,
                    activeColor: Colors.orangeAccent,
                    onChanged: (v) => setState(() => _rating = v),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                    controller: _commentController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: "Tuliskan komentar Anda di sini...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final msg = "Halo Admin JokiPro, saya ingin memberikan review:\nRating: ${_rating.toInt()}/5\nKomentar: ${_commentController.text}";
                        launchWA(msg);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Terima kasih! Mengarahkan ke WhatsApp...")));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.all(20),
                      ),
                      child: const Text("Kirim Ulasan via WhatsApp"),
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
}
