import 'package:engine_io_shared/src/packets/packet.dart';
import 'package:engine_io_shared/src/packets/type.dart';

/// Used to close a transport.
///
/// Either party, server or client, signals that a transport can be closed.
class ClosePacket extends Packet {
  /// Creates an instance of [ClosePacket].
  const ClosePacket() : super(type: PacketType.close);
}
