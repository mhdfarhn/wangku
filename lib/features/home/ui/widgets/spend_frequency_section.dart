import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../cubits/spend_frequency/spend_frequency_cubit.dart';

class SpendFrequencySection extends StatelessWidget {
  const SpendFrequencySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SpendFrequencyCubit, SpendFrequencyState>(
      builder: (context, state) {
        if (state is NoSpendFrequency) {
          return Container();
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                child: Text(
                  'Spend Frequency',
                  style:
                      AppTextStyles.title3.copyWith(color: AppColors.dark100),
                ),
              ),
              BlocBuilder<SpendFrequencyCubit, SpendFrequencyState>(
                builder: (context, state) {
                  if (state is LoadSpendFrequencyError) {
                    return Text(
                      state.error,
                      style:
                          AppTextStyles.body1.copyWith(color: AppColors.red100),
                    );
                  } else if (state is LoadingSpendFrequency) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.violet100),
                    );
                  } else if (state is LoadOneSpendFrequencySuccess) {
                    final amount = state.amount;
                    return AspectRatio(
                      aspectRatio: 375.w / 140.h,
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          gridData: const FlGridData(show: false),
                          minX: 0,
                          maxX: 2,
                          minY: amount - amount,
                          maxY: amount + amount,
                          lineBarsData: [
                            LineChartBarData(
                              barWidth: 6,
                              color: AppColors.violet100,
                              dotData: const FlDotData(show: false),
                              isCurved: true,
                              spots: [
                                FlSpot(0, amount),
                                FlSpot(1, amount),
                                FlSpot(2, amount),
                              ],
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xFF8B50FF).withOpacity(0.24),
                                    const Color(0xFF8B50FF).withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (state is LoadSpendFrequencySuccess) {
                    return AspectRatio(
                      aspectRatio: 375.w / 140.h,
                      child: LineChart(
                        LineChartData(
                          borderData: FlBorderData(show: false),
                          titlesData: const FlTitlesData(show: false),
                          gridData: const FlGridData(show: false),
                          minX: 0,
                          maxX: state.maxX,
                          minY: state.minY,
                          maxY: state.maxY,
                          lineBarsData: [
                            LineChartBarData(
                              barWidth: 6,
                              color: AppColors.violet100,
                              dotData: const FlDotData(show: false),
                              isCurved: true,
                              spots: List.generate(
                                state.spots.length,
                                (index) => state.spots[index],
                              ),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xFF8B50FF).withOpacity(0.24),
                                    const Color(0xFF8B50FF).withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          );
        }
      },
    );
  }
}
