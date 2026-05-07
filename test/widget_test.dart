import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import '../lib/main.dart';// Ganti dengan nama project Anda

void main() {
  testWidgets('Pengujian Tampilan dan Login Halaman Awal', (WidgetTester tester) async {
    // 1. Jalankan aplikasi di lingkungan testing
    const aplikasiPresensiUTS = const AplikasiPresensiUTS();
    await tester.pumpWidget(aplikasiPresensiUTS);

    // 2. Pastikan teks "LOG IN UTS" ada di layar
    expect(find.text('LOG IN UTS'), findsOneWidget);

    // 3. Pastikan ada tombol login
    expect(find.text('LOGIN SEKARANG'), findsOneWidget);

    // 4. Simulasi mengetik NIM
    await tester.enterText(find.byType(TextField).at(0), '20240001');
    
    // 5. Simulasi mengetik Password
    await tester.enterText(find.byType(TextField).at(1), 'password123');

    // 6. Klik tombol Login
    await tester.tap(find.byType(ElevatedButton));
    
    // 7. Tunggu sampai animasi/transisi halaman selesai
    await tester.pumpAndSettle();

    // 8. Pastikan setelah login, kita berpindah ke halaman "Presensi Mahasiswa"
    expect(find.text('Presensi Mahasiswa'), findsOneWidget);
  });
}

