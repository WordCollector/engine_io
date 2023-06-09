import 'package:engine_io_shared/src/packets/type.dart';
import 'package:engine_io_shared/src/transports/connection_type.dart';
import 'package:engine_io_shared/src/utils.dart';

/// Options for the connection.
///
/// The server defines these options and transmits them to its clients, who then
/// save them and act in accordance with them.
class ConnectionOptions {
  /// The available/supported types of connection dictated by the engine.io server.
  final Set<ConnectionType> availableConnectionTypes;

  /// Server-side:
  /// - The amount of time the server should wait in-between sending
  /// [PacketType.ping] packets.
  ///
  /// Client-side:
  /// - After responding to a [PacketType.ping] packet sent by the server, the
  /// amount of time the client should wait before expecting another
  /// [PacketType.ping] packet.
  final Duration heartbeatInterval;

  /// Server-side:
  /// - The amount of time the server should allow for a client to respond to a
  /// [PacketType.ping] packet before closing the transport.
  ///
  /// Client-side:
  /// - The amount of time the client show allow for a server to send a
  /// [PacketType.ping] packet before closing the connection.
  final Duration heartbeatTimeout;

  /// The maximum number of bytes that can be transmitted in a single payload.
  final int maximumChunkBytes;

  /// Creates an instance of [ConnectionOptions].
  const ConnectionOptions({
    required this.availableConnectionTypes,
    required this.heartbeatInterval,
    required this.heartbeatTimeout,
    required this.maximumChunkBytes,
  });

  @override
  String toString() {
    final connectionTypesFormatted = availableConnectionTypes
        .map((connectionType) => connectionType.name)
        .join(', ');

    return '''
Available connection types: $connectionTypesFormatted
Heartbeat interval: ${heartbeatInterval.inSeconds.toStringAsFixed(1)} s
Heartbeat timeout: ${heartbeatTimeout.inSeconds.toStringAsFixed(1)} s
Maximum chunk bytes: ${(maximumChunkBytes / 1024).toStringAsFixed(1)} KiB''';
  }

  @override
  bool operator ==(Object other) =>
      other is ConnectionOptions &&
      setsEqual(other.availableConnectionTypes, availableConnectionTypes) &&
      other.heartbeatInterval == heartbeatInterval &&
      other.heartbeatTimeout == heartbeatTimeout &&
      other.maximumChunkBytes == maximumChunkBytes;

  @override
  int get hashCode => Object.hash(
        availableConnectionTypes,
        heartbeatInterval,
        heartbeatTimeout,
        maximumChunkBytes,
      );
}
