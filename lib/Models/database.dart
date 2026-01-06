import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'category.dart';
import 'transaction.dart';
import 'wallet.dart';

part 'database.g.dart';



@DriftDatabase(
  tables: [Categories, Transactions, Wallet],
)
class AppDatabase extends _$AppDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 2;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(wallet); // wallets itu nama tabel dari drift
        }
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
