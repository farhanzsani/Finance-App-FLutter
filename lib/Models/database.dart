import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'category.dart';
import 'transaction.dart';
import 'wallet.dart';
import 'transfer.dart';

part 'database.g.dart';



@DriftDatabase(
  tables: [Categories, Transactions, Wallet, Transfers],
)



class TransferWithWalletNames {
  final Transfer transfer;
  final String sourceName;
  final String targetName;

  TransferWithWalletNames({
    required this.transfer,
    required this.sourceName,
    required this.targetName,
  });
}

class TransactionWithWallet {
  final Transaction transaction;
  final String walletName;

  TransactionWithWallet({
    required this.transaction,
    required this.walletName,
  });
}

class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

 @override
  int get schemaVersion => 4; // NAIK ke 4!

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) await m.createTable(wallet);
        if (from < 3) await m.addColumn(transactions, transactions.wallet_id);
        if (from < 4) await m.createTable(transfers); // Migrasi ke tabel transfer
      },
    );
  }
  // crud category
  Future<List<Category>>getAllCategoryRepo(int type) async {
    return await (select(categories)..where((tbl) => tbl.type.equals(type))).get();
  }

  Future updateCategoryRepo(int id, String name) async {
    return (update(categories)..where((tbl) => tbl.id.equals(id))).write(
      CategoriesCompanion(
        name: Value(name),
        updated_at: Value(DateTime.now()),
      )
    );
  }

  Future deleteCategoryRepo(int id) async {
    return (delete(categories)..where((tbl) => tbl.id.equals(id))).go();
  }


  // crud wallet
  Future<List<WalletData>> getAllWalletRepo() async {
      return await select(wallet).get();
  }


  Future updateDataWalletRepo(int id, String name) async {
    return (update(wallet)..where((tbl) => tbl.id.equals(id))).write(
      WalletCompanion(
        name: Value(name),
        updated_at: Value(DateTime.now()),
      )
    );
  }

  updatebalanceWalletRepo(int id, double balance) async {
    return (update(wallet)..where((tbl) => tbl.id.equals(id))).write(
      WalletCompanion(
        balance: Value(balance),
        updated_at: Value(DateTime.now()),
      )
    );
  }

  Future deleteWalletRepo(int id) async {
    return (delete(wallet)..where((tbl) => tbl.id.equals(id))).go();
  }


  // CRUD Transaction
  Future<int> insertTransaction(TransactionsCompanion transaction) async {
  return await into(transactions).insert(transaction);
}

Future<List<Transaction>> getAllTransactions() async {
  return await select(transactions).get();
}

Future<List<TransactionWithWallet>> getTransactionsByWallet(int walletId) async {
  final query = select(transactions).join([
    innerJoin(wallet, wallet.id.equalsExp(transactions.wallet_id)),
  ])
    ..where(transactions.wallet_id.equals(walletId))
    ..orderBy([OrderingTerm.desc(transactions.transaction_date)]);

  final result = await query.get();

  return result.map((row) {
    return TransactionWithWallet(
      transaction: row.readTable(transactions),
      walletName: row.readTable(wallet).name,
    );
  }).toList();
}



Future<void> updateTransaction(int id, TransactionsCompanion transaction) async {
  await (update(transactions)..where((tbl) => tbl.id.equals(id)))
    .write(transaction);
}

