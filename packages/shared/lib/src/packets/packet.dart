import 'package:engine_io_shared/src/packets/type.dart';
import 'package:engine_io_shared/src/packets/types/close.dart';
import 'package:engine_io_shared/src/packets/types/message.dart';
import 'package:engine_io_shared/src/packets/types/noop.dart';
import 'package:engine_io_shared/src/packets/types/open.dart';
import 'package:engine_io_shared/src/packets/types/ping.dart';
import 'package:engine_io_shared/src/packets/types/pong.dart';
import 'package:engine_io_shared/src/packets/types/upgrade.dart';

/// Contains well-defined packet contents.
class PacketContents {
  /// An empty packet content.
  static const empty = '';

  /// Applies to packets of type [PacketType.ping] and [PacketType.pong] when
  /// used to 'probe' a new transport, i.e. ensuring that it is operational and
  /// is processing packets.
  static const probe = 'probe';
}

/// Represents a unit of data passed between parties, client and server.
abstract class Packet {
  /// Defines packets that contain binary data.
  static const binaryPackets = {PacketType.binaryMessage};

  /// Defines packets that contain JSON data.
  static const jsonPackets = {PacketType.open};

  /// Matches to a valid engine.io packet.
  static final packetExpression = RegExp(r'^([0-6b])(.*?)$');

  /// Reference to a close packet used as an alias.
  static const close = ClosePacket();

  /// Reference to a ping packet used as an alias.
  static const ping = PingPacket();

  /// Reference to a probe ping packet used as an alias.
  static const pingProbe = PingPacket(isProbe: true);

  /// Reference to a pong packet used as an alias.
  static const pong = PongPacket();

  /// Reference to a probe pong packet used as an alias.
  static const pongProbe = PongPacket(isProbe: true);

  /// Reference to an upgrade packet used as an alias.
  static const upgrade = UpgradePacket();

  /// Reference to a noop packet used as an alias.
  static const noop = NoopPacket();

  /// The type of this packet.
  final PacketType type;

  /// Creates an instance of [Packet] with the given [type].
  const Packet({required this.type});

  /// Indicates whether or not this packet has a binary payload.
  bool get isBinary => binaryPackets.contains(type);

  /// Indicates whether or not this packet has a binary payload.
  bool get isJSON => jsonPackets.contains(type);

  /// Gets the packet content in its encoded format.
  String get encoded => PacketContents.empty;

  /// Encodes a packet ready to be sent to the other party in the connection.
  static String encode(Packet packet) => '${packet.type.id}${packet.encoded}';

  /// Taking an packet in its [encoded] format, attempts to decode it.
  ///
  /// ⚠️ Throws a [FormatException] if the [encoded] packet is invalid.
  static Packet decode(String encoded) {
    final match = packetExpression.firstMatch(encoded);
    if (match == null) {
      throw const FormatException('Invalid packet encoding.');
    }

    final id = match[1]!;
    final content = match[2]!;

    final packetType = PacketType.byId(id);

    final Packet packet;
    switch (packetType) {
      case PacketType.open:
        packet = OpenPacket.decode(content);
      case PacketType.close:
        packet = const ClosePacket();
      case PacketType.ping:
        packet = PingPacket.decode(content);
      case PacketType.pong:
        packet = PongPacket.decode(content);
      case PacketType.textMessage:
        packet = TextMessagePacket.decode(content);
      case PacketType.binaryMessage:
        packet = BinaryMessagePacket.decode(content);
      case PacketType.upgrade:
        packet = const UpgradePacket();
      case PacketType.noop:
        packet = const NoopPacket();
    }

    return packet;
  }
}

/// A packet used in the upgrade process to ensure that a new transport
/// is operational and is processing packets before upgrading.
abstract class ProbePacket extends Packet {
  /// Determines whether or not this is a probe packet.
  final bool isProbe;

  /// The content of this packet, either empty or equal to 'probe'.
  ///
  /// This value is known beforehand and determined by the value of [isProbe].
  final String _content;

  /// Creates an instance of [ProbePacket].
  ///
  /// [isProbe] - Whether the packet is a probe packet, used for probing a new
  /// transport, rather than for the heartbeat.
  const ProbePacket({required super.type, required this.isProbe})
      : _content = isProbe ? PacketContents.probe : PacketContents.empty;

  @override
  String get encoded => _content;
}
