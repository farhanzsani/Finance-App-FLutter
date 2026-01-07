import 'package:drift/drift.dart';

class Transfers extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get source_wallet_id => integer()();
  IntColumn get target_wallet_id => integer()();
  RealColumn get amount => real()();
  DateTimeColumn get transfer_date => dateTime()();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get created => dateTime()();
  DateTimeColumn get updated_at => dateTime()();
}