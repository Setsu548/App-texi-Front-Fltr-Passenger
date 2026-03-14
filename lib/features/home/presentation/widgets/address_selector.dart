import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddressSelector extends ConsumerWidget {
  final IconData icon;
  final String address;
  final bool isActive;
  final Function() onTap;
  const AddressSelector({
    super.key,
    required this.icon,
    required this.address,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).primaryColor.withValues(alpha: 0.2)
              : Theme.of(
                  context,
                ).colorScheme.secondary.withValues(alpha: 0.085),
          borderRadius: BorderRadius.circular(12),
          border: isActive
              ? Border.all(color: Theme.of(context).primaryColor)
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                address,
                style: const TextStyle(color: Colors.white, fontSize: 16),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
