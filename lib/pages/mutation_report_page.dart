import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Monchaa/Models/database.dart'; // Sesuaikan package

class ReportMutationPage extends StatefulWidget {
  final int? initialWalletId;
  const ReportMutationPage({super.key, this.initialWalletId});

  @override
  State<ReportMutationPage> createState() => _ReportMutationPageState();
}

class _ReportMutationPageState extends State<ReportMutationPage> {
  final AppDatabase db = AppDatabase();
  DateTime selectedMonth = DateTime.now();
  int? selectedWalletId;
  List<WalletData> wallets = [];

  @override
  void initState() {
    super.initState();
    selectedWalletId = widget.initialWalletId;
    _loadWallets();
  }

  Future<void> _loadWallets() async {
    final data = await db.getAllWalletRepo();
    setState(() => wallets = data);
  }

  String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }

  // Helper untuk memilih bulan secara sederhana
  Future<void> _selectMonth() async {
    // Kita gunakan showDatePicker tapi hanya fokus ke bulan/tahun
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedMonth,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      initialDatePickerMode: DatePickerMode.year, // Langsung pilih tahun/bulan
      helpText: "PILIH BULAN",
    );
    if (picked != null) setState(() => selectedMonth = picked);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          selectedWalletId == null ? "Laporan & Mutasi" : "Mutasi Dompet",
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF8C9EFF),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 1. Filter Bar (Modern & Minimalis)
          _buildFilterSection(),

          // 2. Summary Card (Dashboard Bulanan)
          _buildSummaryCard(),

          // 3. Mutation List
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              children: [
                const Icon(Icons.receipt_long, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text(
                  "Riwayat Transaksi",
                  style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                ),
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder<List<MutationItem>>(
              future: db.getFilteredMutation(walletId: selectedWalletId, month: selectedMonth),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) return const Center(child: CircularProgressIndicator());
                final data = snapshot.data ?? [];
                if (data.isEmpty) return _buildEmptyState();

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: data.length,
                  itemBuilder: (context, index) => _buildMutationTile(data[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Color(0xFF8C9EFF),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(24), bottomRight: Radius.circular(24)),
      ),
      child: Row(
        children: [
          // Month Selector
          Expanded(
            child: GestureDetector(
              onTap: _selectMonth,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(color: Colors.white.withAlpha(20), borderRadius: BorderRadius.circular(12)),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 16, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat('MMMM yyyy', 'id_ID').format(selectedMonth),
                      style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Wallet Selector
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(color: Colors.white.withAlpha(20), borderRadius: BorderRadius.circular(12)),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int?>(
                  value: selectedWalletId,
                  dropdownColor: const Color(0xFF8C9EFF),
                  icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
                  isExpanded: true,
                  style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.w600),
                  items: [
                    const DropdownMenuItem(value: null, child: Text("Semua Dompet")),
                    ...wallets.map((w) => DropdownMenuItem(value: w.id, child: Text(w.name))),
                  ],
                  onChanged: (val) => setState(() => selectedWalletId = val),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard() {
    return FutureBuilder<List<MonthlySummaryItem>>(
      future: db.getMonthlySummary(walletId: selectedWalletId, month: selectedMonth),
      builder: (context, snapshot) {
        double income = 0;
        double expense = 0;
        if (snapshot.hasData && snapshot.data != null) {
          for (var item in snapshot.data!) {
            if (item.type == "income") {
              income += item.amount;
            } else {
              expense += item.amount;
            }
          }
        }

        return Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFF8C9EFF), Color(0xFFCADEFC)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: const Color(0xFF8C9EFF).withAlpha(30), blurRadius: 10, offset: const Offset(0, 5))],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem("Pemasukan", income, Colors.greenAccent),
              Container(width: 1, height: 40, color: Colors.white24),
              _buildSummaryItem("Pengeluaran", expense, Colors.redAccent[100]!),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryItem(String label, double amount, Color color) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.montserrat(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          formatCurrency(amount),
          style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildMutationTile(MutationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withAlpha(30), blurRadius: 10)]),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: CircleAvatar(
          backgroundColor: item.isCredit ? Colors.green[50] : Colors.red[50],
          child: Icon(item.isCredit ? Icons.add : Icons.remove, color: item.isCredit ? Colors.green : Colors.red, size: 20),
        ),
        title: Text(item.title, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 14)),
        subtitle: Text("${item.description} • ${DateFormat('dd MMM yyy').format(item.date)}", style: const TextStyle(fontSize: 12)),
        trailing: Text(
          formatCurrency(item.amount),
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, color: item.isCredit ? Colors.green : Colors.red),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.query_stats, size: 60, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text("Tidak ada transaksi", style: GoogleFonts.montserrat(color: Colors.grey)),
        ],
      ),
    );
  }
}