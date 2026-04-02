import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/widgets/custom_snack_bar.dart';
import 'package:texi_passenger/core/const/global_exceptions.dart';
import 'package:texi_passenger/features/home/domain/entities/trip_quote_entities/trip_quote_res_entity.dart';
import 'package:texi_passenger/features/home/presentation/providers/modal_quotes_provider.dart';
import 'package:texi_passenger/features/home/services/trip_quote_services.dart';
import 'package:texi_passenger/features/travel/services/travel_info_services.dart';

class ModalContent extends ConsumerStatefulWidget {
  const ModalContent({super.key});

  @override
  ConsumerState<ModalContent> createState() => _ModalContentState();
}

class _ModalContentState extends ConsumerState<ModalContent> {
  ServiceOptionsResEntity? selectedOption;
  @override
  Widget build(BuildContext context) {
    final modalQuotesState = ref.watch(modalQuotesProvider);

    return Material(
      color: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.25.h, horizontal: 3.5.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            modalQuotesState.tripQuotes.when(
              data: (data) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      data.city.name,
                      style: StylesForTexts(context: context).headerStyle(),
                    ),
                    Text(
                      selectService.i18n,
                      style: StylesForTexts(context: context)
                          .headerStyleSmall()
                          .copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      selectServiceSubtitle.i18n,
                      style: StylesForTexts(context: context).bodyStyle(),
                    ),
                    SizedBox(height: 3.5),
                    SizedBox(
                      height: 15.5.h,
                      child: ListView.separated(
                        itemCount: data.options.length,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 2.w),
                        itemBuilder: (context, index) {
                          final option = data.options[index];
                          return InkWell(
                            onTap: () async {
                              setState(() {
                                selectedOption = option;
                              });
                            },
                            child: Container(
                              width: 38.5.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.sp),
                                color: selectedOption == option
                                    ? Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.75)
                                    : Theme.of(context).colorScheme.primary
                                          .withValues(alpha: 0.25),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: 0.5.h,
                                  horizontal: 1.5.w,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      option.serviceTypeName.toUpperCase(),
                                      style: TextStyle(
                                        fontSize: 15.50.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.onPrimary,
                                      ),
                                    ),
                                    Text(
                                      '${data.distanceKm.toStringAsFixed(2)} km.',
                                    ),
                                    Icon(Icons.local_taxi, size: 24.5.sp),
                                    Text(
                                      '${option.estimatedPrice.toString()} bs.',
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    TextButton(
                      child: Text(offerTrip.i18n),
                      onPressed: () async {
                        if (selectedOption != null) {
                          try {
                            await TravelInfoServices().initSocket(ref);
                            await TripQuoteServices().createTrip(
                              ref,
                              data.city.id,
                              selectedOption!,
                            );
                            if (context.mounted) {
                              TravelInfoServices().acceptedTrip(ref);
                              context.go(AppRouter.waitingDriverPage);
                            }
                          } on GlobalExceptions catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(e.message, context),
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                customSnackBar(e.toString(), context),
                              );
                            }
                          }
                        }
                      },
                    ),
                  ],
                );
              },
              error: (error, stack) => Center(child: Text(error.toString())),
              loading: () => Center(
                child: Image.asset(
                  'assets/images/loader_image.gif',
                  height: 19.75.h,
                  width: 19.75.h,
                ),
              ),
            ),
            /* TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text(cancel.i18n),
            ), */
          ],
        ),
      ),
    );
  }
}
