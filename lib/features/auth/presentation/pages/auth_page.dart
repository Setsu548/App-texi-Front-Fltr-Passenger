import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/widgets/custom_snack_bar.dart';
import 'package:texi_passenger/core/widgets/elevated_button_widget.dart';
import 'package:texi_passenger/features/auth/presentation/widgets/phone_widget.dart';
import 'package:texi_passenger/features/auth/services/auth_services.dart'
    show AuthServices;
import 'package:texi_passenger/core/widgets/loading_screen.dart';
import 'package:texi_passenger/features/auth/presentation/providers/auth_providers.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneController = TextEditingController();
    return Scaffold(
      appBar: null,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/texiFondo.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12.5.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                      width: 100.w,
                      child: Image.asset(
                        'assets/images/texi_logo.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    Text(
                      sloganTexi.i18n,
                      style: StylesForTexts(
                        context: context,
                      ).headerStyleSmall(),
                    ),
                    SizedBox(height: 4.5.h),
                    SizedBox(
                      child: Text(
                        messageLogin.i18n,
                        textAlign: TextAlign.center,
                        style: StylesForTexts(context: context).headerStyle(),
                      ),
                    ),
                    SizedBox(height: 2.5.h),
                    PhoneWidget(controller: phoneController),
                    SizedBox(height: 4.5.h),
                    ElevatedButtonWidget(
                      label: requestAccessCode.i18n,
                      onPressed: () async {
                        if (phoneController.text.trim().isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            customSnackBar(fieldRequired.i18n, context),
                          );
                          return;
                        }
                        final phone = phoneController.text.trim();
                        final passengerData = await AuthServices.requestingData(
                          phone,
                          ref,
                        );
                        final validatePassenger =
                            await AuthServices.verifyAccount(
                              passengerData,
                              ref,
                            );
                        if (validatePassenger == null) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              customSnackBar(errorVerifyAccount.i18n, context),
                            );
                          }
                        } else if (validatePassenger == true) {
                          if (context.mounted) {
                            context.go(AppRouter.homePage);
                          }
                        } else {
                          final response = await ref
                              .read(authLoginProvider.notifier)
                              .sendCode(passengerData);
                          if (response.data?.isVerified == true) {
                            if (context.mounted) {
                              context.go(AppRouter.homePage);
                            }
                          } else {
                            await AuthServices.saveSendCodeToken(passengerData);
                            ref.read(timerProvider.notifier).startTimer();
                            if (context.mounted) {
                              context.push(
                                '${AppRouter.authPage}/${AppRouter.verifyCodePage}',
                              );
                            }
                          }
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (ref.watch(authLoginProvider).isLoading) const LoadingScreen(),
        ],
      ),
    );
  }
}