Future<void> deleteTransaction(int id) async {
  await (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();
}

// Insert transaction WITH wallet update
Future<void> insertTransactionWithWalletUpdate({
  required String name,
  required int categoryId,
  required DateTime transactionDate,
  required int amount,
  required int walletId,
  required bool isExpense,
}) async {
  final now = DateTime.now();
  
  try {
    // 1. Insert transaction first
    await into(transactions).insert(
      TransactionsCompanion.insert(
        name: name,
        category_id: categoryId,
        wallet_id: walletId,
        transaction_date: transactionDate,
        amount: amount,
        created: now,
        updated_at: now,
      ),
    );
    
    // 2. Get current wallet balance
    final walletData = await (select(wallet)
      ..where((tbl) => tbl.id.equals(walletId))).getSingle();
    
    // 3. Calculate new balance
    double newBalance;
    if (isExpense) {
      newBalance = walletData.balance - amount;
    } else {
      newBalance = walletData.balance + amount;
    }
    
    // 4. Update wallet balance
    await (update(wallet)..where((tbl) => tbl.id.equals(walletId))).write(
      WalletCompanion(
        balance: Value(newBalance),
        updated_at: Value(now),
      ),
    );
  } catch (e) {
    print('Error in insertTransactionWithWalletUpdate: $e');
    rethrow;
  }
}

// Delete transaction WITH wallet balance restoration
Future<void> deleteTransactionWithWalletUpdate(int transactionId) async {
  try {
    // 1. Get transaction data
    final transaction = await (select(transactions)
      ..where((tbl) => tbl.id.equals(transactionId))).getSingle();
    
    // 2. Get category to know if income/expense
    final category = await (select(categories)
      ..where((tbl) => tbl.id.equals(transaction.category_id))).getSingle();
    
    // 3. Get wallet
    final walletData = await (select(wallet)
      ..where((tbl) => tbl.id.equals(transaction.wallet_id))).getSingle();
    
    // 4. Restore wallet balance (reverse the transaction)
    bool isExpense = category.type == 2;
    double newBalance = isExpense
      ? walletData.balance + transaction.amount // add back
      : walletData.balance - transaction.amount; // subtract back
    
    await (update(wallet)..where((tbl) => tbl.id.equals(transaction.wallet_id))).write(
      WalletCompanion(
        balance: Value(newBalance),
        updated_at: Value(DateTime.now()),
      ),
    );
    
    // 5. Delete transaction
    await (delete(transactions)..where((tbl) => tbl.id.equals(transactionId))).go();
  } catch (e) {
    print('Error in deleteTransactionWithWalletUpdate: $e');
    rethrow;
  }
}

Future<void> executeTransfer({
    required int sourceId,
    required int targetId,
    required double amount,
    String? notes,
  }) async {
    await transaction(() async {
      final now = DateTime.now();
      
      // 1. Catat di tabel Transfers
      await into(transfers).insert(TransfersCompanion.insert(
        source_wallet_id: sourceId,
        target_wallet_id: targetId,
        amount: amount,
        transfer_date: now,
        notes: Value(notes),
        created: now,
        updated_at: now,
      ));

      // 2. Kurangi Saldo Asal
      final sWallet = await (select(wallet)..where((t) => t.id.equals(sourceId))).getSingle();
      await (update(wallet)..where((t) => t.id.equals(sourceId))).write(
        WalletCompanion(balance: Value(sWallet.balance - amount), updated_at: Value(now))
      );

      // 3. Tambah Saldo Tujuan
      final tWallet = await (select(wallet)..where((t) => t.id.equals(targetId))).getSingle();
      await (update(wallet)..where((t) => t.id.equals(targetId))).write(
        WalletCompanion(balance: Value(tWallet.balance + amount), updated_at: Value(now))
      );
    });
  }

  // Ambil data transfer khusus untuk satu wallet (masuk atau keluar)
  Future<List<TransferWithWalletNames>> getTransfersByWallet(int walletId) async {
    final sourceWallet = alias(wallet, 'src');
    final targetWallet = alias(wallet, 'dest');

    final query = select(transfers).join([
      innerJoin(sourceWallet, sourceWallet.id.equalsExp(transfers.source_wallet_id)),
      innerJoin(targetWallet, targetWallet.id.equalsExp(transfers.target_wallet_id)),
    ])
      ..where(transfers.source_wallet_id.equals(walletId) | transfers.target_wallet_id.equals(walletId))
      ..orderBy([OrderingTerm.desc(transfers.transfer_date)]);

    final result = await query.get();

    return result.map((row) {
      return TransferWithWalletNames(
        transfer: row.readTable(transfers),
        sourceName: row.readTable(sourceWallet).name,
        targetName: row.readTable(targetWallet).name,
      );
    }).toList();
  }


  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'my_database',
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
    );
  }
}
