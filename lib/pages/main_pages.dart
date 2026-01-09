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
  static const Color primaryColor = Color(0xFFCADEFC);
  static const Color accentColor = Color(0xFF8C9EFF);
  
  int currentIndex = 0;
  DateTime selectedDate = DateTime.now();

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void onDateChanged(DateTime date) {
    setState(() {
      selectedDate = date;
    });
  }

  Widget _getCurrentPage() {
    switch (currentIndex) {
      case 0:
        return HomePage(selectedDate: selectedDate);
      case 1:
        return const CategoryPage();
      case 2:
        return WalletPage();
      case 3:
        return const ReportMutationPage();
      default:
        return HomePage(selectedDate: selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar hanya muncul di Home (index 0) dengan CalendarAppBar
      // Untuk halaman lain, kita buat null agar konten mengisi layar dari paling atas
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              backButton: false,
              locale: 'id',
              white: accentColor, 
              black: const Color(0xFF2F3A5F), 
              accent: primaryColor, 
              onDateChanged: (value) {
                onDateChanged(value);
              },
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : null, 

      body: _getCurrentPage(),

      floatingActionButton: Visibility(
        visible: (currentIndex == 0),
        child: FloatingActionButton(
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const TransactionPage()),
            );
            if (mounted) {
              setState(() {});
            }
          },
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          elevation: 2,
          child: const Icon(Icons.add, color: accentColor),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: primaryColor,
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home_rounded, 
                  color: currentIndex == 0 ? Colors.white : accentColor
                ),
                onPressed: () => onTapped(0),
              ),

              IconButton(
                icon: Icon(
                  Icons.receipt_long_rounded, 
                  color: currentIndex == 3 ? Colors.white : accentColor
                ),
                onPressed: () => onTapped(3),
              ),

              const SizedBox(width: 80), // Space for FAB

              IconButton(
                icon: Icon(
                  Icons.category_rounded, 
                  color: currentIndex == 1 ? Colors.white : accentColor
                ),
                onPressed: () => onTapped(1),
              ),
              
              IconButton(
                icon: Icon(
                  Icons.account_balance_wallet_rounded, 
                  color: currentIndex == 2 ? Colors.white : accentColor
                ),
                onPressed: () => onTapped(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}