import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_enums.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String name;
  final TransactionType transactionType;
  final FaIcon icon;
  final Color color;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CategoryModel({
    this.id,
    required this.name,
    required this.transactionType,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'transaction_type': transactionType.name,
        'icon': icon.icon!.codePoint,
        'color': color.value,
        'created_at': createdAt.millisecondsSinceEpoch,
        'updated_at': updatedAt.millisecondsSinceEpoch,
      };

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
        id: map['id'],
        name: map['name'],
        transactionType: TransactionType.values
            .firstWhere((type) => type.name == map['transaction_type']),
        icon: FaIcon(IconDataSolid(map['icon'])),
        color: Color(map['color']),
        createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
        updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
      );

  CategoryModel copyWith({
    int? id,
    String? name,
    TransactionType? transactionType,
    FaIcon? icon,
    Color? color,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      CategoryModel(
        id: id ?? this.id,
        name: name ?? this.name,
        transactionType: transactionType ?? this.transactionType,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        transactionType,
        icon,
        color,
        createdAt,
        updatedAt,
      ];
}

final categories = <CategoryModel>[
  CategoryModel(
    name: 'Allowance',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.coins),
    color: AppColors.violet100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Award',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.award),
    color: AppColors.green100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Bonus',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.sackDollar),
    color: AppColors.yellow100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Dividend',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.chartLine),
    color: AppColors.red100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Investment',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.seedling),
    color: AppColors.green100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Lottery',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.dice),
    color: AppColors.red100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Salary',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.moneyBills),
    color: AppColors.green100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Tips',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.handHoldingDollar),
    color: AppColors.violet100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Others',
    transactionType: TransactionType.income,
    icon: const FaIcon(FontAwesomeIcons.tableCellsLarge),
    color: AppColors.blue100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Bills',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.fileInvoiceDollar),
    color: AppColors.blue100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Clothing',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.shirt),
    color: AppColors.green100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Education',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.graduationCap),
    color: AppColors.yellow100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Entertainment',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.dice),
    color: AppColors.red100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Fitness',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.dumbbell),
    color: AppColors.blue100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Food',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.bowlFood),
    color: AppColors.green100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Gifts',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.gift),
    color: AppColors.yellow100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Health',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.briefcaseMedical),
    color: AppColors.red100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Furniture',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.couch),
    color: AppColors.blue100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Pet',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.cat),
    color: AppColors.green100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Shopping',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.cartShopping),
    color: AppColors.yellow100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Transportation',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.bus),
    color: AppColors.red100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Travel',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.suitcaseRolling),
    color: AppColors.blue100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
  CategoryModel(
    name: 'Others',
    transactionType: TransactionType.expense,
    icon: const FaIcon(FontAwesomeIcons.tableCellsLarge),
    color: AppColors.green100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];
