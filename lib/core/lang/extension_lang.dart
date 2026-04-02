import 'package:i18n_extension/i18n_extension.dart';

const sloganTexi = 'La forma más rápida y segura de viajar';
const messageLogin = 'Te enviaremos un código de acceso';
const requestAccessCode = 'Solicitar código';
const titleVerifyAccount = 'Verificación de cuenta';
const subtitleVerifyAccount =
    'Ingresa el código de verificación que enviamos a tu whatsapp';
const verifyButton = 'Verificar';
const didNotReceiveCode = '¿No recibiste el código?';
const resendCode = 'Reenviar código';
const profileInfoTitle = 'Información de Perfil';
const profileInfoSubtitle = 'Por favor ingresa tus datos.';
const fullNameLabel = 'Nombre Completo*';
const fullNameHint = 'Ej. Juan Pérez Rodríguez';
const phoneNumberLabel = 'Número de Teléfono*';
const uploadProfilePhoto = 'Sube una foto para tu perfil (Opcional)';
const selectImageButton = 'Seleccionar imagen';
const continueButton = 'Continuar';
const termsAndConditionsText = 'Al continuar aceptas los ';
const termsAndConditionsLink = 'términos, condiciones y política de privacidad';
const fieldRequired = 'Este campo es requerido';
const errorVerifyAccount = 'Error al verificar la cuenta';
const errorVerifyCode = 'Error al verificar el código';
const timerExpired = 'Tiempo agotado';
const phoneNumberRequired = 'El número de teléfono es requerido';
const whereAreYouGoing = '¿A dónde vas?';
const offlineTitle = '¡Ups! Sin conexión';
const offlineMessage =
    'Parece que no tienes conexión a internet en este momento. Por favor, verifica tu red e intenta de nuevo.';
const backToHome = 'Volver al inicio';
const origin = 'Origen';
const errorGettingLocation = 'Seleccione su origen o destino';
const destination = 'Destino';
const solicitRequest = 'Solicitar Viaje';
const gettingLocation = 'Obteniendo ubicación...';
const cancel = 'Cancelar';
const selectService = 'Seleccionar Servicio';
const selectServiceSubtitle = 'Selecciona el servicio que deseas';
const status = 'Estado';
const tripInformation = 'Información del viaje';
const driverOnRoad = 'Conductor en camino';
const driverArrived = 'Conductor llegó';
const tripInProgress = 'Viaje en curso';
const tripCompleted = 'Viaje finalizado';
const tripCancelled = 'Viaje cancelado';
const tripExpired = 'Viaje expirado';
const unknownStatus = 'Estado desconocido';
const ok = 'Aceptar';
const howDoYouRateTheDriver = '¿Cómo calificas al conductor?';
const rateDriver = 'Calificar conductor';
const phoneMustBe8Characters = 'El número de teléfono debe tener 8 caracteres';
const phoneMustBeNumeric = 'El número de teléfono debe ser numérico';
const offlinePositionTitle = '¡Ups! Sin ubicación';
const offlinePositionMessage =
    'Parece que tu GPS está desactivado. Por favor, actívalo para continuar.';
const offerTrip = 'Ofertar Viaje';
const activateLocation = 'Activar Ubicación';
const locationPermissionTitle = 'Permisos de ubicación requeridos';
const locationPermissionMessage =
    'La aplicación no puede funcionar sin los permisos de ubicación. Por favor, actívelos en la configuración.';
const openSettings = 'Abrir Configuración';
const appWillCloseIn = 'La aplicación se cerrará en %s segundos...';
const tokenNotFound = 'Token no encontrado';

