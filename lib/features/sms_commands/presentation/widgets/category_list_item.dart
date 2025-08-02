import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../models/category.dart';

class CategoryListItem extends StatefulWidget {
  final Category category;
  final VoidCallback onTap;

  const CategoryListItem({
    super.key,
    required this.category,
    required this.onTap,
  });

  @override
  State<CategoryListItem> createState() => _CategoryListItemState();
}

class _CategoryListItemState extends State<CategoryListItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  IconData _getCategoryIcon(String categoryId) {
    // Make icons more dynamic based on category ID
    switch (categoryId.toLowerCase()) {
      case 'banking':
      case 'banks':
      case 'bank':
        return Icons.account_balance;
      case 'government':
      case 'gov':
      case 'public':
        return Icons.business;
      case 'telecom':
      case 'telecommunications':
      case 'mobile':
      case 'phone':
        return Icons.phone_android;
      case 'utilities':
      case 'electricity':
      case 'water':
        return Icons.power;
      case 'transport':
      case 'transportation':
        return Icons.directions_car;
      case 'health':
      case 'medical':
        return Icons.local_hospital;
      case 'education':
      case 'school':
        return Icons.school;
      case 'shopping':
      case 'retail':
        return Icons.shopping_cart;
      case 'entertainment':
      case 'media':
        return Icons.movie;
      default:
        // Try to extract icon from category name
        final name = categoryId.toLowerCase();
        if (name.contains('bank')) return Icons.account_balance;
        if (name.contains('gov') || name.contains('public'))
          return Icons.business;
        if (name.contains('phone') ||
            name.contains('mobile') ||
            name.contains('telecom'))
          return Icons.phone_android;
        if (name.contains('power') || name.contains('electric'))
          return Icons.power;
        if (name.contains('car') || name.contains('transport'))
          return Icons.directions_car;
        if (name.contains('health') || name.contains('medical'))
          return Icons.local_hospital;
        if (name.contains('school') || name.contains('education'))
          return Icons.school;
        if (name.contains('shop') || name.contains('retail'))
          return Icons.shopping_cart;
        if (name.contains('movie') || name.contains('entertainment'))
          return Icons.movie;
        return Icons.category;
    }
  }

  Color _getCategoryColor(String categoryId) {
    // Make colors more dynamic based on category ID
    switch (categoryId.toLowerCase()) {
      case 'banking':
      case 'banks':
      case 'bank':
        return Colors.green.shade600;
      case 'government':
      case 'gov':
      case 'public':
        return Colors.blue.shade600;
      case 'telecom':
      case 'telecommunications':
      case 'mobile':
      case 'phone':
        return Colors.orange.shade600;
      case 'utilities':
      case 'electricity':
      case 'water':
        return Colors.yellow.shade700;
      case 'transport':
      case 'transportation':
        return Colors.purple.shade600;
      case 'health':
      case 'medical':
        return Colors.red.shade600;
      case 'education':
      case 'school':
        return Colors.indigo.shade600;
      case 'shopping':
      case 'retail':
        return Colors.pink.shade600;
      case 'entertainment':
      case 'media':
        return Colors.deepPurple.shade600;
      default:
        // Try to extract color from category name
        final name = categoryId.toLowerCase();
        if (name.contains('bank')) return Colors.green.shade600;
        if (name.contains('gov') || name.contains('public'))
          return Colors.blue.shade600;
        if (name.contains('phone') ||
            name.contains('mobile') ||
            name.contains('telecom'))
          return Colors.orange.shade600;
        if (name.contains('power') || name.contains('electric'))
          return Colors.yellow.shade700;
        if (name.contains('car') || name.contains('transport'))
          return Colors.purple.shade600;
        if (name.contains('health') || name.contains('medical'))
          return Colors.red.shade600;
        if (name.contains('school') || name.contains('education'))
          return Colors.indigo.shade600;
        if (name.contains('shop') || name.contains('retail'))
          return Colors.pink.shade600;
        if (name.contains('movie') || name.contains('entertainment'))
          return Colors.deepPurple.shade600;
        return Colors.grey.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    final name = isArabic ? widget.category.nameAr : widget.category.nameEn;
    final icon = _getCategoryIcon(widget.category.id);
    final color = _getCategoryColor(widget.category.id);

    return GestureDetector(
      onTapDown: (_) {
        setState(() => _isPressed = true);
        _animationController.forward();
      },
      onTapUp: (_) {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      onTapCancel: () {
        setState(() => _isPressed = false);
        _animationController.reverse();
      },
      onTap: widget.onTap,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _isPressed ? 8 : 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [color.withOpacity(0.1), color.withOpacity(0.05)],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: color, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${widget.category.providers.length} ${l10n.providers}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey.shade600),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.arrow_forward_ios, color: color, size: 20),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
