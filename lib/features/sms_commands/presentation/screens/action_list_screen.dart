import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/routing/app_router.dart';
import '../../logic/sms_commands_cubit.dart';
import '../../logic/sms_commands_state.dart';
import '../widgets/action_list_item.dart';

@RoutePage()
class ActionListScreen extends StatelessWidget {
  const ActionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = getIt<SmsCommandsCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text('Select Action')),
      body: BlocBuilder<SmsCommandsCubit, SmsCommandsState>(
        bloc: cubit,
        builder: (context, state) {
          if (state is SmsCommandsLoaded && state.selectedProvider != null) {
            return ListView.builder(
              itemCount: state.selectedProvider!.actions.length,
              itemBuilder: (context, index) {
                final action = state.selectedProvider!.actions[index];
                return ActionListItem(
                  action: action,
                  onTap: () {
                    cubit.selectAction(action);
                    context.router.push(const FormRoute());
                  },
                );
              },
            );
          }

          return const Center(child: Text('No provider selected'));
        },
      ),
    );
  }
}