extension Localization on String {
  static const _translations = ConstTranslations('es-MX', {
    sloganTexi: {
      'en-US': 'The fastest and safest way to travel',
      'es-ES': 'La forma más rápida y segura de viajar',
      'es-MX': 'La forma más rápida y segura de viajar',
      'es-BO': 'La forma más rápida y segura de viajar',
    },
    messageLogin: {
      'en-US': 'We will send you an access code',
      'es-ES': 'Te enviaremos un código de acceso',
      'es-MX': 'Te enviaremos un código de acceso',
      'es-BO': 'Te enviaremos un código de acceso',
    },
    requestAccessCode: {
      'en-US': 'Request access code',
      'es-ES': 'Solicitar código',
      'es-MX': 'Solicitar código',
      'es-BO': 'Solicitar código',
    },
    titleVerifyAccount: {
      'en-US': 'Account verification',
      'es-ES': 'Verificación de cuenta',
      'es-MX': 'Verificación de cuenta',
      'es-BO': 'Verificación de cuenta',
    },
    subtitleVerifyAccount: {
      'en-US': 'Enter the verification code we sent to your whatsapp',
      'es-ES': 'Ingresa el código de verificación que enviamos a tu whatsapp',
      'es-MX': 'Ingresa el código de verificación que enviamos a tu whatsapp',
      'es-BO': 'Ingresa el código de verificación que enviamos a tu whatsapp',
    },
    verifyButton: {
      'en-US': 'Verify',
      'es-ES': 'Verificar',
      'es-MX': 'Verificar',
      'es-BO': 'Verificar',
    },
    didNotReceiveCode: {
      'en-US': 'Didn\'t receive the code?',
      'es-ES': '¿No recibiste el código?',
      'es-MX': '¿No recibiste el código?',
      'es-BO': '¿No recibiste el código?',
    },
    resendCode: {
      'en-US': 'Resend code',
      'es-ES': 'Reenviar código',
      'es-MX': 'Reenviar código',
      'es-BO': 'Reenviar código',
    },
    profileInfoTitle: {
      'en-US': 'Profile Information',
      'es-ES': 'Información de Perfil',
      'es-MX': 'Información de Perfil',
      'es-BO': 'Información de Perfil',
    },
    profileInfoSubtitle: {
      'en-US': 'Please enter your details.',
      'es-ES': 'Por favor ingresa tus datos.',
      'es-MX': 'Por favor ingresa tus datos.',
      'es-BO': 'Por favor ingresa tus datos.',
    },
    fullNameLabel: {
      'en-US': 'Full Name*',
      'es-ES': 'Nombre Completo*',
      'es-MX': 'Nombre Completo*',
      'es-BO': 'Nombre Completo*',
    },
    fullNameHint: {
      'en-US': 'Ex. John Doe',
      'es-ES': 'Ej. Juan Pérez Rodríguez',
      'es-MX': 'Ej. Juan Pérez Rodríguez',
      'es-BO': 'Ej. Juan Pérez Rodríguez',
    },
    phoneNumberLabel: {
      'en-US': 'Phone Number*',
      'es-ES': 'Número de Teléfono*',
      'es-MX': 'Número de Teléfono*',
      'es-BO': 'Número de Teléfono*',
    },
    uploadProfilePhoto: {
      'en-US': 'Upload a profile photo (Optional)',
      'es-ES': 'Sube una foto para tu perfil (Opcional)',
      'es-MX': 'Sube una foto para tu perfil (Opcional)',
      'es-BO': 'Sube una foto para tu perfil (Opcional)',
    },
    selectImageButton: {
      'en-US': 'Select image',
      'es-ES': 'Seleccionar imagen',
      'es-MX': 'Seleccionar imagen',
      'es-BO': 'Seleccionar imagen',
    },
    continueButton: {
      'en-US': 'Continue',
      'es-ES': 'Continuar',
      'es-MX': 'Continuar',
      'es-BO': 'Continuar',
    },
    termsAndConditionsText: {
      'en-US': 'By continuing you accept the ',
      'es-ES': 'Al continuar aceptas los ',
      'es-MX': 'Al continuar aceptas los ',
      'es-BO': 'Al continuar aceptas los ',
    },
    termsAndConditionsLink: {
      'en-US': 'terms, conditions and privacy policy',
      'es-ES': 'términos, condiciones y política de privacidad',
      'es-MX': 'términos, condiciones y política de privacidad',
      'es-BO': 'términos, condiciones y política de privacidad',
    },
    fieldRequired: {
      'en-US': 'This field is required',
      'es-ES': 'Este campo es requerido',
      'es-MX': 'Este campo es requerido',
      'es-BO': 'Este campo es requerido',
    },
    errorVerifyAccount: {
      'en-US': 'Error verifying account',
      'es-ES': 'Error al verificar la cuenta',
      'es-MX': 'Error al verificar la cuenta',
      'es-BO': 'Error al verificar la cuenta',
    },
    errorVerifyCode: {
      'en-US': 'Error verifying code',
      'es-ES': 'Error al verificar el código',
      'es-MX': 'Error al verificar el código',
      'es-BO': 'Error al verificar el código',
    },
    timerExpired: {
      'en-US': 'Timer expired',
      'es-ES': 'Tiempo agotado',
      'es-MX': 'Tiempo agotado',
      'es-BO': 'Tiempo agotado',
    },
    phoneNumberRequired: {
      'en-US': 'Phone number is required',
      'es-ES': 'El número de teléfono es requerido',
      'es-MX': 'El número de teléfono es requerido',
      'es-BO': 'El número de teléfono es requerido',
    },
    whereAreYouGoing: {
      'en-US': 'Where are you going?',
      'es-ES': '¿A dónde vas?',
      'es-MX': '¿A dónde vas?',
      'es-BO': '¿A dónde vas?',
    },
    offlineTitle: {
      'en-US': 'Oops! No connection',
      'es-ES': '¡Ups! Sin conexión',
      'es-MX': '¡Ups! Sin conexión',
      'es-BO': '¡Ups! Sin conexión',
    },
    offlineMessage: {
      'en-US':
          'It seems you don\'t have an internet connection right now. Please check your network and try again.',
      'es-ES':
          'Parece que no tienes conexión a internet en este momento. Por favor, verifica tu red e intenta de nuevo.',
      'es-MX':
          'Parece que no tienes conexión a internet en este momento. Por favor, verifica tu red e intenta de nuevo.',
      'es-BO':
          'Parece que no tienes conexión a internet en este momento. Por favor, verifica tu red e intenta de nuevo.',
    },
    backToHome: {
      'en-US': 'Back to home',
      'es-ES': 'Volver al inicio',
      'es-MX': 'Volver al inicio',
      'es-BO': 'Volver al inicio',
    },
    origin: {
      'en-US': 'Origin',
      'es-ES': 'Origen',
      'es-MX': 'Origen',
      'es-BO': 'Origen',
    },
    errorGettingLocation: {
      'en-US': 'Select your origin or destination',
      'es-ES': 'Seleccione su origen o destino',
      'es-MX': 'Seleccione su origen o destino',
      'es-BO': 'Seleccione su origen o destino',
    },
    destination: {
      'en-US': 'Destination',
      'es-ES': 'Destino',
      'es-MX': 'Destino',
      'es-BO': 'Destino',
    },
    solicitRequest: {
      'en-US': 'Request a ride',
      'es-ES': 'Solicitar un viaje',
      'es-MX': 'Solicitar un viaje',
      'es-BO': 'Solicitar un viaje',
    },
    gettingLocation: {
      'en-US': 'Getting location...',
      'es-ES': 'Obteniendo ubicación...',
      'es-MX': 'Obteniendo ubicación...',
      'es-BO': 'Obteniendo ubicación...',
    },
    cancel: {
      'en-US': 'Cancel',
      'es-ES': 'Cancelar',
      'es-MX': 'Cancelar',
      'es-BO': 'Cancelar',
    },
    selectService: {
      'en-US': 'Select Service',
      'es-ES': 'Seleccionar Servicio',
      'es-MX': 'Seleccionar Servicio',
      'es-BO': 'Seleccionar Servicio',
    },
    selectServiceSubtitle: {
      'en-US': 'Select the service you want',
      'es-ES': 'Selecciona el servicio que deseas',
      'es-MX': 'Selecciona el servicio que deseas',
      'es-BO': 'Selecciona el servicio que deseas',
    },
    status: {
      'en-US': 'Status',
      'es-ES': 'Estado',
      'es-MX': 'Estado',
      'es-BO': 'Estado',
    },
    tripInformation: {
      'en-US': 'Trip Information',
      'es-ES': 'Información del viaje',
      'es-MX': 'Información del viaje',
      'es-BO': 'Información del viaje',
    },
    driverOnRoad: {
      'en-US': 'Driver on road',
      'es-ES': 'Conductor en camino',
      'es-MX': 'Conductor en camino',
      'es-BO': 'Conductor en camino',
    },
    driverArrived: {
      'en-US': 'Driver arrived',
      'es-ES': 'Conductor llegó',
      'es-MX': 'Conductor llegó',
      'es-BO': 'Conductor llegó',
    },
    tripInProgress: {
      'en-US': 'Trip in progress',
      'es-ES': 'Viaje en curso',
      'es-MX': 'Viaje en curso',
      'es-BO': 'Viaje en curso',
    },
    tripCompleted: {
      'en-US': 'Trip completed',
      'es-ES': 'Viaje finalizado',
      'es-MX': 'Viaje finalizado',
      'es-BO': 'Viaje finalizado',
    },
    tripCancelled: {
      'en-US': 'Trip cancelled',
      'es-ES': 'Viaje cancelado',
      'es-MX': 'Viaje cancelado',
      'es-BO': 'Viaje cancelado',
    },
    tripExpired: {
      'en-US': 'Trip expired',
      'es-ES': 'Viaje expirado',
      'es-MX': 'Viaje expirado',
      'es-BO': 'Viaje expirado',
    },
    unknownStatus: {
      'en-US': 'Unknown status',
      'es-ES': 'Estado desconocido',
      'es-MX': 'Estado desconocido',
      'es-BO': 'Estado desconocido',
    },
    ok: {
      'en-US': 'OK',
      'es-ES': 'Aceptar',
      'es-MX': 'Aceptar',
      'es-BO': 'Aceptar',
    },
    howDoYouRateTheDriver: {
      'en-US': 'How do you rate the driver?',
      'es-ES': '¿Cómo calificas al conductor?',
      'es-MX': '¿Cómo calificas al conductor?',
      'es-BO': '¿Cómo calificas al conductor?',
    },
    rateDriver: {
      'en-US': 'Rate driver',
      'es-ES': 'Calificar conductor',
      'es-MX': 'Calificar conductor',
      'es-BO': 'Calificar conductor',
    },
    phoneMustBe8Characters: {
      'en-US': 'Phone number must be 8 characters',
      'es-ES': 'El número de teléfono debe tener 8 caracteres',
      'es-MX': 'El número de teléfono debe tener 8 caracteres',
      'es-BO': 'El número de teléfono debe tener 8 caracteres',
    },
    phoneMustBeNumeric: {
      'en-US': 'Phone number must be numeric',
      'es-ES': 'El número de teléfono debe ser numérico',
      'es-MX': 'El número de teléfono debe ser numérico',
      'es-BO': 'El número de teléfono debe ser numérico',
    },
    offlinePositionTitle: {
      'en-US': 'Oops! No location',
      'es-ES': '¡Ups! Sin ubicación',
      'es-MX': '¡Ups! Sin ubicación',
      'es-BO': '¡Ups! Sin ubicación',
    },
    offlinePositionMessage: {
      'en-US': 'It seems your GPS is disabled. Please turn it on to continue.',
      'es-ES':
          'Parece que tu GPS está desactivado. Por favor, actívalo para continuar.',
      'es-MX':
          'Parece que tu GPS está desactivado. Por favor, actívalo para continuar.',
      'es-BO':
          'Parece que tu GPS está desactivado. Por favor, actívalo para continuar.',
    },
    offerTrip: {
      'en-US': 'Offer trip',
      'es-ES': 'Ofertar viaje',
      'es-MX': 'Ofertar viaje',
      'es-BO': 'Ofertar viaje',
    },
    activateLocation: {
      'en-US': 'Activate location',
      'es-ES': 'Activar ubicación',
      'es-MX': 'Activar ubicación',
      'es-BO': 'Activar ubicación',
    },
    locationPermissionTitle: {
      'en-US': 'Location permissions required',
      'es-ES': 'Permisos de ubicación requeridos',
      'es-MX': 'Permisos de ubicación requeridos',
      'es-BO': 'Permisos de ubicación requeridos',
    },
    locationPermissionMessage: {
      'en-US':
          'The application cannot function without location permissions. Please enable them in settings.',
      'es-ES':
          'La aplicación no puede funcionar sin los permisos de ubicación. Por favor, actívelos en la configuración.',
      'es-MX':
          'La aplicación no puede funcionar sin los permisos de ubicación. Por favor, actívelos en la configuración.',
      'es-BO':
          'La aplicación no puede funcionar sin los permisos de ubicación. Por favor, actívelos en la configuración.',
    },
    openSettings: {
      'en-US': 'Open Settings',
      'es-ES': 'Abrir Configuración',
      'es-MX': 'Abrir Configuración',
      'es-BO': 'Abrir Configuración',
    },
    appWillCloseIn: {
      'en-US': 'The application will close in %s seconds...',
      'es-ES': 'La aplicación se cerrará en %s segundos...',
      'es-MX': 'La aplicación se cerrará en %s segundos...',
      'es-BO': 'La aplicación se cerrará en %s segundos...',
    },
    tokenNotFound: {
      'en-US': 'Token not found',
      'es-ES': 'Token no encontrado',
      'es-MX': 'Token no encontrado',
      'es-BO': 'Token no encontrado',
    },
  });

  String get i18n => localize(this, _translations);
}
