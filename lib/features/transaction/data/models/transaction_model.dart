import 'package:equatable/equatable.dart';
import 'package:wangku/core/constants/app_enums.dart';
import 'package:wangku/features/category/data/models/category_model.dart';
import 'package:wangku/features/wallet/data/models/wallet_model.dart';

class TransactionModel extends Equatable {
  final int? id;
  final CategoryModel category;
  final WalletModel wallet;
  final TransactionType type;
  final int amount;
  final String description;
  final String imagePath;
  final DateTime dateTime;
  final DateTime createdAt;
  final DateTime updatedAt;

  const TransactionModel({
    this.id,
    required this.type,
    required this.amount,
    required this.category,
    required this.description,
    required this.wallet,
    required this.imagePath,
    required this.dateTime,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'category_id': category.id!,
      'wallet_id': wallet.id!,
      'type': type.name,
      'amount': amount,
      'description': description,
      'image_path': imagePath,
      'date_time': dateTime.millisecondsSinceEpoch,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      id: map['id'],
      category: map['category'],
      wallet: map['wallet'],
      type: TransactionType.values.firstWhere(
        (type) => type.name == map['type'],
      ),
      amount: map['amount'],
      description: map['description'],
      imagePath: map['image_path'],
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['date_time']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  TransactionModel copyWith({
    int? id,
    TransactionType? type,
    int? amount,
    CategoryModel? category,
    String? description,
    WalletModel? wallet,
    String? imagePath,
    DateTime? dateTime,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      TransactionModel(
        id: id ?? this.id,
        type: type ?? this.type,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        description: description ?? this.description,
        wallet: wallet ?? this.wallet,
        imagePath: imagePath ?? this.imagePath,
        dateTime: dateTime ?? this.dateTime,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        type,
        amount,
        category,
        description,
        wallet,
        imagePath,
        dateTime,
        createdAt,
        updatedAt,
      ];
}
