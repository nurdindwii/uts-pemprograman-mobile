import 'package:flutter/material.dart';

void main() => runApp(const AplikasiUTS());

class AplikasiUTS extends StatelessWidget {
  const AplikasiUTS({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Presensi Mahasiswa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      home: const HalamanLogin(),
    );
  }
}

// --- HALAMAN LOGIN ---
class HalamanLogin extends StatefulWidget {
  const HalamanLogin({super.key});

  @override
  State<HalamanLogin> createState() => _HalamanLoginState();
}

class _HalamanLoginState extends State<HalamanLogin> {
  final _nimController = TextEditingController();
  final _passController = TextEditingController();

  void _login() {
    // Logika login sederhana untuk UTS
    if (_nimController.text.isNotEmpty && _passController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HalamanPresensi()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Harap isi NIM dan Password")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 100, color: Colors.indigo),
            const SizedBox(height: 20),
            const Text("Login Mahasiswa",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
              controller: _nimController,
              decoration: const InputDecoration(
                  labelText: 'NIM', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: _passController,
              obscureText: true,
              decoration: const InputDecoration(
                  labelText: 'Password', border: OutlineInputBorder()),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                child:
                    const Text("MASUK", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- HALAMAN PRESENSI ---
class HalamanPresensi extends StatefulWidget {
  const HalamanPresensi({super.key});

  @override
  State<HalamanPresensi> createState() => _HalamanPresensiState();
}

class _HalamanPresensiState extends State<HalamanPresensi> {
  // Data mahasiswa dengan status awal 'Belum diabsen'
  final List<Map<String, dynamic>> _mahasiswa = [
    {"nama": "Nurdin Dwi", "nim": "2024001", "status": "Masuk"},
    {"nama": "Budi Raharjo", "nim": "2024002", "status": "Masuk"},
    {"nama": "Siti Aminah", "nim": "2024003", "status": "Masuk"},
    {"nama": "Andi Wijaya", "nim": "2024004", "status": "Masuk"},
  ];

  void _ubahStatus(int index, String statusBaru) {
    setState(() {
      _mahasiswa[index]['status'] = statusBaru;
    });
  }

  Color _getWarna(String status) {
    switch (status) {
      case "Masuk":
        return Colors.green;
      case "Ijin":
        return Colors.orange;
      case "Tidak Masuk":
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Kehadiran"),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const HalamanLogin())),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: _mahasiswa.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                        backgroundColor:
                            _getWarna(_mahasiswa[index]['status'])),
                    title: Text(_mahasiswa[index]['nama'],
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(
                        "NIM: ${_mahasiswa[index]['nim']} | Status: ${_mahasiswa[index]['status']}"),
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _tombolStatus(index, "Masuk", Colors.green),
                      _tombolStatus(index, "Ijin", Colors.orange),
                      _tombolStatus(index, "Tidak Masuk", Colors.red),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _tombolStatus(int index, String label, Color warna) {
    return ElevatedButton(
      onPressed: () => _ubahStatus(index, label),
      style: ElevatedButton.styleFrom(
        backgroundColor:
            _mahasiswa[index]['status'] == label ? warna : Colors.grey[200],
        foregroundColor:
            _mahasiswa[index]['status'] == label ? Colors.white : Colors.black,
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}
