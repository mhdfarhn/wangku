class TransactionTypeModel {
  final String id;
  final String name;

  TransactionTypeModel({
    required this.id,
    required this.name,
  });
}

final transactionTypes = <TransactionTypeModel>[
  TransactionTypeModel(
    id: '1',
    name: 'Income',
  ),
  TransactionTypeModel(
    id: '2',
    name: 'Expnense',
  ),
];
