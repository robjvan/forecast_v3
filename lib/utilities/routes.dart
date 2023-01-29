import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/pages/pages.dart';
import 'package:forecast_v3/redux/actions.dart';

class AppRoutes {
  static const String initialRoute = DashboardPage.routeName;

  static final Map<String, Widget Function(BuildContext)> routes = {
    '/': (final BuildContext ctx) => DashboardPage(
          onInit: () {
            StoreProvider.of<AppState>(ctx).dispatch(grabUserLocationAction);
          },
        ),
    SettingsPage.routeName: (final BuildContext ctx) => const SettingsPage(),
  };
}
