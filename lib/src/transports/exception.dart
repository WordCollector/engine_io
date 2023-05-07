import 'package:universal_io/io.dart';

import 'package:engine_io_dart/src/exception.dart';

/// An exception that occurred on the transport.
class TransportException extends EngineException {
  @override
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Creates an instance of `TransportException`.
  const TransportException({
    required super.statusCode,
    required super.reasonPhrase,
  });

  /// A heartbeat was not received in time, and timed out.
  static const heartbeatTimedOut = TransportException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Did not respond to a heartbeat in time.',
  );

  /// The client sent a hearbeat (a `pong` request) that the server did not
  /// expect to receive.
  static const heartbeatUnexpected = TransportException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'The server did not expect to receive a heartbeat at this time.',
  );

  /// The client sent a packet it should not have sent.
  ///
  /// Packets that are illegal for the client to send include `open`, `close`,
  /// non-probe `ping` and probe `pong` packets.
  static const packetIllegal = TransportException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Received a packet that is not legal to be sent by the client.',
  );

  /// The upgrade the client solicited is not valid. For example, the client
  /// could have requested an downgrade from websocket to polling.
  static const upgradeCourseNotAllowed = TransportException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        '''Upgrades from the current connection method to the desired one are not allowed.''',
  );

  /// The upgrade request the client sent is not valid.
  static const upgradeRequestInvalid = TransportException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'The HTTP request received is not a valid websocket upgrade request.',
  );

  /// The client sent a duplicate upgrade request.
  static const upgradeAlreadyInitiated = TransportException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Attempted to initiate upgrade process when one was already underway.',
  );

  /// The client requested the transport to be closed.
  static const requestedClosure = TransportException(
    statusCode: HttpStatus.ok,
    reasonPhrase: 'The client requested the transport to be closed.',
  );
}
