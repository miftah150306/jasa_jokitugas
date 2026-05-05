import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/dashboard_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatusCheckerPage extends StatefulWidget {
  const StatusCheckerPage({super.key});

  @override
  State<StatusCheckerPage> createState() => _StatusCheckerPageState();
}

class _StatusCheckerPageState extends State<StatusCheckerPage> {
  final TextEditingController _idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Cek Status Tugas", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
          const Text("Masukkan ID Tugas Anda untuk melihat progres pengerjaan tim kami.", style: TextStyle(color: Colors.white54)),
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
                  const Icon(FontAwesomeIcons.magnifyingGlassChart, size: 60, color: Color(0xFF6366F1)),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      hintText: "Contoh: JP-001",
                      labelText: "ID Tugas",
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      prefixIcon: const Icon(Icons.tag),
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: provider.isLoadingStatus 
                        ? null 
                        : () => provider.checkStatus(_idController.text),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        padding: const EdgeInsets.all(20),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      child: provider.isLoadingStatus 
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Cek Sekarang"),
                    ),
                  ),
                  
                  if (provider.statusResult.isNotEmpty) ...[
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(20),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: provider.statusResult.contains("tidak") ? Colors.red.withOpacity(0.3) : Colors.green.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(
                            provider.statusResult,
                            style: TextStyle(
                              fontSize: 18, 
                              fontWeight: FontWeight.bold,
                              color: provider.statusResult.contains("tidak") ? Colors.redAccent : Colors.greenAccent
                            ),
                            textAlign: TextAlign.center,
                          ),
                          if (!provider.statusResult.contains("tidak")) ...[
                            const SizedBox(height: 20),
                            const LinearProgressIndicator(
                              value: 0.65,
                              backgroundColor: Colors.white10,
                              color: Colors.greenAccent,
                            ),
                          ]
                        ],
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
