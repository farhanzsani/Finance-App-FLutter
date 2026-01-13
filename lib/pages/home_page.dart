import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:Monchaa/Models/database.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  final DateTime? selectedDate;
  
  const HomePage({super.key, this.selectedDate});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppDatabase db = AppDatabase();
  bool showAllTime = false; 

  List<Category> categories = [];
  List<WalletData> wallets = [];

  Future<void> loadCategoriesAndWallets() async {
    categories = await db.select(db.categories).get();
    wallets = await db.select(db.wallet).get();
  }

  Future<void> showEditTransactionDialog(BuildContext context, TransactionWithCategory item) async {
    await loadCategoriesAndWallets();
    final TextEditingController editNameController = TextEditingController(text: item.transaction.name);
    final TextEditingController editAmountController = TextEditingController(text: item.transaction.amount.toString());
    int editCategoryId = item.category.id;
    int editWalletId = item.wallet.id;
    DateTime editDate = item.transaction.transaction_date;
    bool editIsExpense = item.category.type == 2;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              title: Text('Edit Transaksi', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => editIsExpense = false),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: !editIsExpense ? Colors.green : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.download_rounded, color: !editIsExpense ? Colors.white : const Color(0xFF8C9EFF), size: 22),
                                  const SizedBox(width: 8),
                                  Text('Income', style: GoogleFonts.montserrat(color: !editIsExpense ? Colors.white : const Color(0xFF8C9EFF), fontSize: 15, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: () => setState(() => editIsExpense = true),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              decoration: BoxDecoration(
                                color: editIsExpense ? Colors.red : Colors.transparent,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.upload_rounded, color: editIsExpense ? Colors.white : const Color(0xFF8C9EFF), size: 22),
                                  const SizedBox(width: 8),
                                  Text('Expense', style: GoogleFonts.montserrat(color: editIsExpense ? Colors.white : const Color(0xFF8C9EFF), fontSize: 15, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text('Jumlah', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: editAmountController,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      style: GoogleFonts.montserrat(fontSize: 20, fontWeight: FontWeight.bold, color: editIsExpense ? Colors.red : Colors.green),
                      decoration: InputDecoration(hintText: '0', border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
                    ),
                    const SizedBox(height: 16),
                    Text('Deskripsi', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: editNameController,
                      decoration: InputDecoration(
                        hintText: 'Contoh: Makan siang, Gaji bulanan',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        prefixIcon: const Icon(Icons.description_outlined, color: Color(0xFF8C9EFF), size: 20),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text('Kategori', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                    const SizedBox(height: 8),
                    DropdownButton<int>(
                      isExpanded: true,
                      value: editCategoryId,
                      items: categories.map((cat) => DropdownMenuItem(value: cat.id, child: Text(cat.name))).toList(),
                      onChanged: (val) => setState(() { if (val != null) editCategoryId = val; }),
                    ),
                    const SizedBox(height: 16),
                    Text('Wallet', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                    const SizedBox(height: 8),
                    DropdownButton<int>(
                      isExpanded: true,
                      value: editWalletId,
                      items: wallets.map((w) => DropdownMenuItem(value: w.id, child: Text(w.name))).toList(),
                      onChanged: (val) => setState(() { if (val != null) editWalletId = val; }),
                    ),
                    const SizedBox(height: 16),
                    Text('Tanggal & Waktu', style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700])),
                    const SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.calendar_today_rounded, color: Color(0xFF8C9EFF), size: 20),
                      title: Text(DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID').format(editDate), style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500)),
                      trailing: const Icon(Icons.access_time_filled_rounded, color: Color(0xFF8C9EFF)),
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: editDate,
                          firstDate: DateTime(2020),
                          lastDate: DateTime(2101),
                        );
                        if (pickedDate != null) {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(editDate),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              editDate = DateTime(
                                pickedDate.year, pickedDate.month, pickedDate.day,
                                pickedTime.hour, pickedTime.minute
                              );
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Batal', style: GoogleFonts.montserrat()),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String cleanAmount = editAmountController.text.replaceAll('.', '');
                    int? finalAmount = int.tryParse(cleanAmount);
                    if (finalAmount == null || finalAmount <= 0 || editNameController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('lengkapi dulu datanya chaaa!'), backgroundColor: Colors.red));
                      return;
                    }
                    await db.editTransactionWithWalletUpdate(
                      transactionId: item.transaction.id,
                      name: editNameController.text,
                      categoryId: editCategoryId,
                      transactionDate: editDate,
                      amount: finalAmount,
                      walletId: editWalletId,
                      isExpense: editIsExpense,
                    );
                    if (mounted) Navigator.pop(context, true);
                  },
                  child: Text('Simpan', style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<List<TransactionWithCategory>> getTransactionsByDate(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final query = db.select(db.transactions).join([
      innerJoin(
        db.categories,
        db.categories.id.equalsExp(db.transactions.category_id),
      ),
      innerJoin(
        db.wallet,
        db.wallet.id.equalsExp(db.transactions.wallet_id),
      ),
    ])
      ..where(db.transactions.transaction_date.isBetweenValues(startOfDay, endOfDay))
      ..orderBy([OrderingTerm.desc(db.transactions.transaction_date)]);

    final results = await query.get();

    return results.map((row) {
      return TransactionWithCategory(
        transaction: row.readTable(db.transactions),
        category: row.readTable(db.categories),
        wallet: row.readTable(db.wallet),
      );
    }).toList();
  }

  // Calculate total income by date
  Future<int> getTotalIncome(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final query = db.select(db.transactions).join([
      innerJoin(
        db.categories,
        db.categories.id.equalsExp(db.transactions.category_id),
      ),
    ])
      ..where(db.transactions.transaction_date.isBetweenValues(startOfDay, endOfDay))
      ..where(db.categories.type.equals(1));

    final results = await query.get();
    
    int total = 0;
    for (var row in results) {
      final transaction = row.readTable(db.transactions);
      total += transaction.amount;
    }
    
    return total;
  }

  // Calculate total expense by date
  Future<int> getTotalExpense(DateTime date) async {
    final startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
    final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

    final query = db.select(db.transactions).join([
      innerJoin(
        db.categories,
        db.categories.id.equalsExp(db.transactions.category_id),
      ),
    ])
      ..where(db.transactions.transaction_date.isBetweenValues(startOfDay, endOfDay))
      ..where(db.categories.type.equals(2));

    final results = await query.get();
    
    int total = 0;
    for (var row in results) {
      final transaction = row.readTable(db.transactions);
      total += transaction.amount;
    }
    
    return total;
  }

  // Calculate total income ALL TIME
  Future<int> getTotalIncomeAllTime() async {
    final query = db.select(db.transactions).join([
      innerJoin(
        db.categories,
        db.categories.id.equalsExp(db.transactions.category_id),
      ),
    ])
      ..where(db.categories.type.equals(1));

    final results = await query.get();
    
    int total = 0;
    for (var row in results) {
      final transaction = row.readTable(db.transactions);
      total += transaction.amount;
    }
    
    return total;
  }

  // Calculate total expense ALL TIME
  Future<int> getTotalExpenseAllTime() async {
    final query = db.select(db.transactions).join([
      innerJoin(
        db.categories,
        db.categories.id.equalsExp(db.transactions.category_id),
      ),
    ])
      ..where(db.categories.type.equals(2));

    final results = await query.get();
    
    int total = 0;
    for (var row in results) {
      final transaction = row.readTable(db.transactions);
      total += transaction.amount;
    }
    
    return total;
  }

  // Format currency
  String formatCurrency(int amount) {
    final formatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp ',
      decimalDigits: 0,
    );
    return formatter.format(amount);
  }

  // Delete transaction with wallet update
  Future<void> deleteTransaction(Transaction transaction) async {
    try {
      final category = await (db.select(db.categories)
        ..where((tbl) => tbl.id.equals(transaction.category_id))).getSingle();
      
      final wallet = await (db.select(db.wallet)
        ..where((tbl) => tbl.id.equals(transaction.wallet_id))).getSingle();
      
      bool isExpense = category.type == 2;
      double newBalance = isExpense
        ? wallet.balance + transaction.amount
        : wallet.balance - transaction.amount;
      
      await db.updatebalanceWalletRepo(transaction.wallet_id, newBalance);
      await (db.delete(db.transactions)..where((tbl) => tbl.id.equals(transaction.id))).go();
      
      setState(() {});
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaksi berhasil dihapus chaaa'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Show dialog to edit transaction
  void _showEditTransactionDialog(TransactionWithCategory item) async {
    final transaction = item.transaction;
    final nameController = TextEditingController(text: transaction.name);
    final amountController = TextEditingController(text: transaction.amount.toString());
    DateTime selectedDateTime = transaction.transaction_date;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text('Edit Transaksi', style: GoogleFonts.montserrat(fontWeight: FontWeight.w600)),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Nama Transaksi'),
                ),
                SizedBox(height: 12),
                TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Jumlah'),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        DateFormat('dd MMM yyyy • HH:mm').format(selectedDateTime),
                        style: GoogleFonts.montserrat(fontSize: 13),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_today, size: 20),
                      onPressed: () async {
                        final pickedDate = await showDatePicker(
                          context: context,
                          initialDate: selectedDateTime,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        );
                        if (pickedDate != null) {
                          final pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.fromDateTime(selectedDateTime),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedDateTime = DateTime(
                                pickedDate.year,
                                pickedDate.month,
                                pickedDate.day,
                                pickedTime.hour,
                                pickedTime.minute,
                              );
                            });
                          }
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Text('Kategori: ${item.category.name}', style: GoogleFonts.montserrat(fontSize: 13, color: Colors.grey[600])),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text('Wallet: ${item.wallet.name}', style: GoogleFonts.montserrat(fontSize: 13, color: Colors.grey[600])),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Batal', style: GoogleFonts.montserrat(color: Colors.grey[600])),
            ),
            TextButton(
              onPressed: () async {
                final newName = nameController.text.trim();
                final newAmount = int.tryParse(amountController.text.trim()) ?? transaction.amount;
                if (newName.isEmpty || newAmount <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Nama dan jumlah harus diisi dengan benar chaa')),
                  );
                  return;
                }
                final updatedTransaction = transaction.copyWith(
                  name: newName,
                  amount: newAmount,
                  transaction_date: selectedDateTime,
                );
                await db.editTransactionWithWalletUpdate(
                  transactionId: updatedTransaction.id,
                  name: updatedTransaction.name,
                  categoryId: updatedTransaction.category_id,
                  transactionDate: updatedTransaction.transaction_date,
                  amount: updatedTransaction.amount,
                  walletId: updatedTransaction.wallet_id,
                  isExpense: item.category.type == 2,
                );
                setState(() {});
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Transaksi berhasil diupdate chaaa'), backgroundColor: Colors.green),
                );
              },
              child: Text('Simpan', style: GoogleFonts.montserrat(color: Color(0xFF8C9EFF), fontWeight: FontWeight.w600)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = widget.selectedDate ?? DateTime.now();

    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Toggle Button untuk Daily vs All Time
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFE8F0FE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showAllTime = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: !showAllTime ? Color(0xFF8C9EFF) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Hari Ini',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              color: !showAllTime ? Colors.white : Color(0xFF8C9EFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showAllTime = true;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            color: showAllTime ? Color(0xFF8C9EFF) : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text(
                            'Keseluruhan',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(
                              color: showAllTime ? Colors.white : Color(0xFF8C9EFF),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Dashboard
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF8C9EFF),
                      Color(0xFFCADEFC),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFF8C9EFF).withAlpha(30),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: FutureBuilder<List<int>>(
                  future: showAllTime
                      ? Future.wait([
                          getTotalIncomeAllTime(),
                          getTotalExpenseAllTime(),
                        ])
                      : Future.wait([
                          getTotalIncome(selectedDate),
                          getTotalExpense(selectedDate),
                        ]),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        ),
                      );
                    }

                    final totalIncome = snapshot.data![0];
                    final totalExpense = snapshot.data![1];
                    final balance = totalIncome - totalExpense;

                    return Column(
                      children: [
                        // Date or "All Time" indicator
                        Text(
                          showAllTime
                              ? 'Total Keseluruhan'
                              : DateFormat('dd MMMM yyyy', 'id_ID')
                                  .format(selectedDate),
                          style: GoogleFonts.montserrat(
                            color: Colors.white.withAlpha(90),
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(height: 8),
                        // Balance
                        Column(
                          children: [
                            Text(
                              "Saldo",
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              formatCurrency(balance),
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        Divider(color: Colors.white.withAlpha(30)),
                        SizedBox(height: 16),
                        // Income & Expense
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Income
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.download,
                                      color: Colors.green,
                                      size: 18,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "Income",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.green,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  formatCurrency(totalIncome),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            // Expense
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.upload,
                                      color: Colors.red,
                                      size: 18,
                                    ),
                                    SizedBox(width: 6),
                                    Text(
                                      "Expense",
                                      style: GoogleFonts.montserrat(
                                        color: Colors.red,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 6),
                                Text(
                                  formatCurrency(totalExpense),
                                  style: GoogleFonts.montserrat(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),

            // Section title
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Transaksi Hari Ini",
                style: GoogleFonts.montserrat(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // List transaksi (always show daily)
            FutureBuilder<List<TransactionWithCategory>>(
              future: getTransactionsByDate(selectedDate),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: CircularProgressIndicator(
                        color: Color(0xFF8C9EFF),
                      ),
                    ),
                  );
                }

                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          Icon(
                            Icons.receipt_long_outlined,
                            size: 64,
                            color: Colors.grey[300],
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Hari ini belom ada transaksi nih chaa',
                            style: GoogleFonts.montserrat(
                              fontSize: 16,
                              color: Colors.grey[500],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final transactions = snapshot.data!;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final item = transactions[index];
                    final transaction = item.transaction;
                    final category = item.category;
                    final isExpense = category.type == 2;

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isExpense
                                  ? Colors.red.withAlpha(10)
                                  : Colors.green.withAlpha(10),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              isExpense ? Icons.upload : Icons.download,
                              color: isExpense ? Colors.red : Colors.green,
                            ),
                          ),
                          title: Text(
                            transaction.name,
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 4),
                              
                              Text(
                                category.name,
                                style: GoogleFonts.montserrat(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),

                              SizedBox(height: 2),
                          
                              Text(
                                item.wallet.name.toString(), 
                                style: GoogleFonts.montserrat(
                                  fontSize: 11,
                                  color: Colors.grey[500],
                                ),
                              ),

                              Text(
                                DateFormat('dd MMM yyyy • HH:mm').format(transaction.transaction_date),
                                style: GoogleFonts.montserrat(
                                  fontSize: 10,
                                  color: Colors.grey[600],
                                ),
                              ),


                             
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                formatCurrency(transaction.amount),
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: isExpense ? Colors.red : Colors.green,
                                ),
                              ),
                              SizedBox(height: 4),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      _showEditTransactionDialog(item);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: const Color(0xFF8C9EFF),
                                      size: 20,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  InkWell(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          title: Text(
                                            'Hapus Transaksi',
                                            style: GoogleFonts.montserrat(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          content: Text(
                                            'Yakin mau hapus transaksi "${transaction.name} chaa"?',
                                            style: GoogleFonts.montserrat(),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.pop(context),
                                              child: Text(
                                                'Batal',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                deleteTransaction(transaction);
                                                Navigator.pop(context);
                                              },
                                              child: Text(
                                                'Hapus',
                                                style: GoogleFonts.montserrat(
                                                  color: Colors.red,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Icon(
                                      Icons.delete,
                                      color: Colors.red[300],
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}

class TransactionWithCategory {
  final Transaction transaction;
  final Category category;
  final WalletData wallet;

  TransactionWithCategory({
    required this.transaction,
    required this.category,
    required this.wallet,
  });
}