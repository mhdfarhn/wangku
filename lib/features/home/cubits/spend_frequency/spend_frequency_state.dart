part of 'spend_frequency_cubit.dart';

abstract class SpendFrequencyState extends Equatable {
  const SpendFrequencyState();

  @override
  List<Object?> get props => [];
}

class SpendFrequencyInitial extends SpendFrequencyState {}

class LoadingSpendFrequency extends SpendFrequencyState {}

class LoadOneSpendFrequencySuccess extends SpendFrequencyState {
  final double amount;

  const LoadOneSpendFrequencySuccess(this.amount);

  @override
  List<Object?> get props => [amount];
}

class NoSpendFrequency extends SpendFrequencyState {}

class LoadSpendFrequencySuccess extends SpendFrequencyState {
  final double maxX;
  final double minY;
  final double maxY;
  final List<FlSpot> spots;

  const LoadSpendFrequencySuccess({
    required this.maxX,
    required this.minY,
    required this.maxY,
    required this.spots,
  });

  @override
  List<Object?> get props => [
        maxX,
        minY,
        maxY,
        spots,
      ];
}

class LoadSpendFrequencyError extends SpendFrequencyState {
  final String error;

  const LoadSpendFrequencyError(this.error);

  @override
  List<Object?> get props => [error];
}
