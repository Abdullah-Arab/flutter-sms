import 'package:flutter/material.dart';
import '../../models/service_provider.dart';

class ProviderListItem extends StatelessWidget {
  final ServiceProvider provider;
  final VoidCallback onTap;

  const ProviderListItem({
    super.key,
    required this.provider,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final name = isArabic ? provider.nameAr : provider.nameEn;
    final description =
        isArabic ? provider.descriptionAr : provider.descriptionEn;

    return ListTile(
      title: Text(name),
      subtitle: description != null ? Text(description) : null,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }
}
