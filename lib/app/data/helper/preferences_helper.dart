import 'package:hive_flutter/adapters.dart';
import 'package:win_dock/app/data/model/app_model.dart';
import 'package:win_dock/app/data/model/settings_model.dart';
import 'package:win_dock/app/shared/utils/utils.dart';

class PreferencesHelper {
  PreferencesHelper._();

  static final PreferencesHelper _helper = PreferencesHelper._();
  factory PreferencesHelper() => _helper;

  late Box<AppModel> appsBox;
  late Box<SettingsModel> settingsBox;

  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(SettingsModelAdapter());
    Hive.registerAdapter(AppModelAdapter());
    settingsBox = await Hive.openBox<SettingsModel>('settings');
    appsBox = await Hive.openBox<AppModel>('apps');
  }

  Future updateSettings(SettingsModel settings) async => settingsBox.put('settingsKey', settings);

  SettingsModel settings() => settingsBox.get('settingsKey') ?? Utils.kDefaultSettings;

  //
  Future addApp(AppModel app) async {
    if (!appsBox.containsKey(app.path)) {
      appsBox.put(app.path, app);
    }
  }

  Future removeApp(AppModel app) async => appsBox.delete(app.path);
}
