import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/const/global_exceptions.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/widgets/custom_snack_bar.dart';
import 'package:texi_passenger/core/widgets/elevated_button_widget.dart';
import 'package:texi_passenger/core/widgets/loading_screen.dart';
import 'package:texi_passenger/features/home/presentation/providers/home_provider.dart';
import 'package:texi_passenger/features/home/presentation/providers/modal_quotes_provider.dart';
import 'package:texi_passenger/features/home/presentation/widgets/address_selector.dart';
import 'package:texi_passenger/features/home/presentation/widgets/modal_content.dart';
import 'package:texi_passenger/features/home/presentation/widgets/quick_action_button.dart';
import 'package:texi_passenger/features/home/services/trip_quote_services.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);
    final modalQuotesState = ref.watch(modalQuotesProvider);
    final modalQuotesNotifier = ref.read(modalQuotesProvider.notifier);

    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.chevron_left_outlined,
                color: Theme.of(context).colorScheme.primary,
              ),
              onPressed: () => context.go(AppRouter.authPage),
            ),
            title: Text(
              solicitRequest.i18n,
              style: StylesForTexts(
                context: context,
              ).headerStyle().copyWith(fontSize: 19.sp),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.menu,
                  color: Theme.of(context).colorScheme.primary,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: state.isLoading
              ? const Center(child: CircularProgressIndicator())
              : SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        AddressSelector(
                          icon: Icons.location_on,
                          address: state.originAddress,
                          isActive: state.isSelectingOrigin,
                          onTap: () {
                            notifier.toggleOrigenSelection();
                          },
                        ),
                        SizedBox(height: 2.h),
                        AddressSelector(
                          icon: Icons.location_on,
                          address: state.destinationAddress,
                          isActive: state.isSelectingDestination,
                          onTap: () {
                            notifier.toggleDestinationSelection();
                          },
                        ),
                        SizedBox(height: 2.h),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              QuickActionButton(
                                icon: Icons.home_outlined,
                                label: 'Casa',
                                isSelected: state.selectedQuickAction == 'Casa',
                                onTap: () => notifier.selectQuickAction('Casa'),
                              ),
                              SizedBox(width: 2.w),
                              QuickActionButton(
                                icon: Icons.work_outline,
                                label: 'Oficina',
                                isSelected:
                                    state.selectedQuickAction == 'Oficina',
                                onTap: () =>
                                    notifier.selectQuickAction('Oficina'),
                              ),
                              SizedBox(width: 2.w),
                              QuickActionButton(
                                icon: Icons.add,
                                label: 'Agregar',
                                isOutline: true,
                                isSelected:
                                    state.selectedQuickAction == 'Agregar',
                                onTap: () =>
                                    notifier.selectQuickAction('Agregar'),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Container(
                          height: 50.75.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.sp),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20.sp),
                            child: GoogleMap(
                              initialCameraPosition: CameraPosition(
                                target: state.currentPosition!,
                                zoom: 15,
                              ),
                              markers: state.markers,
                              polylines: state.polylines,
                              onTap: notifier.handleMapTap,
                              myLocationEnabled: true,
                            ),
                          ),
                        ),
                        SizedBox(height: 2.h),
                      ],
                    ),
                  ),
                ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
            child: SizedBox(
              height: 10.75.h,
              child: Column(
                children: [
                  ElevatedButtonWidget(
                    label: solicitRequest.i18n,
                    onPressed: () async {
                      try {
                        await TripQuoteServices().getTripQuotes(ref);
                      } on GlobalExceptions catch (e) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(customSnackBar(e.message, context));
                        }
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(homeProvider.notifier).reset();
                    },
                    child: Text(cancel.i18n),
                  ),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          left: 0,
          child: modalQuotesState.isVisible
              ? GestureDetector(
                  onTap: () {
                    modalQuotesNotifier.toggleModalQuotes();
                  },
                  child: Container(
                    height: 80.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: Theme.of(
                        context,
                      ).colorScheme.surface.withValues(alpha: 0.75),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.sp),
                        topRight: Radius.circular(20.sp),
                      ),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        Positioned(
          bottom: -5,
          left: 0,
          right: 0,
          child: modalQuotesState.isVisible
              ? Container(
                  height: 32.85.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.sp),
                      topRight: Radius.circular(20.sp),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).colorScheme.primary,
                        blurRadius: 5,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: ModalContent(),
                )
              : const SizedBox.shrink(),
        ),
        modalQuotesState.tripQuotes.isLoading && modalQuotesState.isVisible
            ? const LoadingScreen()
            : const SizedBox.shrink(),
      ],
    );
  }
}
