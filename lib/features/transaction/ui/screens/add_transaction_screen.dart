import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_enums.dart';
import 'package:wangku/core/widgets/top_navigation.dart';
import 'package:wangku/features/transaction/ui/widgets/add_transaction/add_transaction_widgets.dart';

import '../../cubits/image_cubit.dart';
import '../../cubits/select_category_cubit.dart';
import '../../cubits/select_wallet_cubit.dart';
import '../../cubits/transactions/transactions_cubit.dart';
import '../../data/models/transaction_model.dart';

class AddTransactionScreen extends StatefulWidget {
  final TransactionType type;

  const AddTransactionScreen(this.type, {super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _key = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  DateTime? _dateTime;
  TimeOfDay? _timeOfDay;

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<SelectCategoryCubit>().removeCategory();
        context.read<SelectWalletCubit>().removeWallet();
        context.read<ImageCubit>().removeImage();
        return true;
      },
      child: Scaffold(
        backgroundColor: widget.type == TransactionType.income
            ? AppColors.green100
            : AppColors.red100,
        appBar: TopNavigation.half(
          title: widget.type == TransactionType.income ? 'Income' : 'Expense',
          backgroundColor: widget.type == TransactionType.income
              ? AppColors.green100
              : AppColors.red100,
          foregroundColor: AppColors.light100,
          statusBarColor: widget.type == TransactionType.income
              ? AppColors.green100
              : AppColors.red100,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.light,
        ),
        body: Stack(
          children: [
            const SizedBox(height: double.infinity),
            Align(
              alignment: Alignment.bottomCenter,
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      AmountSection(_amountController),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(32.dm),
                          ),
                          color: AppColors.light100,
                        ),
                        child: Column(
                          children: [
                            DetailTransactionSection(
                              descriptionController: _descriptionController,
                              dateController: _dateController,
                              timeController: _timeController,
                              onDateInputTapped: () => showDatePicker(
                                context: context,
                                initialDate: _dateTime ?? DateTime.now(),
                                firstDate: DateTime(1900),
                                lastDate: DateTime(DateTime.now().year + 5),
                                initialEntryMode:
                                    DatePickerEntryMode.calendarOnly,
                              ).then(
                                (value) {
                                  _dateTime = value;
                                  _dateController.text =
                                      DateFormat('dd/MM/yyyy').format(value!);
                                },
                              ),
                              onTimeInputTapped: () => showTimePicker(
                                context: context,
                                initialTime: _timeOfDay ?? TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.dialOnly,
                              ).then(
                                (value) {
                                  _timeOfDay = value;
                                  _dateTime = DateTime(
                                    _dateTime!.year,
                                    _dateTime!.month,
                                    _dateTime!.day,
                                    _timeOfDay!.hour,
                                    _timeOfDay!.minute,
                                  );
                                  _timeController.text =
                                      DateFormat.jm().format(_dateTime!);
                                },
                              ),
                            ),
                            AddTransactionButtonSection(
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  final selectCategoryCubit =
                                      context.read<SelectCategoryCubit>();
                                  final selectWalletCubit =
                                      context.read<SelectWalletCubit>();
                                  if (selectCategoryCubit.state != null &&
                                      selectWalletCubit.state != null) {
                                    final amount =
                                        _amountController.text.isNotEmpty
                                            ? int.parse(
                                                _amountController.text.trim())
                                            : 0;
                                    context
                                        .read<TransactionsCubit>()
                                        .addTransaction(
                                          TransactionModel(
                                            type: widget.type,
                                            amount: amount,
                                            category:
                                                selectCategoryCubit.state!,
                                            description: _descriptionController
                                                .text
                                                .trim(),
                                            wallet: selectWalletCubit.state!,
                                            imagePath: context
                                                .read<ImageCubit>()
                                                .state,
                                            dateTime: _dateTime!,
                                            createdAt: DateTime.now(),
                                            updatedAt: DateTime.now(),
                                          ),
                                        );
                                  }
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
