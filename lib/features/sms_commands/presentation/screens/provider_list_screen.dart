import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/routing/app_router.dart';
import '../../logic/sms_commands_cubit.dart';
import '../../logic/sms_commands_state.dart';
import '../widgets/provider_list_item.dart';

@RoutePage()
class ProviderListScreen extends StatelessWidget {
  const ProviderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SmsCommandsCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Select Provider')),
      body: BlocBuilder<SmsCommandsCubit, SmsCommandsState>(
        bloc: cubit,
        builder: (context, state) {
          print(
            'ProviderListScreen - Current state: ${state.runtimeType}',
          ); // Debug print

          if (state is SmsCommandsInitial) {
            return const Center(
              child: Text('Initial state - loading categories...'),
            );
          }

          if (state is SmsCommandsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is SmsCommandsLoaded) {
            print(
              'ProviderListScreen - Selected category: ${state.selectedCategory?.nameEn}',
            ); // Debug print
            if (state.selectedCategory == null) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No category selected'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.router.pop(),
                      child: const Text('Go Back'),
                    ),
                  ],
                ),
              );
            }

            return ListView.builder(
              itemCount: state.selectedCategory!.providers.length,
              itemBuilder: (context, index) {
                final provider = state.selectedCategory!.providers[index];
                return ProviderListItem(
                  provider: provider,
                  onTap: () {
                    cubit.selectProvider(provider);
                    context.router.push(const ActionListRoute());
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
