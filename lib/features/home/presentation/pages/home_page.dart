import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/const/global_exceptions.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/widgets/custom_snack_bar.dart';
import 'package:texi_passenger/core/widgets/elevated_button_widget.dart';
import 'package:texi_passenger/features/home/presentation/providers/home_provider.dart';
import 'package:texi_passenger/features/home/presentation/widgets/address_selector.dart';
import 'package:texi_passenger/features/home/presentation/widgets/modal_content.dart';
import 'package:texi_passenger/features/home/presentation/widgets/quick_action_button.dart';
import 'package:texi_passenger/features/home/services/trip_quote_services.dart';
import 'package:texi_passenger/features/travel/presentation/providers/rate_providers.dart';
import 'package:texi_passenger/features/travel/presentation/widgets/alert_rate_driver.dart';
import 'package:geolocator/geolocator.dart';
import 'package:texi_passenger/core/providers/position_status_provider.dart';
import 'package:texi_passenger/core/widgets/location_permissions.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  bool _isButtonDisabled = false;

  @override
  Widget build(BuildContext context) {
    final permissionState = ref.watch(permissionStatusProvider);

    if (permissionState.isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Image.asset(
            'assets/images/loader_image.gif',
            height: 20.h,
            width: 20.w,
          ),
        ),
      );
    } else if (permissionState.hasValue) {
      final permission = permissionState.value!;
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return const LocationPermissions();
      }
    }

    final state = ref.watch(homeProvider);
    final notifier = ref.read(homeProvider.notifier);

    ref.listen(showRateAlertProvider, (previous, next) {
      if (next) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const AlertRateDriver(),
          ).then((_) {
            ref.read(showRateAlertProvider.notifier).setShowRateAlert(false);
          });
        });
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ref.read(showRateAlertProvider)) {
        ref.read(showRateAlertProvider.notifier).setShowRateAlert(false);
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AlertRateDriver(),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: null,
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
          ? Center(
              child: Image.asset(
                'assets/images/loader_image.gif',
                height: 20.h,
                width: 20.w,
              ),
            )
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
                    /* SingleChildScrollView(
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
                            isSelected: state.selectedQuickAction == 'Oficina',
                            onTap: () => notifier.selectQuickAction('Oficina'),
                          ),
                          SizedBox(width: 2.w),
                          QuickActionButton(
                            icon: Icons.add,
                            label: 'Agregar',
                            isOutline: true,
                            isSelected: state.selectedQuickAction == 'Agregar',
                            onTap: () => notifier.selectQuickAction('Agregar'),
                          ),
                        ],
                      ),
                    ), */
                    SizedBox(height: 2.h),
                    Container(
                      height: 51.55.h,
                      width: 100.w,
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
      bottomNavigationBar: Builder(
        builder: (innerContext) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
          child: SizedBox(
            height: 10.75.h,
            child: Column(
              children: [
                ElevatedButtonWidget(
                  label: solicitRequest.i18n,
                  onPressed: _isButtonDisabled
                      ? null
                      : () async {
                          setState(() {
                            _isButtonDisabled = true;
                          });
                          try {
                            await TripQuoteServices().getTripQuotes(ref);
                            final controller = Scaffold.of(innerContext)
                                .showBottomSheet((
                                  // ✅ innerContext correcto
                                  BuildContext context,
                                ) {
                                  return Container(
                                    height: 35.85.h,
                                    width: 100.w,
                                    decoration: BoxDecoration(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.surface,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20.sp),
                                        topRight: Radius.circular(20.sp),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          blurRadius: 5,
                                          offset: const Offset(0, -2),
                                        ),
                                      ],
                                    ),
                                    child: ModalContent(),
                                  );
                                });
                            await controller.closed;
                          } on GlobalExceptions catch (e) {
                            if (innerContext.mounted) {
                              // ✅ también innerContext aquí
                              ScaffoldMessenger.of(innerContext).showSnackBar(
                                customSnackBar(e.message, innerContext),
                              );
                            }
                          } finally {
                            if (mounted) {
                              setState(() {
                                _isButtonDisabled = false;
                              });
                            }
                          }
                        },
                ),
                /* TextButton(
                  onPressed: () {
                    ref.read(homeProvider.notifier).reset();
                  },
                  child: Text(cancel.i18n),
                ), */
              ],
            ),
          ),
        ),
      ),
    );
  }
}
