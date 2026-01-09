import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Monchaa/Models/database.dart';
import 'package:Monchaa/pages/transaction_history_page.dart';
import 'package:Monchaa/pages/transfer_history_page.dart';
// Pastikan import ini ada kalau mau pake navigasi ke mutasi yang kita buat tadi
import 'package:Monchaa/pages/mutation_report_page.dart'; 

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final AppDatabase db = AppDatabase();
  bool isMenuOpen = false;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController transferAmountController = TextEditingController();

  List<WalletData> wallets = [];
  bool isLoading = true;
  int? sourceWalletId;
  int? targetWalletId;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final data = await db.getAllWalletRepo();
    if (mounted) {
      setState(() {
        wallets = data;
        isLoading = false;
      });
    }
  }

  Future<void> insert(String name) async {
    final now = DateTime.now();
    await db.into(db.wallet).insert(
          WalletCompanion.insert(
            name: name,
            created: now,
            updated_at: now,
          ),
        );
    _loadData();
  }

  Future<void> update(int id, String name) async {
    await db.updateDataWalletRepo(id, name);
    _loadData();
  }

  Future<void> delete(int id) async {
    await db.deleteWalletRepo(id);
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      // AppBar dihapus biar gak dobel/kepotong, diganti SafeArea di body
      body: SafeArea(
        child: Column(
          children: [
            // Jarak atas biar gak mepet status bar
            const SizedBox(height: 60),
            
            // Header Title Manual
            Center(
              child: Text(
                "Wallets",
                style: GoogleFonts.montserrat(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF8C9EFF),
                ),
              ),
            ),
            
            const SizedBox(height: 10),

            // Konten Utama (List Wallet)
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator(color: Color(0xFF8C9EFF)))
                  : wallets.isEmpty
                      ? Center(
                          child: Text(
                            'Belum ada dompet nih chaaa',
                            style: GoogleFonts.montserrat(color: Colors.grey),
                          ),
                        )
                      : ListView.builder(
                          padding: const EdgeInsets.all(16),
                          itemCount: wallets.length,
                          itemBuilder: (_, index) => _buildWalletCard(wallets[index]),
                        ),
            ),
          ],
        ),
      ),
      floatingActionButton: _buildAnimatedFabMenu(),
    );
  }

  Widget _buildWalletCard(WalletData wallet) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        onTap: () {
          // Navigasi ke halaman Mutasi & Report yang baru dibuat
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportMutationPage(initialWalletId: wallet.id),
            ),
          );
        },
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xFF8C9EFF).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF8C9EFF)),
        ),
        title: Text(
          wallet.name,
          style: GoogleFonts.montserrat(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          'Saldo: Rp ${wallet.balance.toStringAsFixed(0)}',
          style: GoogleFonts.montserrat(fontSize: 13, color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit_rounded, color: Color(0xFF8C9EFF), size: 20),
              onPressed: () => openDialog(wallet),
            ),
            IconButton(
              icon: Icon(Icons.delete_rounded, color: Colors.red[300], size: 20),
              onPressed: () => _confirmDelete(wallet),
            ),
          ],
        ),
      ),
    );
  }

  // --- Fungsi UI Pendukung (Dialog, Dropdown, FAB) tetap sama tapi dirapiin ---

  void openTransferDialog() {
    sourceWalletId = null;
    targetWalletId = null;
    transferAmountController.clear();

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFCADEFC), Color(0xFFE8F0FE)],
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF8C9EFF).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.swap_horiz_rounded, color: Color(0xFF8C9EFF), size: 24),
                    ),
                    const SizedBox(width: 12),
                    Text('Transfer Saldo', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                  ],
                ),
                const SizedBox(height: 20),
                _buildLabel('Dari Dompet'),
                _buildDropdown(
                  value: sourceWalletId,
                  items: wallets,
                  onChanged: (val) => setDialogState(() => sourceWalletId = val),
                ),
                const SizedBox(height: 16),
                _buildLabel('Ke Dompet'),
                _buildDropdown(
                  value: targetWalletId,
                  items: wallets,
                  onChanged: (val) => setDialogState(() => targetWalletId = val),
                ),
                const SizedBox(height: 16),
                _buildLabel('Nominal'),
                TextField(
                  controller: transferAmountController,
                  keyboardType: TextInputType.number,
                  decoration: _inputDecoration('Rp 0'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (sourceWalletId == null || targetWalletId == null || sourceWalletId == targetWalletId) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pilih dompet yang berbeda!')));
                        return;
                      }
                      double amount = double.tryParse(transferAmountController.text) ?? 0;
                      if (amount <= 0) return;
                      await db.executeTransfer(sourceId: sourceWalletId!, targetId: targetWalletId!, amount: amount);
                      Navigator.pop(context);
                      _loadData();
                    },
                    style: _buttonStyle(),
                    child: const Text('Proses Transfer'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openDialog(WalletData? wallet) {
    nameController.text = wallet?.name ?? "";
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: const LinearGradient(colors: [Color(0xFFCADEFC), Color(0xFFE8F0FE)]),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(wallet != null ? 'Edit Wallet' : 'Add Wallet', style: GoogleFonts.montserrat(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextField(controller: nameController, decoration: _inputDecoration('Nama Dompet')),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) return;
                    wallet == null ? await insert(nameController.text) : await update(wallet.id, nameController.text);
                    Navigator.pop(context);
                  },
                  style: _buttonStyle(),
                  child: const Text('Simpan'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // --- Styles ---
  Widget _buildLabel(String text) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Text(text, style: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w500)));
  InputDecoration _inputDecoration(String hint) => InputDecoration(hintText: hint, filled: true, fillColor: Colors.white, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none));
  ButtonStyle _buttonStyle() => ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8C9EFF), foregroundColor: Colors.white, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), padding: const EdgeInsets.symmetric(vertical: 14));
  
  Widget _buildDropdown({int? value, required List<WalletData> items, required Function(int?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          isExpanded: true,
          items: items.map((w) => DropdownMenuItem(value: w.id, child: Text(w.name))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildAnimatedFabMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (isMenuOpen) ...[
          FloatingActionButton.small(
            heroTag: 'transfer_btn',
            backgroundColor: Colors.white,
            onPressed: openTransferDialog,
            child: const Icon(Icons.swap_horiz_rounded, color: Color(0xFF8C9EFF)),
          ),
          const SizedBox(height: 12),
          FloatingActionButton.small(
            heroTag: 'add_btn',
            backgroundColor: Colors.white,
            onPressed: () => openDialog(null),
            child: const Icon(Icons.add_rounded, color: Color(0xFF8C9EFF)),
          ),
          const SizedBox(height: 12),
        ],
        FloatingActionButton(
          backgroundColor: const Color(0xFF8C9EFF),
          onPressed: () => setState(() => isMenuOpen = !isMenuOpen),
          child: Icon(isMenuOpen ? Icons.close : Icons.menu_rounded, color: Colors.white),
        ),
      ],
    );
  }

  void _confirmDelete(WalletData wallet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Hapus?'),
        content: Text('Hapus "${wallet.name}"?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(onPressed: () { delete(wallet.id); Navigator.pop(context); }, child: const Text('Hapus', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}