import 'package:universal_io/io.dart';

import 'package:engine_io_dart/src/engine.dart';

/// An exception that occurred on the server.
class ServerException extends EngineException {
  /// Creates an instance of `ServerException`.
  const ServerException({
    required super.statusCode,
    required super.reasonPhrase,
  });

  /// The server could not obtain the IP address of the party making a request.
  static const ipAddressUnobtainable = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Unable to obtain IP address.',
  );

  /// The path the server is hosted at is invalid.
  static const serverPathInvalid = ServerException(
    statusCode: HttpStatus.forbidden,
    reasonPhrase: 'Invalid server path.',
  );

  /// The HTTP method the client used is not allowed.
  static const methodNotAllowed = ServerException(
    statusCode: HttpStatus.methodNotAllowed,
    reasonPhrase: 'Method not allowed.',
  );

  /// To initiate a handshake and to open a connection, the client must send a
  /// GET request. The client did not do that.
  static const getExpected = ServerException(
    statusCode: HttpStatus.methodNotAllowed,
    reasonPhrase: 'Expected a GET request.',
  );

  /// A HTTP query did not contain one or more of the mandatory parameters.
  static const missingMandatoryParameters = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        "Parameters 'EIO' and 'transport' must be present in every query.",
  );

  /// The type of the protocol version the client specified was invalid.
  static const protocolVersionInvalidType = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'The protocol version must be a positive integer.',
  );

  /// The protocol version the client specified was invalid.
  static const protocolVersionInvalid = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Invalid protocol version.',
  );

  /// The protocol version the client specified is not supported by this server.
  static const protocolVersionUnsupported = ServerException(
    statusCode: HttpStatus.forbidden,
    reasonPhrase: 'Protocol version not supported.',
  );

  /// The type of connection the client solicited was invalid.
  static const connectionTypeInvalid = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Invalid connection type.',
  );

  /// The type of connection the client solicited is not accepted by this
  /// server.
  static const connectionTypeUnavailable = ServerException(
    statusCode: HttpStatus.forbidden,
    reasonPhrase: 'Connection type not accepted by this server.',
  );

  /// The client did not provide a session identifier when the connection was
  /// active.
  static const sessionIdentifierRequired = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        "Clients with an active connection must provide the 'sid' parameter.",
  );

  /// The client provided a session identifier when a connection wasn't active.
  static const sessionIdentifierUnexpected = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Provided session identifier when connection not established.',
  );

  /// The session identifier the client provided does not exist.
  static const sessionIdentifierInvalid = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Invalid session identifier.',
  );

  /// The upgrade the client solicited is not valid. For example, the client
  /// could have requested an downgrade from websocket to polling.
  static const upgradeCourseNotAllowed = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        '''Upgrades from the current connection method to the desired one are not allowed.''',
  );

  /// The upgrade request the client sent is not valid.
  static const upgradeRequestInvalid = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'The HTTP request received is not a valid websocket upgrade request.',
  );

  /// The client sent a HTTP websocket upgrade request without specifying the
  /// new connection type as 'websocket'.
  static const upgradeRequestUnexpected = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Sent a HTTP websocket upgrade request when not seeking upgrade.',
  );

  /// The client sent a duplicate upgrade request.
  static const upgradeAlreadyInitiated = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Attempted to initiate upgrade process when one was already underway.',
  );

  /// The client sent a GET request that wasn't an upgrade when the connection
  /// was not polling.
  static const getRequestUnexpected = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Received unexpected GET request.',
  );

  /// The client sent a POST request when the connection was not polling.
  static const postRequestUnexpected = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Received POST request, but the connection is not polling.',
  );

  /// The client sent a POST request, even though one was already active at the
  /// time.
  static const duplicatePostRequest = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'There may not be more than one POST request active at any given time.',
  );

  /// The server failed to read the body of a request.
  static const readingBodyFailed = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Failed to read request body.',
  );

  /// The server failed to decode the body of a request.
  static const decodingBodyFailed = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Failed to decode request body as utf8.',
  );

  /// The server failed to decode packets encoded and concatenated in the
  /// request body.
  static const decodingPacketsFailed = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Failed to decode packet(s) from the request body.',
  );

  /// The client specified a content length that did not match the actual
  /// content length.
  static const contentLengthDisparity = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        '''Detected a content length different to the one provided by the client.''',
  );

  /// The configured limit on the byte length of a HTTP request payload was
  /// exceeded.
  static const contentLengthLimitExceeded = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase: 'Maximum payload chunk length exceeded.',
  );

  /// The client did not provide a content type, but the detected content type
  /// was different to the implicit content type.
  static const contentTypeDifferentToImplicit = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Detected a content type different to the implicit content type.',
  );

  /// The content type detected by the server was different to the content type
  /// the client provided.
  static const contentTypeDifferentToSpecified = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Detected a content type different to the one specified by the client.',
  );

  /// The client sent a packet it should not have sent.
  ///
  /// Packets that are illegal for the client to send include `open`, `close`,
  /// non-probe `ping` and probe `pong` packets.
  static const packetIllegal = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'Received a packet that is not legal to be sent by the client.',
  );

  /// The client sent a hearbeat (a `pong` request) that the server did not
  /// expect to receive.
  static const heartbeatUnexpected = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        'The server did not expect to receive a heartbeat at this time.',
  );

  /// An exception occurred on the transport that caused this socket to
  /// disconnect.
  static const transportException = ServerException(
    statusCode: HttpStatus.badRequest,
    reasonPhrase:
        '''An exception occurred on the transport that caused the socket to be disconnected.''',
  );

  /// The client requested the connection to be closed.
  static const requestedClosure = ServerException(
    statusCode: HttpStatus.ok,
    reasonPhrase: 'The client requested the connection to be closed.',
  );

  /// The server was closing.
  static const serverClosing = ServerException(
    statusCode: HttpStatus.ok,
    reasonPhrase: 'The server is closing.',
  );
}
