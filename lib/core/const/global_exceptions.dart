class GlobalExceptions implements Exception {
  final String message;
  GlobalExceptions([this.message = 'Error desconocido']);

  @override
  String toString() => message;
}
