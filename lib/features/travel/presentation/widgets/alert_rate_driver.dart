import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/features/travel/presentation/providers/driver_information_provider.dart';
import 'package:texi_passenger/features/travel/presentation/providers/rate_providers.dart';

class AlertRateDriver extends ConsumerWidget {
  const AlertRateDriver({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentRate = ref.watch(rateProvider);
    final driverInfo = ref.watch(driverInformationProvider);

    if (driverInfo == null) return const SizedBox.shrink();

    return AlertDialog(
      title: Text(
        rateDriver.i18n,
        textAlign: TextAlign.center,
        style: StylesForTexts(
          context: context,
        ).headerStyleSmall().copyWith(color: Theme.of(context).primaryColor),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            howDoYouRateTheDriver.i18n,
            style: StylesForTexts(context: context).bodyStyle(),
          ),
          SizedBox(height: 2.h),
          Container(
            height: 10.h,
            width: 10.h,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).primaryColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                driverInfo.profilePhotoUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.person, size: 50);
                },
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            driverInfo.driverName,
            style: StylesForTexts(context: context).bodyStyle(),
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              final isSelected = index < currentRate;
              return IconButton(
                icon: Icon(
                  isSelected ? Icons.star : Icons.star_border,
                  size: 36,
                ),
                color: isSelected
                    ? Colors.amber
                    : Theme.of(
                        context,
                      ).colorScheme.secondary.withValues(alpha: 0.5),
                onPressed: () {
                  ref.read(rateProvider.notifier).setRate(index + 1);
                },
              );
            }),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            ref.read(rateProvider.notifier).reset();
            ref.read(driverInformationProvider.notifier).reset();
          },
          child: Text(cancel.i18n),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            ref.read(rateProvider.notifier).reset();
            ref.read(driverInformationProvider.notifier).reset();
          },
          child: Text(ok.i18n),
        ),
      ],
    );
  }
}
