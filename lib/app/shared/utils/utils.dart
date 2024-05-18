import 'package:win_dock/app/data/model/settings_model.dart';
import 'package:win_dock/app/shared/utils/enums.dart';

class Utils {
  Utils._();

  static SettingsModel kDefaultSettings = SettingsModel(
    position: ScreenPosition.right.index,
    runAtStartUp: true,
  );
}
