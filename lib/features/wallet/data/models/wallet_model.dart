import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WalletModel extends Equatable {
  final int? id;
  final int balance;
  final String name;
  final FaIcon icon;
  final Color color;
  final DateTime createdAt;
  final DateTime updatedAt;

  const WalletModel({
    this.id,
    required this.name,
    required this.balance,
    required this.icon,
    required this.color,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'balance': balance,
      'icon': icon.icon!.codePoint,
      'color': color.value,
      'created_at': createdAt.millisecondsSinceEpoch,
      'updated_at': updatedAt.millisecondsSinceEpoch,
    };
  }

  factory WalletModel.fromMap(Map<String, dynamic> map) {
    return WalletModel(
      id: map['id'],
      name: map['name'],
      balance: map['balance'],
      icon: FaIcon(IconDataSolid(map['icon'])),
      color: Color(map['color']),
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(map['updated_at']),
    );
  }

  WalletModel copyWith({
    int? id,
    String? name,
    int? balance,
    FaIcon? icon,
    Color? color,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      WalletModel(
        id: id ?? this.id,
        name: name ?? this.name,
        balance: balance ?? this.balance,
        icon: icon ?? this.icon,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  @override
  List<Object?> get props => [
        id,
        name,
        balance,
        icon,
        color,
        createdAt,
        updatedAt,
      ];
}
