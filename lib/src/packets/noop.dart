import 'package:meta/meta.dart';

import 'package:engine_io_dart/src/packet.dart';

/// Used in the upgrade process.
///
/// During an upgrade to a new connection, the server responds to any remaining,
/// pending requests on the old connection with a packet of type
/// `PacketType.noop`.
@immutable
@sealed
class NoopPacket extends Packet {
  /// Creates an instance of `NoopPacket`.
  const NoopPacket() : super(type: PacketType.noop);
}