import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class NavigatorKeyProvider {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey(debugLabel: 'root');
  final GlobalKey<NavigatorState> _shellNavigatorKey =
      GlobalKey(debugLabel: 'shell');

  GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;

  GlobalKey<NavigatorState> get shellNavigatorKey => _shellNavigatorKey;
}
