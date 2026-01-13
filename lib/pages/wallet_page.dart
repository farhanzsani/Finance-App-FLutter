import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:Monchaa/Models/database.dart';
import 'package:Monchaa/pages/transaction_history_page.dart';
import 'package:Monchaa/pages/transfer_history_page.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final AppDatabase db = AppDatabase();
  bool isMenuOpen = false;

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController transferAmountController = TextEditingController();

  // Data State
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
    setState(() {
      wallets = data;
      isLoading = false;
    });
  }

  /// ===============================
  /// DATABASE FUNCTIONS
  /// ===============================
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

  /// ===============================
  /// UNIFIED DIALOG DESIGN
  /// ===============================

  void openTransferDialog() {
    // Reset state dialog
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
                // Header
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
                    Expanded(
                      child: Text(
                        'Transfer Saldo',
                        style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
                      ),
                    ),
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.close, color: Colors.grey[600]),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Dropdown Dari
                _buildLabel('Dari Dompet'),
                _buildDropdown(
                  value: sourceWalletId,
                  items: wallets,
                  onChanged: (val) => setDialogState(() => sourceWalletId = val),
                ),
                const SizedBox(height: 16),

                // Dropdown Ke
                _buildLabel('Ke Dompet'),
                _buildDropdown(
                  value: targetWalletId,
                  items: wallets,
                  onChanged: (val) => setDialogState(() => targetWalletId = val),
                ),
                const SizedBox(height: 16),

                // Input Nominal
                _buildLabel('Nominal Transfer'),
                TextField(
                  controller: transferAmountController,
                  keyboardType: TextInputType.number,
                  style: GoogleFonts.montserrat(fontSize: 16),
                  decoration: _inputDecoration('Rp 0'),
                ),
                const SizedBox(height: 24),

                // Action Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (sourceWalletId == null || targetWalletId == null || sourceWalletId == targetWalletId) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Pilih dompet yang berbeda chaaa!')),
                        );
                        return;
                      }
                      double amount = double.tryParse(transferAmountController.text) ?? 0;
                      if (amount <= 0) return;

                      try {
                        await db.executeTransfer(
                          sourceId: sourceWalletId!,
                          targetId: targetWalletId!,
                          amount: amount,
                        );
                        Navigator.pop(context);
                        _loadData();
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      }
                    },
                    style: _buttonStyle(),
                    child: Text('Proses Transfer', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16)),
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
    if (wallet != null) {
      nameController.text = wallet.name;
    } else {
      nameController.clear();
    }

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
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
                    child: Icon(wallet != null ? Icons.edit_rounded : Icons.add_rounded, color: const Color(0xFF8C9EFF), size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      wallet != null ? 'Edit Wallet' : 'Add Wallet',
                      style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
                    ),
                  ),
                  IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close, color: Colors.grey[600])),
                ],
              ),
              const SizedBox(height: 24),
              _buildLabel('Wallet Name'),
              TextFormField(
                controller: nameController,
                autofocus: true,
                style: GoogleFonts.montserrat(fontSize: 16),
                decoration: _inputDecoration('Masukkan nama dompet'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.trim().isEmpty) return;
                    wallet == null ? await insert(nameController.text) : await update(wallet.id, nameController.text);
                    Navigator.pop(context);
                  },
                  style: _buttonStyle(),
                  child: Text('Save Wallet', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ===============================
  /// UI BUILDERS & STYLES
  /// ===============================

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[700])),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide(color: Colors.grey[200]!)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: Color(0xFF8C9EFF), width: 2)),
    );
  }

  ButtonStyle _buttonStyle() {
    return ElevatedButton.styleFrom(
      backgroundColor: const Color(0xFF8C9EFF),
      foregroundColor: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 16),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildDropdown({int? value, required List<WalletData> items, required Function(int?) onChanged}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: value,
          isExpanded: true,
          hint: Text("Pilih Dompet", style: GoogleFonts.montserrat(fontSize: 14)),
          items: items.map((w) => DropdownMenuItem(value: w.id, child: Text(w.name, style: GoogleFonts.montserrat()))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: Text('Wallets', style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7FA),
        foregroundColor: const Color(0xFF8C9EFF),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : wallets.isEmpty
              ? const Center(child: Text('Belum ada wallet nih chaa'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: wallets.length,
                  itemBuilder: (_, index) => _buildWalletCard(wallets[index]),
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
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: ListTile(
        onTap: () => _showWalletOptions(wallet),
        leading: const Icon(Icons.account_balance_wallet_rounded, color: Color(0xFF8C9EFF)),
        title: Text(wallet.name, style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
        subtitle: Text('Saldo: Rp ${wallet.balance.toStringAsFixed(0)}', style: GoogleFonts.montserrat(fontSize: 14, color: Colors.grey[600])),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit_rounded, color: Color(0xFF8C9EFF)), onPressed: () => openDialog(wallet)),
            IconButton(icon: Icon(Icons.delete_rounded, color: Colors.red[300]), onPressed: () => _confirmDelete(wallet)),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedFabMenu() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        AnimatedSlide(
          duration: const Duration(milliseconds: 300),
          offset: isMenuOpen ? Offset.zero : const Offset(0, 0.5),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 300),
            opacity: isMenuOpen ? 1.0 : 0.0,
            child: FloatingActionButton.small(
              heroTag: 'transfer_btn',
              backgroundColor: Colors.white,
              onPressed: isMenuOpen ? openTransferDialog : null,
              child: const Icon(Icons.swap_horiz_rounded, color: Color(0xFF8C9EFF)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        AnimatedSlide(
          duration: const Duration(milliseconds: 200),
          offset: isMenuOpen ? Offset.zero : const Offset(0, 0.5),
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isMenuOpen ? 1.0 : 0.0,
            child: FloatingActionButton.small(
              heroTag: 'add_btn',
              backgroundColor: Colors.white,
              onPressed: isMenuOpen ? () => openDialog(null) : null,
              child: const Icon(Icons.add_rounded, color: Color(0xFF8C9EFF)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          backgroundColor: const Color(0xFF8C9EFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () => setState(() => isMenuOpen = !isMenuOpen),
          child: AnimatedRotation(
            duration: const Duration(milliseconds: 300),
            turns: isMenuOpen ? 0.25 : 0,
            child: Icon(isMenuOpen ? Icons.close : Icons.menu_rounded, color: Colors.white, size: 28),
          ),
        ),
      ],
    );
  }

  void _showWalletOptions(WalletData wallet) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(Icons.history),
            title: const Text('Riwayat Transaksi'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c) => TransactionHistoryPage(wallet: wallet, db: db)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.swap_horiz),
            title: const Text('Riwayat Transfer'),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (c) => TransferHistoryPage(wallet: wallet)));
            },
          ),
        ],
      ),
    );
  }

  void _confirmDelete(WalletData wallet) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Wallet?'),
        content: Text('Yakin mau hapus "${wallet.name}" ini chaaa?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Batal')),
          TextButton(onPressed: () { delete(wallet.id); Navigator.pop(context); }, child: const Text('Hapus', style: TextStyle(color: Colors.red))),
        ],
      ),
    );
  }
}