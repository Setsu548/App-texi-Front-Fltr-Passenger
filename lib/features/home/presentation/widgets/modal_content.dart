import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/providers/socket_provider.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/features/home/presentation/providers/modal_quotes_provider.dart';
import 'package:texi_passenger/features/home/services/trip_quote_services.dart';
import 'package:go_router/go_router.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/features/travel/data/models/travel_info_model.dart';

class ModalContent extends ConsumerWidget {
  const ModalContent({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                              final socket = await ref.read(
                                socketProvider.future,
                              );
                              if (socket != null) {
                                socket.onMessage('trip:accepted', (data) {
                                  final travelInfo = TravelInfoModel.fromJson(
                                    data,
                                  );
                                  if (context.mounted) {
                                    context.push(
                                      AppRouter.travelInfoPage,
                                      extra: travelInfo,
                                    );
                                  }
                                });
                              }
                              TripQuoteServices().createTrip(
                                ref,
                                data.city.id,
                                option,
                              );
                            },
                            child: Container(
                              width: 38.5.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.sp),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primary.withValues(alpha: 0.55),
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
                  ],
                );
              },
              error: (error, stack) => Center(child: Text(error.toString())),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
            TextButton(
              onPressed: () {
                ref.read(modalQuotesProvider.notifier).toggleModalQuotes();
              },
              child: Text(cancel.i18n),
            ),
          ],
        ),
      ),
    );
  }
}
