import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';
import '../../logic/sms_commands_cubit.dart';
import '../../logic/sms_commands_state.dart';
import '../widgets/dynamic_form.dart';

@RoutePage()
class FormScreen extends StatelessWidget {
  const FormScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SmsCommandsCubit>();

    return BlocBuilder<SmsCommandsCubit, SmsCommandsState>(
      bloc: cubit,
      builder: (context, state) {
        if (state is SmsCommandsLoaded && state.selectedAction != null) {
          final isArabic = Localizations.localeOf(context).languageCode == 'ar';
          final title =
              isArabic
                  ? state.selectedAction!.nameAr
                  : state.selectedAction!.nameEn;

          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: DynamicForm(
                fields: state.selectedAction!.fields,
                onSubmit: () {
                  // Handle form submission (simplified for now)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Form submitted!')),
                  );
                },
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(title: const Text('Fill Form')),
          body: const Center(child: Text('No action selected')),
        );
      },
    );
  }
}
