import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sizer/sizer.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/widgets/another_elevated_button_widget.dart';
import 'package:texi_passenger/features/travel/data/models/travel_info_model.dart';
import 'package:texi_passenger/features/travel/presentation/providers/trip_status_provider.dart';
import 'package:texi_passenger/features/travel/services/travel_info_services.dart';

class TravelInfoPage extends ConsumerStatefulWidget {
  final TravelInfoModel? data;

  const TravelInfoPage({super.key, this.data});

  @override
  ConsumerState<TravelInfoPage> createState() => _TravelInfoPageState();
}

class _TravelInfoPageState extends ConsumerState<TravelInfoPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TravelInfoServices().statusTrip(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentStatusText = ref.watch(tripStatusProvider);

    return Scaffold(
      appBar: null,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.5.w, vertical: 2.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                tripInformation.i18n,
                textAlign: TextAlign.center,
                style: StylesForTexts(context: context).headerStyle(),
              ),
              SizedBox(height: 1.5.h),
              Card(
                elevation: 2.5.sp,
                shadowColor: Theme.of(context).colorScheme.primary,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${status.i18n}: ',
                      style: StylesForTexts(context: context).bodyStyle(),
                    ),
                    Text(
                      currentStatusText,
                      style: StylesForTexts(context: context)
                          .headerStyleSmall()
                          .copyWith(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1.5.h),
              Container(
                width: double.infinity,
                height: 65.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(15.sp),
                ),
                clipBehavior: Clip.hardEdge,
                child: const GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(0, 0),
                    zoom: 14.0,
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                ),
              ),
              SizedBox(height: 1.5.h),
              AnotherElevatedButtonWidget(label: cancel.i18n),
            ],
          ),
        ),
      ),
    );
  }
}
