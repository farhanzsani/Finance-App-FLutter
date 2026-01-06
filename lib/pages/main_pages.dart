import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:finance_app_for_nacha/pages/category_page.dart';
import 'package:finance_app_for_nacha/pages/home_page.dart';
import 'package:finance_app_for_nacha/pages/transaction_page.dart';
import 'package:finance_app_for_nacha/pages/wallet_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const Color primaryColor = Color(0xFFCADEFC);
  final List<Widget> _childern = [const HomePage(), const CategoryPage(), WalletPage()];

  int currentIndex = 0;

  void onTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: (currentIndex == 0)
          ? CalendarAppBar(
              backButton: false,
              locale: 'id',
              white: const Color(0xFF8C9EFF), // background
              black: const Color(0xFF2F3A5F), // teks (gelap & jelas)
              accent: const Color(0xFFCADEFC), // highlight // highlight tanggal
              onDateChanged: (value) => print(value),
              firstDate: DateTime.now().subtract(const Duration(days: 140)),
              lastDate: DateTime.now(),
            )
          : PreferredSize(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 36,
                    horizontal: 16,
                  ),
                ),
              ),
              preferredSize: Size.fromHeight(100),
            ),

      body: _childern[currentIndex],

      floatingActionButton: Visibility(
        visible: (currentIndex == 0) ? true : false,
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(
                  MaterialPageRoute(builder: (context) => TransactionPage()),
                )
                .then((value) {
                  setState(() {});
                });
          },
          backgroundColor: primaryColor,
          shape: const CircleBorder(),
          elevation: 2,
          child: const Icon(Icons.add, color: const Color(0xFF8C9EFF)),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: primaryColor,
        elevation: 4,
        child: SizedBox(
          height: 56,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.home, color: const Color(0xFF8C9EFF)),
                onPressed: () {
                  onTapped(0);
                },
              ),
              IconButton(
                icon: Icon(Icons.account_balance_wallet, color: const Color(0xFF8C9EFF)),
                onPressed: () {
                  onTapped(2);
                },
              ),
              SizedBox(width: 100),
              IconButton(
                icon: Icon(Icons.list, color: const Color(0xFF8C9EFF)),
                onPressed: () {
                  onTapped(1);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
