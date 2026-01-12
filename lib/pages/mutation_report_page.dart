import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Monchaa/Models/database.dart';

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
    if (mounted) setState(() => wallets = data);
  }

  String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(amount);
  }

  // --- FITUR BARU: MONTH PICKER DIALOG ---
  Future<void> _selectMonth() async {
    // Memunculkan dialog untuk memilih tahun terlebih dahulu, lalu bulan
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Pilih Bulan & Tahun", style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16)),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              selectedDate: selectedMonth,
              onChanged: (DateTime dateTime) {
                // Setelah pilih tahun, munculkan pilihan bulan
                Navigator.pop(context);
                _showMonthSelector(dateTime);
              },
            ),
          ),
        );
      },
    );
  }

  void _showMonthSelector(DateTime yearDate) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Pilih Bulan - ${yearDate.year}",
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    DateTime monthData = DateTime(yearDate.year, index + 1);
                    bool isSelected = selectedMonth.month == monthData.month && selectedMonth.year == monthData.year;
                    
                    return InkWell(
                      onTap: () {
                        setState(() => selectedMonth = monthData);
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? const Color(0xFF8C9EFF) : Colors.grey[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          DateFormat('MMM', 'id_ID').format(monthData),
                          style: GoogleFonts.montserrat(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      // PERBAIKAN: Gunakan SafeArea agar tidak tertutup notch/status bar
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
            
            // Header Title Manual (Karena AppBar null di MainPage)
            Center(
              child: Text(
                selectedWalletId == null ? "Laporan & Mutasi" : "Mutasi Dompet",
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, 
                  fontSize: 18,
                  color: const Color(0xFF8C9EFF)
                ),
              ),
            ),
            
            const SizedBox(height: 10),

            // 1. Filter Section (Month & Wallet)
            _buildFilterSection(),

            // 2. Summary Card
            _buildSummaryCard(),

            // 3. Mutation List
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  const Icon(Icons.receipt_long_rounded, size: 20, color: Colors.grey),
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
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator(color: Color(0xFF8C9EFF)));
                  }
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
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Month Selector Button (Kiri)
          Expanded(
            child: GestureDetector(
              onTap: _selectMonth,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_month_rounded, size: 18, color: Color(0xFF8C9EFF)),
                    const SizedBox(width: 10),
                    Text(
                      DateFormat('MMMM yyyy', 'id_ID').format(selectedMonth),
                      style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Wallet Selector (Kanan)
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<int?>(
                  value: selectedWalletId,
                  icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8C9EFF)),
                  isExpanded: true,
                  style: GoogleFonts.montserrat(color: Colors.black87, fontWeight: FontWeight.w600, fontSize: 13),
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
            if (item.type == 1) income += item.amount;
            else expense += item.amount;
          }
        }

        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF8C9EFF), Color(0xFFCADEFC)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF8C9EFF).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem("Pemasukan", income, Colors.greenAccent),
              Container(width: 1, height: 40, color: Colors.white24),
              _buildSummaryItem("Pengeluaran", expense, const Color(0xFFFFB2B2)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSummaryItem(String label, double amount, Color color) {
    return Column(
      children: [
        Text(label, style: GoogleFonts.montserrat(color: Colors.white.withOpacity(0.8), fontSize: 12)),
        const SizedBox(height: 4),
        Text(
          formatCurrency(amount),
          style: GoogleFonts.montserrat(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
        ),
      ],
    );
  }

  Widget _buildMutationTile(MutationItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white, 
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (item.isCredit ? Colors.green : Colors.red).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            item.isCredit ? Icons.add_circle_outline_rounded : Icons.remove_circle_outline_rounded,
            color: item.isCredit ? Colors.green : Colors.red,
            size: 24,
          ),
        ),
        title: Text(item.title, style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 14)),
        subtitle: Text(
          "${item.description}\n${DateFormat('dd MMM yyyy • HH:mm', 'id_ID').format(item.date)}",
          style: GoogleFonts.montserrat(fontSize: 11, color: Colors.grey[600]),
        ),
        isThreeLine: true,
        trailing: Text(
          formatCurrency(item.amount),
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold, 
            fontSize: 14,
            color: item.isCredit ? Colors.green : Colors.red
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 16),
          Text(
            "Belum ada mutasi transaksi",
            style: GoogleFonts.montserrat(color: Colors.grey, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}