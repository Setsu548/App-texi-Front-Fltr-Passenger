import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:texi_passenger/core/utils/secure_storage_services.dart';
import 'package:texi_passenger/core/utils/socket_service.dart';

final socketProvider = FutureProvider<SocketService?>((ref) async {
  final storage = GetIt.instance<SecureStorageService>();
  final token = await storage.getString(SecureKeys.authToken);
  final url = dotenv.env['WEB_SOCKET'];

  if (token == null || url == null) {
    return null;
  }

  final socket = SocketService(url, token);
  ref.onDispose(() => socket.disconnect());
  return socket;
});
