import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_enums.dart';
import 'package:wangku/core/widgets/large_primary_button.dart';
import 'package:wangku/core/widgets/top_navigation.dart';
import 'package:wangku/features/category/cubits/categories/categories_cubit.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/category_model.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: AppColors.light100,
        appBar: TopNavigation.halfWithTabBar(
          title: 'Category',
          backgroundColor: AppColors.light100,
          foregroundColor: AppColors.dark50,
          statusBarColor: AppColors.light100,
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
          tabBar: TabBar(
            labelStyle: AppTextStyles.body2,
            unselectedLabelStyle: AppTextStyles.body1,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: AppColors.violet100,
            labelColor: AppColors.violet100,
            unselectedLabelColor: AppColors.dark25,
            overlayColor: MaterialStateProperty.resolveWith(
              (states) => states.contains(MaterialState.focused)
                  ? null
                  : Colors.transparent,
            ),
            controller: _tabController,
            tabs: const [
              Tab(text: 'Income'),
              Tab(text: 'Expense'),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  if (state is LoadingCategories) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.violet100),
                    );
                  } else if (state is LoadCategoriesError) {
                    return Center(
                      child: Text(
                        state.error,
                        style: AppTextStyles.body1
                            .copyWith(color: AppColors.red100),
                      ),
                    );
                  } else if (state is LoadCategoriesSuccess) {
                    final categories = state.categories;
                    final incomeCategories = categories
                        .where((category) =>
                            category.transactionType == TransactionType.income)
                        .toList();
                    final expenseCategories = categories
                        .where((category) =>
                            category.transactionType == TransactionType.expense)
                        .toList();
                    return TabBarView(
                      controller: _tabController,
                      children: [
                        CategorySection(incomeCategories),
                        CategorySection(expenseCategories),
                      ],
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: 16.w,
                top: 8.h,
                right: 16.w,
                bottom: 16.h,
              ),
              child: SizedBox(
                width: double.infinity,
                child: LargePrimaryButton(
                    label: 'Add new category',
                    onPressed: () => debugPrint('${_tabController.index}')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategorySection extends StatelessWidget {
  final List<CategoryModel> categories;

  const CategorySection(
    this.categories, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: List.generate(categories.length, (index) {
        final category = categories[index];
        return Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppColors.light60),
            ),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 16.h,
          ),
          child: Row(
            children: [
              Container(
                height: 48.h,
                width: 48.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.dm),
                  color: category.color.withOpacity(0.2),
                ),
                child: Center(
                  child: FaIcon(
                    IconDataSolid(category.icon.icon!.codePoint),
                    color: category.color,
                    size: 24.sp,
                  ),
                ),
              ),
              Gap(8.w),
              Expanded(
                child: Text(
                  category.name,
                  style:
                      AppTextStyles.title3.copyWith(color: AppColors.dark100),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Gap(8.w),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20.dm),
                child: Padding(
                  padding: EdgeInsets.all(8.dg),
                  child: FaIcon(
                    FontAwesomeIcons.pen,
                    size: 24.sp,
                    color: AppColors.dark50,
                  ),
                ),
              ),
              Gap(8.w),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20.dm),
                child: Padding(
                  padding: EdgeInsets.all(8.dg),
                  child: FaIcon(
                    FontAwesomeIcons.trashCan,
                    size: 24.sp,
                    color: AppColors.dark50,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
