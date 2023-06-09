import 'package:engine_io_shared/src/transports/exceptions.dart';

/// An exception that occurred on a polling transport.
class PollingTransportException extends TransportException {
  @override
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Creates an instance of [PollingTransportException].
  const PollingTransportException({
    required super.statusCode,
    required super.reasonPhrase,
  });

  /// The client sent a GET request, even though one was already active at the
  /// time.
  static const duplicateGetRequest = PollingTransportException(
    statusCode: 400,
    reasonPhrase:
        'There may not be more than one GET request active at any given time.',
  );

  /// The client sent a POST request, even though one was already active at the
  /// time.
  static const duplicatePostRequest = PollingTransportException(
    statusCode: 400,
    reasonPhrase:
        'There may not be more than one POST request active at any given time.',
  );

  /// The server failed to read the body of a request.
  static const readingBodyFailed = PollingTransportException(
    statusCode: 400,
    reasonPhrase: 'Failed to read request body.',
  );

  /// The client specified a content length that did not match the actual
  /// content length.
  static const contentLengthDisparity = PollingTransportException(
    statusCode: 400,
    reasonPhrase:
        '''Detected a content length different to the one provided by the client.''',
  );

  /// The configured limit on the byte length of a HTTP request payload was
  /// exceeded.
  static const contentLengthLimitExceeded = PollingTransportException(
    statusCode: 400,
    reasonPhrase: 'Maximum payload chunk length exceeded.',
  );

  /// The server failed to decode the body of a request.
  static const decodingBodyFailed = PollingTransportException(
    statusCode: 400,
    reasonPhrase: 'Failed to decode request body as utf8.',
  );

  /// The server failed to decode packets encoded and concatenated in the
  /// request body.
  static const decodingPacketsFailed = PollingTransportException(
    statusCode: 400,
    reasonPhrase: 'Failed to decode packet(s) from the request body.',
  );

  /// The client did not provide a content type, but the detected content type
  /// was different to the implicit content type.
  static const contentTypeDifferentToImplicit = PollingTransportException(
    statusCode: 400,
    reasonPhrase:
        'Detected a content type different to the implicit content type.',
  );

  /// The content type detected by the server was different to the content type
  /// the client provided.
  static const contentTypeDifferentToSpecified = PollingTransportException(
    statusCode: 400,
    reasonPhrase:
        'Detected a content type different to the one specified by the client.',
  );
}
