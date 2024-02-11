part of 'transaction_report_cubit.dart';

abstract class TransactionReportState extends Equatable {
  const TransactionReportState();

  @override
  List<Object?> get props => [];
}

class TransactionReportInitial extends TransactionReportState {}

class LoadingTransactionReport extends TransactionReportState {}

class LoadTransactionReportSuccess extends TransactionReportState {
  final int income;
  final int expense;

  const LoadTransactionReportSuccess({
    required this.income,
    required this.expense,
  });

  @override
  List<Object?> get props => [income, expense];
}

class LoadTransactionReportError extends TransactionReportState {
  final String error;

  const LoadTransactionReportError(this.error);

  @override
  List<Object?> get props => [error];
}
