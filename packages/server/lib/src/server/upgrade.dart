import 'dart:async';

import 'package:meta/meta.dart';

import 'package:engine_io_server/src/server/socket.dart';
import 'package:engine_io_server/src/transports/exception.dart';
import 'package:engine_io_server/src/transports/transport.dart';

/// Represents the status of a transport upgrade.
enum UpgradeStatus {
  /// The transport is not being upgraded.
  none,

  /// A transport upgrade has been initiated.
  initiated,

  /// The new transport has been probed, and the upgrade is nearly ready.
  probed,
}

/// Represents the state of a transport upgrade.
@sealed
class UpgradeState {
  static const _defaultUpgradeState = UpgradeStatus.none;

  /// The current state of the upgrade.
  UpgradeStatus get status => _status;
  UpgradeStatus _status = _defaultUpgradeState;

  /// The current transport.
  Transport<dynamic> get origin => _origin!;
  Transport<dynamic>? _origin;

  /// The potential new transport.
  Transport<dynamic> get destination => _destination!;
  Transport<dynamic>? _destination;

  /// Keeps track of the upgrade timing out.
  late Timer timer;

  late final Timer Function() _getTimer;

  StreamSubscription<TransportException>? _exceptionSubscription;

  /// Creates an instance of `UpgradeState`.
  UpgradeState({required Duration upgradeTimeout}) {
    _getTimer = () => Timer(upgradeTimeout, () async {
          await _destination?.dispose();
          await reset();
        });
  }

  /// Marks the upgrade process as initiated.
  void markInitiated(
    Socket socket, {
    required Transport<dynamic> origin,
    required Transport<dynamic> destination,
  }) {
    _status = UpgradeStatus.initiated;
    _origin = origin;
    _destination = destination;
    _exceptionSubscription = destination.onUpgradeException
        .listen(socket.onUpgradeExceptionController.add);
    timer = _getTimer();
  }

  /// Marks the new transport as probed.
  void markProbed() => _status = UpgradeStatus.probed;

  /// Resets the upgrade state.
  Future<void> reset() async {
    _status = UpgradeStatus.none;
    _origin = null;
    _destination = null;
    timer.cancel();
    _exceptionSubscription = null;
    await _exceptionSubscription?.cancel();
  }

  /// Alias for `reset()`;
  Future<void> markComplete() => reset();

  /// Checks if a given connection type is the connection type of the original
  /// transport.
  bool isOrigin(ConnectionType connectionType) =>
      origin.connectionType == connectionType;
}