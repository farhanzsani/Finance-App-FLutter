import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finance_app_for_nacha/Models/database.dart';

class TransferHistoryPage extends StatelessWidget {
  final WalletData wallet;
  final AppDatabase db = AppDatabase();

  TransferHistoryPage({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('Mutasi Saldo: ${wallet.name}', 
          style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.w600)),
        backgroundColor: Colors.white,
        foregroundColor: const Color(0xFF8C9EFF),
        elevation: 0,
      ),
      body: FutureBuilder<List<TransferWithWalletNames>>(
        future: db.getTransfersByWallet(wallet.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Belum ada riwayat transfer'));
          }

          final list = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: list.length,
            itemBuilder: (context, index) {
              final tr = list[index];
              // Cek apakah bagi wallet ini, transfernya masuk atau keluar
              bool isIncoming = tr.transfer.target_wallet_id == wallet.id;

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isIncoming ? Colors.green[50] : Colors.red[50],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        isIncoming ? Icons.south_west_rounded : Icons.north_east_rounded,
                        color: isIncoming ? Colors.green : Colors.red,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isIncoming ? 'Transfer Masuk' : 'Transfer Keluar',
                            style: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            isIncoming
                                ? 'Dari: ${tr.sourceName}'
                                : 'Ke: ${tr.targetName }',
                            style: GoogleFonts.montserrat(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${isIncoming ? "+" : "-"} ${tr.transfer.amount}',
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        color: isIncoming ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}