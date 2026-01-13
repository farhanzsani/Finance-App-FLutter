import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; 
import 'package:google_fonts/google_fonts.dart';
import 'package:Monchaa/Models/database.dart';
import 'package:intl/intl.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  bool isExpense = true;
  bool isLoading = false;
  final db = AppDatabase();
  
  List<Category> categories = [];
  List<WalletData> wallets = [];
  
  int? selectedCategoryId;
  int? selectedWalletId;
  
  // LOGIK BARU: Variabel penampung data asli agar aman dari error parse
  DateTime selectedDate = DateTime.now();
  
  TextEditingController dateController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
    // Inisialisasi waktu sekarang
    selectedDate = DateTime.now();
    // Set text controller untuk tampilan awal
    dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(selectedDate);
  }

  Future<void> loadData() async {
    try {
      final cats = await db.getAllCategoryRepo(isExpense ? 2 : 1);
      final walls = await db.getAllWalletRepo();
      
      if (mounted) {
        setState(() {
          categories = cats;
          wallets = walls;
          if (categories.isNotEmpty) selectedCategoryId = categories.first.id;
          if (wallets.isNotEmpty) selectedWalletId = wallets.first.id;
        });
      }
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  Future<void> saveTransaction() async {
    // LOGIK BARU: Bersihkan titik ribuan
    String cleanAmount = amountController.text.replaceAll('.', '');
    int? finalAmount = int.tryParse(cleanAmount);

    if (finalAmount == null || 
        finalAmount <= 0 ||
        nameController.text.isEmpty ||
        selectedCategoryId == null ||
        selectedWalletId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('lengkapi dulu datanya chaaa!'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      // LOGIK BARU: Simpan pakai objek selectedDate langsung (Aman dari error parse)
      await db.insertTransactionWithWalletUpdate(
        name: nameController.text,
        categoryId: selectedCategoryId!,
        transactionDate: selectedDate, 
        amount: finalAmount, 
        walletId: selectedWalletId!,
        isExpense: isExpense,
      );

      if (mounted) Navigator.of(context).pop(true);
    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Gagal menyimpan: $e')));
    }
  }

  @override
  void dispose() {
    dateController.dispose();
    amountController.dispose();
    nameController.dispose();
    super.dispose();
  }

  // LOGIK BARU: Fungsi pilih tanggal DAN jam
  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(primary: Color(0xFF8C9EFF)),
          ),
          child: child!,
        );
      },
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDate = DateTime(
            pickedDate.year, pickedDate.month, pickedDate.day,
            pickedTime.hour, pickedTime.minute
          );
          // Update controller hanya untuk visual
          dateController.text = DateFormat('yyyy-MM-dd HH:mm').format(selectedDate);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF8C9EFF)),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Transaksi Baru",
          style: GoogleFonts.montserrat(
            color: const Color(0xFF8C9EFF),
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // DESIGN LAMA: Type Selector
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xFFCADEFC),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    _buildTypeButton("Income", Icons.download_rounded, Colors.green, !isExpense),
                    _buildTypeButton("Expense", Icons.upload_rounded, Colors.red, isExpense),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // DESIGN LAMA: Amount Input
              _buildLabel('Jumlah'),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(50),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      'Rp',
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF8C9EFF),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextFormField(
                        controller: amountController,
                        keyboardType: TextInputType.number,
                        autofocus: true,
                        // LOGIK BARU: Formatter Currency
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          CurrencyInputFormatter(),
                        ],
                        style: GoogleFonts.montserrat(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: isExpense ? Colors.red : Colors.green,
                        ),
                        decoration: InputDecoration(
                          hintText: '0',
                          hintStyle: GoogleFonts.montserrat(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[300],
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // DESIGN LAMA: Name Input
              _buildInputField(
                label: 'Deskripsi',
                controller: nameController,
                hint: 'Contoh: Makan siang, Gaji bulanan',
                icon: Icons.description_outlined,
              ),

              const SizedBox(height: 20),

              // DESIGN LAMA: Category Dropdown
              _buildLabel('Kategori'),
              const SizedBox(height: 10),
              _buildCustomContainer(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: selectedCategoryId,
                    hint: Text("Pilih kategori", style: GoogleFonts.montserrat(color: Colors.grey[400])),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8C9EFF)),
                    items: categories.map((cat) {
                      return DropdownMenuItem(
                        value: cat.id,
                        child: Row(
                          children: [
                            Text(cat.name, style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => selectedCategoryId = value),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // DESIGN LAMA: Wallet Dropdown
              _buildLabel('Wallet'),
              const SizedBox(height: 10),
              _buildCustomContainer(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<int>(
                    isExpanded: true,
                    value: selectedWalletId,
                    hint: Text("Pilih wallet", style: GoogleFonts.montserrat(color: Colors.grey[400])),
                    icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF8C9EFF)),
                    items: wallets.map((wallet) {
                      return DropdownMenuItem(
                        value: wallet.id,
                        child: Text(wallet.name, style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w600)),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => selectedWalletId = value),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // DESIGN LAMA: Date Picker (Updated logic)
              _buildLabel('Tanggal & Waktu'),
              const SizedBox(height: 10),
              _buildCustomContainer(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: const Icon(Icons.calendar_today_rounded, color: Color(0xFF8C9EFF), size: 20),
                  title: Text(
                    DateFormat('EEEE, dd MMMM yyyy HH:mm', 'id_ID').format(selectedDate),
                    style: GoogleFonts.montserrat(fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  trailing: const Icon(Icons.access_time_filled_rounded, color: Color(0xFF8C9EFF)),
                  onTap: _pickDateTime, // Panggil fungsi gabungan tanggal & jam
                ),
              ),

              const SizedBox(height: 40),

              // DESIGN LAMA: Save Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isLoading ? null : saveTransaction,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF8C9EFF),
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    shadowColor: const Color(0xFF8C9EFF).withAlpha(40),
                  ),
                  child: isLoading
                      ? const SizedBox(height: 24, width: 24, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.check_circle_outline, size: 24),
                            const SizedBox(width: 8),
                            Text('Simpan Transaksi', style: GoogleFonts.montserrat(fontSize: 16, fontWeight: FontWeight.w600)),
                          ],
                        ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // --- UI Helpers (Design Lama) ---

 Widget _buildTypeButton(String title, IconData icon, Color color, bool isActive) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpense = (title == "Expense");
            loadData();
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            color: isActive ? color : Colors.transparent, 
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon, 
                color: isActive ? Colors.white : Color(0xFF8C9EFF), 
                size: 22
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.montserrat(
                  color: isActive ? Colors.white : Color(0xFF8C9EFF),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomContainer({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black.withAlpha(50), blurRadius: 10, offset: const Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }

  Widget _buildInputField({required String label, required TextEditingController controller, required String hint, required IconData icon}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        const SizedBox(height: 10),
        _buildCustomContainer(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.montserrat(color: Colors.grey[300], fontSize: 14),
              prefixIcon: Icon(icon, color: const Color(0xFF8C9EFF), size: 20),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: GoogleFonts.montserrat(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[700]));
  }
}

// LOGIK BARU: Class Formatter untuk titik ribuan otomatis
class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) return newValue;

    String cleanText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleanText.isEmpty) return newValue.copyWith(text: '');

    double value = double.parse(cleanText);
    final formatter = NumberFormat.currency(locale: 'id_ID', symbol: '', decimalDigits: 0);
    String newText = formatter.format(value).trim();

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}