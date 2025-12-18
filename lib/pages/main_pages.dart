import 'package:calendar_appbar/calendar_appbar.dart';
import 'package:finance_app_for_nacha/pages/home_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const Color primaryColor = Color(0xFFCADEFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CalendarAppBar(
        backButton: false,
        locale: 'id',
        white: const Color(0xFF8C9EFF), // background
        black: const Color(0xFF2F3A5F), // teks (gelap & jelas)
        accent: const Color(0xFFCADEFC), // highlight // highlight tanggal
        onDateChanged: (value) => print(value),
        firstDate: DateTime.now().subtract(const Duration(days: 140)),
        lastDate: DateTime.now(),
      ),

      body: const HomePage(),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: primaryColor,
        shape: const CircleBorder(),
        elevation: 2,
        child: const Icon(Icons.add, color: const Color(0xFF8C9EFF)),
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
            children: const [
              IconButton(
                icon: Icon(Icons.home, color: const Color(0xFF8C9EFF)),
                onPressed: null,
              ),
              SizedBox(width: 10),
              IconButton(
                icon: Icon(Icons.list, color: const Color(0xFF8C9EFF)),
                onPressed: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
