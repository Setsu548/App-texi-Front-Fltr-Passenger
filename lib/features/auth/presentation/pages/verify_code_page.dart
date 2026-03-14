import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/widgets/custom_snack_bar.dart';
import 'package:texi_passenger/core/widgets/elevated_button_widget.dart';
import 'package:texi_passenger/features/auth/presentation/providers/auth_providers.dart';
import 'package:texi_passenger/features/auth/services/auth_services.dart';

class VerifyCodePage extends ConsumerStatefulWidget {
  const VerifyCodePage({super.key});

  @override
  ConsumerState<VerifyCodePage> createState() => _VerifyCodePageState();
}

class _VerifyCodePageState extends ConsumerState<VerifyCodePage> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(4, (index) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value, int index) {
    if (value.isNotEmpty && index < 3) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _onKeyEvent(KeyEvent event, int index) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.backspace) {
      if (_controllers[index].text.isEmpty && index > 0) {
        _focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final timerValue = ref.watch(timerProvider);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 5.h),
                // Shield Icon
                Container(
                  width: 15.w,
                  height: 15.w,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.security_rounded,
                      size: 8.w,
                      color: Colors.black, // Dark icon inside yellow circle
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                // Title
                Text(
                  titleVerifyAccount.i18n,
                  style: StylesForTexts(context: context)
                      .headerStyle()
                      .copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
                SizedBox(height: 2.h),
                // Subtitle
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Text(
                    subtitleVerifyAccount.i18n,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 4.h),
                // Code Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return KeyboardListener(
                      focusNode: FocusNode(),
                      onKeyEvent: (event) => _onKeyEvent(event, index),
                      child: Container(
                        width: 16.w,
                        height: 16.w,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Theme.of(
                                context,
                              ).colorScheme.primary.withValues(alpha: 0.08),
                              blurRadius: 2,
                              spreadRadius: 2,
                            ),
                          ],
                          color: Theme.of(context).colorScheme.tertiary
                              .withValues(
                                alpha: 0.2,
                              ), // similar to LabelTextfieldWidget
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withValues(
                              alpha: _focusNodes[index].hasFocus ? 1.0 : 0.45,
                            ),
                            width: 1.25,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1, // Only 1 digit per field
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              counterText: '', // Hide length counter
                            ),
                            onChanged: (value) {
                              setState(() {});
                              _onChanged(value, index);
                            },
                            onTap: () {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 2.5.h),
                Consumer(
                  builder: (context, ref, child) {
                    final minutes = (timerValue / 60).floor();
                    final seconds = timerValue % 60;
                    final formattedTime =
                        '$minutes:${seconds.toString().padLeft(2, '0')}';
                    return Text(
                      formattedTime,
                      style: TextStyle(
                        color: timerValue <= 0
                            ? Theme.of(
                                context,
                              ).primaryColor.withValues(alpha: 0.5)
                            : Theme.of(context).primaryColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
                SizedBox(height: 5.h),
                ElevatedButtonWidget(
                  label: verifyButton.i18n,
                  onPressed: () async {
                    final time = ref.watch(timerProvider);
                    if (time <= 0) {
                      _showMessage(timerExpired.i18n);
                      return;
                    }
                    final code = _controllers.map((c) => c.text).join();
                    if (await AuthServices.verifyCode(code, ref)) {
                      context.mounted
                          ? context.push(
                              '${AppRouter.authPage}/${AppRouter.passengerProfilePage}',
                            )
                          : null;
                    } else {
                      _showMessage(errorVerifyCode.i18n);
                    }
                  },
                ),
                SizedBox(height: 4.h),
                Text(
                  didNotReceiveCode.i18n,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    ref.read(timerProvider.notifier).resetTimer();
                    ref.read(timerProvider.notifier).startTimer();
                  },
                  child: Text(
                    resendCode.i18n,
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(customSnackBar(message, context));
  }
}
