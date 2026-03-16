import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  late IO.Socket _socket;
  final String _url;
  final String _token;
  SocketService(this._url, this._token) {
    initConnection();
  }

  void initConnection() {
    _socket = IO.io(
      _url,
      IO.OptionBuilder().setTransports(['websocket']).setExtraHeaders({
        "Authorization": _token,
      }).build(),
    );
    _socket.connect();
    _socket.onConnect((_) {
      print('Connected to server');
    });
    _socket.onDisconnect((_) {
      print('Disconnected from server');
    });
    _socket.onError((data) {
      print('Error: $data');
    });
  }

  void sendMessage(String event, dynamic data) {
    _socket.emit(event, data);
  }

  void onMessage(String event, Function(dynamic) handler) {
    _socket.on(event, handler);
  }

  void disconnect() {
    _socket.disconnect();
  }

  IO.Socket get socket => _socket;
}
