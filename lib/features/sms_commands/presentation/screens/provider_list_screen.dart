import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routing/app_router.dart';
import '../../logic/sms_commands_cubit.dart';
import '../../logic/sms_commands_state.dart';
import '../widgets/provider_list_item.dart';

@RoutePage()
class ProviderListScreen extends StatelessWidget {
  const ProviderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<SmsCommandsCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Select Provider')),
      body: BlocBuilder<SmsCommandsCubit, SmsCommandsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SmsCommandsLoaded && state.selectedCategory != null) {
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

          return const Center(child: Text('No category selected'));
        },
      ),
    );
  }
}
