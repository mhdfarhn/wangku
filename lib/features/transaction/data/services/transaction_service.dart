import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:wangku/core/constants/app_extensions.dart';
import 'package:wangku/core/data/services/sqlite_service.dart';
import 'package:wangku/features/transaction/data/models/transaction_model.dart';

import '../../../../core/constants/app_enums.dart';
import '../../../category/data/services/category_service.dart';
import '../../../wallet/data/services/wallet_service.dart';

class TransactionService {
  final _sqliteService = SqliteService();
  final _categoryService = CategoryService();
  final _walletService = WalletService();

  Future<void> createTransaction(TransactionModel transaction) async {
    try {
      final database = await _sqliteService.database;
      final wallet = transaction.wallet;

      await database.update(
        'wallets',
        wallet
            .copyWith(
              balance: transaction.type == TransactionType.income
                  ? wallet.balance + transaction.amount
                  : wallet.balance - transaction.amount,
              updatedAt: DateTime.now(),
            )
            .toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await database.insert(
        'transactions',
        transaction.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  Future<TransactionModel> getTransaction(int id) async {
    try {
      final database = await _sqliteService.database;
      final maps = await database.query(
        'transactions',
        where: 'id = ?',
        whereArgs: [id],
        limit: 1,
      );
      final category =
          await _categoryService.getCategoryById(maps[0]['category_id'] as int);
      final wallet =
          await _walletService.getWalletById(maps[0]['wallet_id'] as int);

      final transaction = {
        'id': maps[0]['id'],
        'category': category,
        'wallet': wallet,
        'type': maps[0]['type'],
        'amount': maps[0]['amount'],
        'description': maps[0]['description'],
        'image_path': maps[0]['image_path'],
        'date_time': maps[0]['date_time'],
        'created_at': maps[0]['created_at'],
        'updated_at': maps[0]['updated_at'],
      };

      return TransactionModel.fromMap(transaction);
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> updateTransaction({
    required TransactionModel transaction,
    required int initialAmount,
  }) async {
    try {
      final database = await _sqliteService.database;
      final wallet = transaction.wallet;

      await database.update(
        'wallets',
        wallet
            .copyWith(
              balance: transaction.type == TransactionType.income
                  ? wallet.balance - initialAmount + transaction.amount
                  : wallet.balance + initialAmount - transaction.amount,
              updatedAt: DateTime.now(),
            )
            .toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await database.update(
        'transactions',
        transaction.toMap(),
        where: 'id = ?',
        whereArgs: [transaction.id],
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> deleteTransaction(TransactionModel transaction) async {
    try {
      final database = await _sqliteService.database;
      final wallet = transaction.wallet;

      await database.update(
        'wallets',
        wallet
            .copyWith(
              balance: transaction.type == TransactionType.income
                  ? wallet.balance - transaction.amount
                  : wallet.balance + transaction.amount,
              updatedAt: DateTime.now(),
            )
            .toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );

      await database.delete(
        'transactions',
        where: 'id = ?',
        whereArgs: [transaction.id],
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<List<TransactionModel>> getAllTransactions() async {
    try {
      final database = await _sqliteService.database;
      final List<Map<String, dynamic>> maps =
          await database.query('transactions', orderBy: 'date_time ASC');
      final transactions = <TransactionModel>[];

      for (Map<String, dynamic> map in maps) {
        final category =
            await _categoryService.getCategoryById(map['category_id']);
        final wallet = await _walletService.getWalletById(map['wallet_id']);
        final transaction = {
          'id': map['id'],
          'category': category,
          'wallet': wallet,
          'type': map['type'],
          'amount': map['amount'],
          'description': map['description'],
          'image_path': map['image_path'],
          'date_time': map['date_time'],
          'created_at': map['created_at'],
          'updated_at': map['updated_at'],
        };

        transactions.add(TransactionModel.fromMap(transaction));
      }

      return transactions;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, List<TransactionModel>>>
      getAllTransactionGroupedByDay() async {
    try {
      final database = await _sqliteService.database;
      final List<Map<String, dynamic>> maps = await database.query(
        'transactions',
        orderBy: 'date_time DESC',
      );
      final results = <String, List<TransactionModel>>{};

      for (Map<String, dynamic> map in maps) {
        final category =
            await _categoryService.getCategoryById(map['category_id']);
        final wallet = await _walletService.getWalletById(map['wallet_id']);
        final transaction = {
          'id': map['id'],
          'category': category,
          'wallet': wallet,
          'type': map['type'],
          'amount': map['amount'],
          'description': map['description'],
          'image_path': map['image_path'],
          'date_time': map['date_time'],
          'created_at': map['created_at'],
          'updated_at': map['updated_at'],
        };

        final date =
            DateTime.fromMillisecondsSinceEpoch(map['date_time']).toDayString();

        if (results.keys.contains(date)) {
          results[date]?.add(TransactionModel.fromMap(transaction));
        } else {
          results[date] = [TransactionModel.fromMap(transaction)];
        }
      }
      return results;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<Map<String, List<TransactionModel>>> getRecentTransactions() async {
    try {
      final database = await _sqliteService.database;
      final List<Map<String, dynamic>> maps = await database.query(
        'transactions',
        limit: 10,
        orderBy: 'date_time DESC',
      );
      final results = <String, List<TransactionModel>>{};

      for (Map<String, dynamic> map in maps) {
        final category =
            await _categoryService.getCategoryById(map['category_id']);
        final wallet = await _walletService.getWalletById(map['wallet_id']);
        final transaction = {
          'id': map['id'],
          'category': category,
          'wallet': wallet,
          'type': map['type'],
          'amount': map['amount'],
          'description': map['description'],
          'image_path': map['image_path'],
          'date_time': map['date_time'],
          'created_at': map['created_at'],
          'updated_at': map['updated_at'],
        };

        final date =
            DateTime.fromMillisecondsSinceEpoch(map['date_time']).toDayString();

        if (results.keys.contains(date)) {
          results[date]?.add(TransactionModel.fromMap(transaction));
        } else {
          results[date] = [TransactionModel.fromMap(transaction)];
        }
      }

      return results;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<int> getTransactionReport(TransactionType type) async {
    final transactionType = type.name;
    try {
      final database = await _sqliteService.database;
      final maps = await database.rawQuery(
          "SELECT SUM(amount) FROM transactions WHERE type = '$transactionType'");
      final result = maps[0]['SUM(amount)'] as int?;
      return result ?? 0;
    } catch (e) {
      throw e.toString();
    }
  }
}
