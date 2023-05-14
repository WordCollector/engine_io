import 'package:meta/meta.dart';
import 'package:universal_io/io.dart';

import 'package:engine_io_server/src/exception.dart';

/// An exception that occurred either on the server when a client was
/// establishing a connection, or on the socket itself during communication.
@immutable
@sealed
class SocketException extends EngineException {
  @override
  @nonVirtual
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Creates an instance of `SocketException`.
  @literal
  const SocketException({
    required super.statusCode,
    required super.reasonPhrase,
  });

  /// The server could not obtain the IP address of the client making the
  /// request.
  static const ipAddressUnobtainable = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Unable to obtain IP address.',
  );

  /// The path the server is hosted at is invalid.
  static const serverPathInvalid = SocketException(
    statusCode: HttpStatus.forbidden,
    reasonPhrase: 'Invalid server path.',
  );

  /// The HTTP method the client used is not allowed.
  static const methodNotAllowed = SocketException(
    statusCode: HttpStatus.methodNotAllowed,
    reasonPhrase: 'Method not allowed.',
  );

  /// To initiate a handshake and to open a connection, the client must send a
  /// GET request. The client did not do that.
  static const getExpected = SocketException(
    statusCode: HttpStatus.methodNotAllowed,
    reasonPhrase: 'Expected a GET request.',
  );

  /// A HTTP query did not contain one or more of the mandatory parameters.
  static const missingMandatoryParameters = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        "Parameters 'EIO' and 'transport' must be present in every query.",
  );

  /// The type of the protocol version the client specified was invalid.
  static const protocolVersionInvalidType = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'The protocol version must be a positive integer.',
  );

  /// The protocol version the client specified was invalid.
  static const protocolVersionInvalid = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Invalid protocol version.',
  );

  /// The protocol version the client specified is not supported by this server.
  static const protocolVersionUnsupported = SocketException(
    statusCode: HttpStatus.forbidden,
    reasonPhrase: 'Protocol version not supported.',
  );

  /// The type of connection the client solicited was invalid.
  static const connectionTypeInvalid = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Invalid connection type.',
  );

  /// The type of connection the client solicited is not accepted by this
  /// server.
  static const connectionTypeUnavailable = SocketException(
    statusCode: HttpStatus.forbidden,
    reasonPhrase: 'Connection type not accepted by this server.',
  );

  /// The client did not provide a session identifier when the connection was
  /// active.
  static const sessionIdentifierRequired = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        "Clients with an active connection must provide the 'sid' parameter.",
  );

  /// The client provided a session identifier when a connection wasn't active.
  static const sessionIdentifierUnexpected = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Provided session identifier when connection not established.',
  );

  /// The session identifier the client provided does not exist or is not of the
  /// valid format.
  ///
  /// For security reasons, the distinction between a session identifier not
  /// existing and it being invalid is not made.
  static const sessionIdentifierInvalid = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Invalid session identifier.',
  );

  /// The client sent a HTTP websocket upgrade request without specifying the
  /// new connection type as 'websocket'.
  static const upgradeRequestUnexpected = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Sent a HTTP websocket upgrade request when not seeking upgrade.',
  );

  /// The client sent a GET request that wasn't an upgrade when the connection
  /// was not polling.
  static const getRequestUnexpected = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Received unexpected GET request.',
  );

  /// The client sent a POST request when the connection was not polling.
  static const postRequestUnexpected = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Received POST request, but the connection is not polling.',
  );

  /// An exception occurred on the transport that caused this socket to
  /// disconnect.
  static const transportException = SocketException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        '''An exception occurred on the transport that caused the socket to be disconnected.''',
  );

  /// The client requested the connection to be closed.
  static const requestedClosure = SocketException(
    statusCode: HttpStatus.ok,
    reasonPhrase: 'The client requested the connection to be closed.',
  );

  /// The server was closing.
  static const serverClosing = SocketException(
    statusCode: HttpStatus.ok,
    reasonPhrase: 'The server is closing.',
  );
}