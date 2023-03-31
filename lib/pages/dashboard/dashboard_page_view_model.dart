import 'package:flutter/material.dart';
import 'package:flutter_weather_bg_null_safety/flutter_weather_bg.dart';
import 'package:forecast_v3/models/models.dart';
import 'package:forecast_v3/utilities/utilities.dart';
import 'package:redux/redux.dart';

@immutable
class DashboardPageViewModel {
  final LoadingState loadingState;
  final String name;
  final List<WeatherData> weatherDataList;
  final List<Location> locationList;
  final int activeLocationIndex;
  final Function(dynamic) dispatch;
  final Function(int) weatherType;
  final List<APIAlert> activeAlerts;
  final bool useDynamicBackgrounds;
  final Color cardColor;
  final Color textColor;

  const DashboardPageViewModel({
    required this.name,
    required this.loadingState,
    required this.weatherDataList,
    required this.locationList,
    required this.activeLocationIndex,
    required this.dispatch,
    required this.weatherType,
    required this.activeAlerts,
    required this.useDynamicBackgrounds,
    required this.cardColor,
    required this.textColor,
  });

  factory DashboardPageViewModel.create(final Store<AppState> store) {
    int getCurrentLocationIndex() {
      return store.state.currentLocationIndex;
    }

    WeatherType? getWeatherType(final int code) {
      bool isDay = false;
      if (store.state.weatherData.isNotEmpty) {
        isDay = store.state.weatherData[getCurrentLocationIndex()]
                .currentConditions.is_day ??
            false;
      }
      return WeatherIconParser.weatherType(code, isDay);
    }

    List<APIAlert> getActiveAlerts() {
      return store.state.weatherData.isNotEmpty
          ? store.state.weatherData[getCurrentLocationIndex()].weatherAlerts
          : <APIAlert>[];
    }

    return DashboardPageViewModel(
      name: store.state.locations.isNotEmpty
          ? store.state.locations[getCurrentLocationIndex()].name != null
              ? store.state.locations[getCurrentLocationIndex()].name!
              : ''
          : '',
      loadingState: store.state.loadingState,
      // weatherDataList: populateWeatherData(),
      weatherDataList: store.state.weatherData,
      // locationList: populateLocationsList(),
      locationList: store.state.locations,
      activeLocationIndex: store.state.currentLocationIndex,
      dispatch: store.dispatch,
      weatherType: getWeatherType,
      activeAlerts: getActiveAlerts(),
      useDynamicBackgrounds: store.state.userSettings.useDynamicBackgrounds,
      cardColor: store.state.userSettings.useDarkMode
          ? AppColors.bgColorDarkMode
          : AppColors.bgColorLightMode,
      textColor: store.state.userSettings.useDarkMode
          ? AppColors.textColorDarkMode
          : AppColors.textColorLightMode,
    );
  }
}