import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Monchaa/Models/database.dart';
import 'package:intl/intl.dart';

class TransactionHistoryPage extends StatelessWidget {
  final WalletData wallet;
  final AppDatabase db; // Terima database dari constructor

  TransactionHistoryPage({super.key, required this.wallet, required this.db});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('Transaksi ${wallet.name}', 
          style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF4A5568),
        elevation: 0.5,
      ),
      body: StreamBuilder<List<TransactionWithWallet>>(
        stream: db.watchTransactionsByWallet(wallet.id), // Memanggil fungsi baru
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          
          final list = snapshot.data ?? [];
          if (list.isEmpty) {
            return Center(
              child: Text('Belum ada transaksi', 
              style: GoogleFonts.montserrat(color: Colors.grey)),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final data = list[index];
              final item = data.transaction;
              
              // LOGIKA: Misal category.type 1 = Income, 2 = Expense
              final bool isIncome = data.category.type == 1;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4)),
                  ],
                ),
                child: ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isIncome ? Colors.green.withOpacity(0.1) : Colors.red.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isIncome ? Icons.add_rounded : Icons.remove_rounded,
                      color: isIncome ? Colors.green : Colors.red,
                    ),
                  ),
                  title: Text(item.name, 
                    style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
                  subtitle: Text(
                    DateFormat('dd MMM yyyy').format(item.transaction_date),
                    style: GoogleFonts.montserrat(fontSize: 12),
                  ),
                  trailing: Text(
                    '${isIncome ? "+" : "-"} ${currencyFormat.format(item.amount)}',
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.bold,
                      color: isIncome ? Colors.green : Colors.redAccent,
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