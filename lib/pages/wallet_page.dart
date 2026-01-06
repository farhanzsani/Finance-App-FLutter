import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:finance_app_for_nacha/Models/database.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  final AppDatabase db = AppDatabase();
  final TextEditingController nameController = TextEditingController();

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
  }

  Future<List<WalletData>> getAllWallets() {
    return db.getAllWalletRepo();
  }

  Future<void> update(int id, String name) {
    return db.updateDataWalletRepo(id, name);
  }

  Future<void> delete(int id) {
    return db.deleteWalletRepo(id);
  }

  /// ===============================
  /// ADD / EDIT DIALOG
  /// ===============================
void openDialog(WalletData? wallet) {
  if (wallet != null) {
    nameController.text = wallet.name;
  } else {
    nameController.clear();
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFCADEFC),
                Color(0xFFE8F0FE),
              ],
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
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color(0xFF8C9EFF).withAlpha(50),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      wallet != null ? Icons.edit_rounded : Icons.add_rounded,
                      color: Color(0xFF8C9EFF),
                      size: 24,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      wallet != null ? 'Edit Wallet' : 'Add Wallet',
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, color: Colors.grey[600]),
                    splashRadius: 20,
                  ),
                ],
              ),
              SizedBox(height: 24),
              Text(
                'Wallet Name',
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[700],
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                autofocus: true,
                style: GoogleFonts.montserrat(fontSize: 16),
                decoration: InputDecoration(
                  hintText: 'Enter wallet name',
                  hintStyle: GoogleFonts.montserrat(
                    color: Colors.grey[400],
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[200]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xFF8C9EFF),
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        if (nameController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Please enter a wallet name'),
                              backgroundColor: Colors.red,
                            ),
                          );
                          return;
                        }

                        if (wallet == null) {
                          await insert(nameController.text);
                        } else {
                          await update(wallet.id, nameController.text);
                        }

                        Navigator.pop(context);
                        setState(() {});
                        nameController.clear();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF8C9EFF),
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: GoogleFonts.montserrat(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

  /// ===============================
  /// UI
  /// ===============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text('Wallets'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7FA),
        foregroundColor: const Color(0xFF8C9EFF),
        elevation: 0,
      ),

      body: FutureBuilder<List<WalletData>>(
        future: getAllWallets(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No wallets yet'));
          }

          final wallets = snapshot.data!;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: wallets.length,
            itemBuilder: (_, index) {
              final wallet = wallets[index];

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(40),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  leading: const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Color(0xFF8C9EFF),
                  ),
                  title: Text(
                    wallet.name,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit_rounded),
                        color: const Color(0xFF8C9EFF),
                        onPressed: () => openDialog(wallet),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete_rounded),
                        color: Colors.red[300],
                        onPressed: () async {
                          await delete(wallet.id);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8C9EFF),
         shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        onPressed: () => openDialog(null),
        child: const Icon(Icons.add),
      ),
    );
  }
}
