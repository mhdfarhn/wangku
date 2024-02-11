import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_enums.dart';
import 'package:wangku/core/constants/app_extensions.dart';
import 'package:wangku/core/widgets/top_navigation.dart';
import 'package:wangku/features/transaction/data/models/transaction_model.dart';

import '../../cubits/image_cubit.dart';
import '../../cubits/select_category_cubit.dart';
import '../../cubits/select_wallet_cubit.dart';
import '../../cubits/transaction/transaction_cubit.dart';
import '../widgets/edit_transaction/edit_transaction_widgets.dart';

class EditTransactionScreen extends StatefulWidget {
  final TransactionModel transaction;

  const EditTransactionScreen(this.transaction, {super.key});

  @override
  State<EditTransactionScreen> createState() => _EditTransactionScreenState();
}

class _EditTransactionScreenState extends State<EditTransactionScreen> {
  final _key = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  late DateTime _dateTime;
  late TimeOfDay _timeOfDay;
  late TransactionModel transaction;

  @override
  void initState() {
    transaction = widget.transaction;
    _amountController.text = transaction.amount.toString();
    _descriptionController.text = transaction.description;
    _dateController.text = transaction.dateTime.toDateString();
    _timeController.text = transaction.dateTime.toTimeString();
    _dateTime = transaction.dateTime;
    _timeOfDay = TimeOfDay.fromDateTime(transaction.dateTime);
    context.read<SelectCategoryCubit>().selectCategory(transaction.category);
    context.read<SelectWalletCubit>().selectWallet(transaction.wallet);
    context.read<ImageCubit>().updateImage(transaction.imagePath);
    super.initState();
  }

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
        backgroundColor: transaction.type == TransactionType.income
            ? AppColors.green100
            : AppColors.red100,
        appBar: TopNavigation.half(
          title:
              transaction.type == TransactionType.income ? 'Income' : 'Expense',
          backgroundColor: transaction.type == TransactionType.income
              ? AppColors.green100
              : AppColors.red100,
          foregroundColor: AppColors.light100,
          statusBarColor: transaction.type == TransactionType.income
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
                      AmountSection(amountController: _amountController),
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
                              onDateInputTapped: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: _dateTime,
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(DateTime.now().year + 5),
                                  initialEntryMode:
                                      DatePickerEntryMode.calendarOnly,
                                ).then(
                                  (value) {
                                    _dateTime = value!;
                                    _dateController.text =
                                        _dateTime.toDateString();
                                  },
                                );
                              },
                              onTimeInputTapped: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: _timeOfDay,
                                  initialEntryMode:
                                      TimePickerEntryMode.dialOnly,
                                ).then(
                                  (value) {
                                    _timeOfDay = value!;
                                    _dateTime = DateTime(
                                      _dateTime.year,
                                      _dateTime.month,
                                      _dateTime.day,
                                      _timeOfDay.hour,
                                      _timeOfDay.minute,
                                    );
                                    _timeController.text =
                                        _dateTime.toTimeString();
                                  },
                                );
                              },
                            ),
                            UpdateTransactionButtonSection(
                              transactionId: transaction.id!,
                              onPressed: () {
                                if (_key.currentState!.validate()) {
                                  context
                                      .read<TransactionCubit>()
                                      .updateTransaction(
                                        transaction:
                                            widget.transaction.copyWith(
                                          amount: int.parse(
                                              _amountController.text.trim()),
                                          category: context
                                              .read<SelectCategoryCubit>()
                                              .state!,
                                          description: _descriptionController
                                              .text
                                              .trim(),
                                          wallet: context
                                              .read<SelectWalletCubit>()
                                              .state!,
                                          imagePath:
                                              context.read<ImageCubit>().state,
                                          dateTime: _dateTime,
                                          updatedAt: DateTime.now(),
                                        ),
                                        initialAmount:
                                            widget.transaction.amount,
                                        initialImagePath:
                                            widget.transaction.imagePath,
                                      );
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
