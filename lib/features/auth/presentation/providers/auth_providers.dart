import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:phonecodes/phonecodes.dart';
import 'package:texi_passenger/core/const/data_api_response.dart';
import 'package:texi_passenger/core/providers/dio_provider.dart';
import 'package:texi_passenger/core/const/enums.dart';
import 'package:texi_passenger/features/auth/data/models/passenger_send_code_res_model.dart';
import 'package:texi_passenger/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:texi_passenger/features/auth/domain/entities/passenger_auth_data_entity.dart';
import 'package:texi_passenger/features/auth/domain/repo/auth_repo.dart';
import 'package:texi_passenger/features/auth/services/auth_services.dart';

class CountriesNotifier extends Notifier<List<Country>> {
  @override
  List<Country> build() {
    final countries = Countries.list;
    final latamEnum = LatamCountries.values
        .map((country) => country.name)
        .toList();

    final latamCountries = countries.where((country) {
      final countryName = country.name.toLowerCase();
      return latamEnum.contains(countryName);
    }).toList();
    return latamCountries;
  }
}

final countriesProvider = NotifierProvider<CountriesNotifier, List<Country>>(
  CountriesNotifier.new,
);

class LocalCountryNotifier extends Notifier<Country> {
  @override
  Country build() {
    final countries = ref.watch(countriesProvider);
    return countries.firstWhere(
      (element) => element.name.toLowerCase() == 'bolivia',
      orElse: () => countries.first,
    );
  }

  void selectCountry(Country country) {
    state = country;
  }
}

final selectedCountryProvider = NotifierProvider<LocalCountryNotifier, Country>(
  LocalCountryNotifier.new,
);

final authRepoProvider = Provider<AuthRepo>((ref) {
  return AuthRepoImpl(ref.watch(dioProvider));
});

final authLoginProvider =
    NotifierProvider<
      AuthLoginNotifier,
      AsyncValue<DataApiResponse<PassengerSendCodeResModel>>
    >(AuthLoginNotifier.new);

class AuthLoginNotifier
    extends Notifier<AsyncValue<DataApiResponse<PassengerSendCodeResModel>>> {
  @override
  AsyncValue<DataApiResponse<PassengerSendCodeResModel>> build() {
    return AsyncValue.data(
      DataApiResponse(
        code: '',
        data: null,
        error: null,
        message: '',
        statusCode: 0,
        success: false,
      ),
    );
  }

  Future<DataApiResponse<PassengerSendCodeResModel>> sendCode(
    PassengerAuthDataEntity passengerData,
  ) async {
    state = const AsyncValue.loading();
    final repo = ref.read(authRepoProvider);
    final response = await repo.passengerSendCode(passengerData);
    state = AsyncValue.data(response);
    return response;
  }

  Future<void> getAuthResDataAndSaveToken(String phone, WidgetRef ref) async {
    state = const AsyncValue.loading();
    await AuthServices.getAuthResDataAndSaveToken(
      ref.watch(dioProvider),
      phone,
      ref,
    );
    state = AsyncValue.data(
      DataApiResponse(
        code: '',
        data: null,
        error: null,
        message: '',
        statusCode: 0,
        success: true,
      ),
    );
  }
}

class TimerNotifier extends Notifier<int> {
  Timer? _timer;

  @override
  int build() {
    return 60;
  }

  void startTimer() {
    _timer?.cancel();
    state = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state > 0) {
        state--;
      } else {
        timer.cancel();
      }
    });
  }

  void resetTimer() {
    _timer?.cancel();
    state = 60;
  }
}

final timerProvider = NotifierProvider<TimerNotifier, int>(TimerNotifier.new);

class PassegerImageNotifier extends Notifier<XFile?> {
  @override
  XFile? build() {
    return null;
  }

  void setImage(XFile image) {
    state = image;
  }

  void removeImage() {
    state = null;
  }
}

final passegerImageProvider = NotifierProvider<PassegerImageNotifier, XFile?>(
  PassegerImageNotifier.new,
);
