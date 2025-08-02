import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/routing/app_router.dart';
import '../../logic/sms_commands_cubit.dart';
import '../../logic/sms_commands_state.dart';
import '../widgets/category_list_item.dart';

@RoutePage()
class CategoryListScreen extends StatelessWidget {
  const CategoryListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SmsCommandsCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Select Category')),
      body: BlocBuilder<SmsCommandsCubit, SmsCommandsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SmsCommandsInitial) {
            cubit.loadCategories();
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SmsCommandsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SmsCommandsLoaded) {
            return ListView.builder(
              itemCount: state.categories.length,
              itemBuilder: (context, index) {
                final category = state.categories[index];
                return CategoryListItem(
                  category: category,
                  onTap: () {
                    print(
                      'Selecting category: ${category.nameEn}',
                    ); // Debug print
                    cubit.selectCategory(category);
                    print(
                      'Category selected, navigating to provider list',
                    ); // Debug print
                    context.router.push(const ProviderListRoute());
                  },
                );
              },
            );
          }

          if (state is SmsCommandsError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Error'),
                  Text(state.message),
                  ElevatedButton(
                    onPressed: () => cubit.loadCategories(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
