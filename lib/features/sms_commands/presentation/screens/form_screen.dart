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

          // Generate preview message
          String previewMessage = state.selectedAction!.template;
          state.formValues.forEach((key, value) {
            previewMessage = previewMessage.replaceAll('{$key}', value);
          });

          return Scaffold(
            appBar: AppBar(title: Text(title)),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // SMS Preview
                  if (state.formValues.isNotEmpty) ...[
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'SMS Preview:',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 8),
                            Text('To: ${state.selectedAction!.smsNumber}'),
                            const SizedBox(height: 4),
                            Text('Message: $previewMessage'),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  // Form
                  Expanded(
                    child: DynamicForm(
                      fields: state.selectedAction!.fields,
                      onSubmit: () async {
                        // Send SMS
                        final success = await cubit.sendSms();
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('SMS app opened successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Failed to open SMS app'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
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
