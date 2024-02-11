import 'package:sqflite/sqflite.dart';
import 'package:wangku/core/data/services/sqlite_service.dart';
import 'package:wangku/features/wallet/data/models/wallet_model.dart';

class WalletService {
  final _sqliteService = SqliteService();

  Future<int> getAccountBalance() async {
    try {
      final database = await _sqliteService.database;
      final maps = await database.rawQuery('SELECT SUM(balance) FROM wallets');
      final balance = maps[0]['SUM(balance)'] as int?;
      return balance ?? 0;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> isWalletExist() async {
    try {
      final database = await _sqliteService.database;
      final maps = await database.query(
        'wallets',
        limit: 1,
      );
      return maps.isEmpty ? false : true;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> createWallet(WalletModel wallet) async {
    try {
      final database = await _sqliteService.database;

      await database.insert(
        'wallets',
        wallet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<WalletModel>> getAllWallets() async {
    try {
      final database = await _sqliteService.database;
      final maps = await database.query('wallets');
      final wallets = <WalletModel>[];

      for (Map<String, Object?> map in maps) {
        wallets.add(WalletModel.fromMap(map));
      }

      return wallets;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<WalletModel> getWalletById(int id) async {
    try {
      final database = await _sqliteService.database;
      final maps = await database.query(
        'wallets',
        where: 'id = ?',
        whereArgs: [id],
      );
      final wallet = WalletModel.fromMap(maps[0]);

      return wallet;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateWallet(WalletModel wallet) async {
    try {
      final database = await _sqliteService.database;
      await database.update(
        'wallets',
        wallet.toMap(),
        where: 'id = ?',
        whereArgs: [wallet.id],
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteWallet(int id) async {
    try {
      final database = await _sqliteService.database;
      await database.delete(
        'wallets',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw e.toString();
    }
  }
}
