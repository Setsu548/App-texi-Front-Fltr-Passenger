import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/widgets/label_textfield_widget.dart';
import 'package:texi_passenger/features/auth/presentation/providers/auth_providers.dart';

class PhoneWidget extends ConsumerWidget {
  const PhoneWidget({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: 80.w,
      height: 7.58.h,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PhoneDialCountryCode(),
          SizedBox(
            width: 55.w,
            child: LabelTextfieldWidget(
              hintText: '77733322',
              controller: controller,
              keyboardType: TextInputType.phone,
              isBold: true,
            ),
          ),
        ],
      ),
    );
  }
}

class PhoneDialCountryCode extends ConsumerWidget {
  const PhoneDialCountryCode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countries = ref.watch(countriesProvider);
    final countrySelected = ref.watch(selectedCountryProvider);
    return Container(
      width: 23.w,
      height: 5.25.h,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.5),
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: DropdownButton(
          underline: const SizedBox(),
          menuMaxHeight: 20.h,
          value: countrySelected,
          items: countries
              .map(
                (country) => DropdownMenuItem(
                  value: country,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text(country.flag), Text(country.dialCode)],
                  ),
                ),
              )
              .toList(),
          onChanged: (value) {
            ref.read(selectedCountryProvider.notifier).selectCountry(value!);
          },
        ),
      ),
    );
  }
}
