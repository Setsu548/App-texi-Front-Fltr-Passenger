import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:texi_passenger/core/lang/extension_lang.dart';
import 'package:texi_passenger/core/router/app_router.dart';
import 'package:texi_passenger/core/theme/styles_for_texts.dart';
import 'package:texi_passenger/core/utils/secure_storage_services.dart';
import 'package:texi_passenger/core/widgets/elevated_button_widget.dart';
import 'package:texi_passenger/core/widgets/label_textfield_widget.dart';
import 'package:texi_passenger/core/widgets/modal_options_image_picker.dart';
import 'package:texi_passenger/features/auth/presentation/providers/auth_providers.dart';
import 'package:texi_passenger/features/auth/services/auth_services.dart';

class PassengerProfilePage extends ConsumerStatefulWidget {
  const PassengerProfilePage({super.key});

  @override
  ConsumerState<PassengerProfilePage> createState() =>
      _PassengerProfilePageState();
}

class _PassengerProfilePageState extends ConsumerState<PassengerProfilePage> {
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    getPhone();
  }

  void getPhone() async {
    final secureStorage = GetIt.instance<SecureStorageService>();
    final phone = await secureStorage.getString('phone');
    _phoneController.text = phone ?? '';
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final countrySelected = ref.watch(selectedCountryProvider);
    final image = ref.watch(passegerImageProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Text(
                  profileInfoTitle.i18n,
                  style: StylesForTexts(context: context).headerStyle(),
                ),
                SizedBox(height: 1.h),
                Text(
                  profileInfoSubtitle.i18n,
                  style: StylesForTexts(context: context).headerStyleSmall(),
                ),
                SizedBox(height: 4.h),
                Container(
                  padding: EdgeInsets.all(5.w),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        LabelTextfieldWidget(
                          label: fullNameLabel.i18n,
                          hintText: fullNameHint.i18n,
                          controller: _fullNameController,
                          textCapitalization: TextCapitalization.words,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return fieldRequired.i18n;
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 3.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              phoneNumberLabel.i18n,
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 1.15.h),
                            Row(
                              children: [
                                Text(
                                  countrySelected.dialCode,
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 15.5.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 3.w),
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 2.45.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary
                                          .withValues(alpha: 0.25),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        color: Theme.of(
                                          context,
                                        ).primaryColor.withValues(alpha: 0.5),
                                        width: 1.25,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _phoneController,
                                      keyboardType: TextInputType.phone,
                                      readOnly: true,
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.secondary,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: '77777777',
                                        hintStyle: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary
                                              .withValues(alpha: 0.5),
                                          fontStyle: FontStyle.italic,
                                        ),
                                      ),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return phoneNumberRequired.i18n;
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.secondary.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(
                        context,
                      ).colorScheme.secondary.withValues(alpha: 0.5),
                      width: 2,
                      style: BorderStyle.none,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      image == null
                          ? SizedBox(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.camera_alt_outlined,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .secondary
                                        .withValues(alpha: 0.5),
                                    size: 15.w,
                                  ),
                                  SizedBox(height: 2.h),
                                  Text(
                                    uploadProfilePhoto.i18n,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary
                                          .withValues(alpha: 0.5),
                                      fontSize: 13.85.sp,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : CircleAvatar(
                              radius: 15.85.w,
                              backgroundImage: FileImage(File(image.path)),
                            ),
                      SizedBox(height: 2.h),
                      ElevatedButtonWidget(
                        label: selectImageButton.i18n,
                        onPressed: () {
                          _showModalBottomSheet();
                        },
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 5.h),
                Center(
                  child: ElevatedButtonWidget(
                    label: continueButton.i18n,
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final phoneNumber = _phoneController.text.trim();
                        final fullName = _fullNameController.text.trim();
                        final response = await AuthServices.registerPassenger(
                          phoneNumber,
                          fullName,
                          image,
                          ref,
                        );
                        if (response.success) {
                          context.mounted
                              ? context.go(AppRouter.homePage)
                              : null;
                        }
                      }
                    },
                  ),
                ),

                SizedBox(height: 3.h),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12.75.sp,
                      ),
                      children: [
                        TextSpan(text: termsAndConditionsText.i18n),
                        TextSpan(
                          text: termsAndConditionsLink.i18n,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => ModalOptionsImagePicker(
        options: [
          ModalOptionImage(
            icon: Icons.camera_alt,
            title: 'Camera',
            onTap: () async {
              final file = await ImagePicker().pickImage(
                source: ImageSource.camera,
              );
              if (file != null) {
                ref.read(passegerImageProvider.notifier).setImage(file);
                context.pop();
              }
            },
          ),
          ModalOptionImage(
            icon: Icons.photo,
            title: 'Gallery',
            onTap: () async {
              final file = await ImagePicker().pickImage(
                source: ImageSource.gallery,
              );
              if (file != null) {
                ref.read(passegerImageProvider.notifier).setImage(file);
                context.pop();
              }
            },
          ),
        ],
      ),
    );
  }
}
