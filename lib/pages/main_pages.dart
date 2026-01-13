import 'package:Monchaa/pages/mutation_report_page.dart';
import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:Monchaa/pages/category_page.dart';
import 'package:Monchaa/pages/home_page.dart';
import 'package:Monchaa/pages/transaction_page.dart';
import 'package:Monchaa/pages/wallet_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // Warna tema Monchaa
  static const Color primaryColor = Color(0xFFCADEFC); 
  static const Color accentColor = Color(0xFF8C9EFF);  
  
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  // Fungsi untuk mendapatkan halaman saat ini
  Widget _getCurrentPage() {
    switch (currentIndex) {
      case 0:
        return HomePage(selectedDate: selectedDate);
      case 1:
        return const CategoryPage();
      case 2:
        return const WalletPage();
      case 3:
        return const ReportMutationPage();
      default:
        return HomePage(selectedDate: selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 1. ATUR APPBAR: Hanya muncul di Home agar CalendarAppBar tidak mengganggu halaman lain
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              backButton: false,
              locale: 'id_ID', // Gunakan id_ID agar konsisten dengan inisialisasi di main.dart
              white: accentColor, 
              black: const Color(0xFF2F3A5F), 
              accent: primaryColor, 
              selectedDate: selectedDate, // Tambahkan ini agar kalender sinkron dengan state
              onDateChanged: (value) {
                setState(() {
                  selectedDate = value;
                });
              },
              // Rentang tanggal kalender
              firstDate: DateTime.now().subtract(const Duration(days: 365)),
              lastDate: DateTime.now(),
            )
          : null, 

      body: _getCurrentPage(),

      
      floatingActionButton: Visibility(
        visible: (currentIndex == 0),
        child: FloatingActionButton(
          onPressed: () async {
           
            final result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TransactionPage()),
            );
            
          
            if (result == true && mounted) {
              setState(() {}); 
            }
          },
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          elevation: 4,
          child: const Icon(Icons.add, color: accentColor, size: 30),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // 3. ATUR NAVIGATION BAR: Membuat navigasi bawah yang modern
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: primaryColor,
        elevation: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Menu Home
              _buildNavItem(Icons.home_rounded, 0),
              
              // Menu Mutasi & Report (Ikon baru yang kita sepakati)
              _buildNavItem(Icons.receipt_long_rounded, 3),

              const SizedBox(width: 48), // Space kosong untuk Notch FAB di tengah

              // Menu Kategori
              _buildNavItem(Icons.category_rounded, 1),
              
              // Menu Dompet/Wallet
              _buildNavItem(Icons.account_balance_wallet_rounded, 2),
            ],
          ),
        ),
      ),
    );
  }

  // Helper Widget untuk membangun item navigasi agar kode lebih bersih
  Widget _buildNavItem(IconData icon, int index) {
    bool isActive = (currentIndex == index);
    return IconButton(
      onPressed: () => onTapped(index),
      icon: Icon(
        icon,
        size: 28,
        color: isActive ? Colors.white : accentColor.withOpacity(0.7),
      ),
    );
  }
}