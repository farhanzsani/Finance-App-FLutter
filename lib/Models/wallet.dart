import 'package:drift/drift.dart';



class Wallet extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 128)();
  RealColumn get balance => real().withDefault(const Constant(0))();
  DateTimeColumn get created => dateTime()();
  DateTimeColumn get updated_at => dateTime()();
  DateTimeColumn get deleted_at => dateTime().nullable()();
}