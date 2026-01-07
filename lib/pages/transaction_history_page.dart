import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finance_app_for_nacha/Models/database.dart';

class TransactionHistoryPage extends StatelessWidget {
  final WalletData wallet;
  final AppDatabase db = AppDatabase();

  TransactionHistoryPage({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('Transaksi ${wallet.name}', 
          style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF8C9EFF),
        elevation: 0,
      ),
      body: FutureBuilder<List<TransactionWithWallet>>(
        future: db.getTransactionsByWallet(wallet.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada transaksi'));
          }

          final list = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final item = list[index].transaction;
              // Asumsi: Anda perlu logic untuk menentukan income/expense 
              // berdasarkan category_id atau field lainnya
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Color(0xFFE8F0FE),
                    child: Icon(Icons.shopping_bag_outlined, color: Color(0xFF8C9EFF)),
                  ),
                  title: Text(item.name, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                  subtitle: Text(item.transaction_date.toString().split(' ')[0]),
                  trailing: Text(
                    'Rp ${item.amount}',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}