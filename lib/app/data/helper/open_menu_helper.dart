import 'package:flutter/material.dart';
import 'package:flutter_desktop_context_menu/flutter_desktop_context_menu.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:win_dock/app/data/model/app_model.dart';
import 'package:win_dock/app/data/model/settings_model.dart';
import 'package:win_dock/app/shared/utils/enums.dart';
import 'package:window_manager/window_manager.dart';

import 'launch_helper.dart';
import 'preferences_helper.dart';

class OpenMenuHelper {
  OpenMenuHelper._();
  static Future<void> openRightClickMenu(AppModel app) {
    Menu menu = Menu(
      items: [
        MenuItem(
          label: RightClickMenuItems.open.label,
          onClick: (m) {
            launchPath(app.path);
          },
        ),
        MenuItem(
          label: RightClickMenuItems.delete.label,
          onClick: (m) {
            PreferencesHelper().removeApp(app);
          },
        ),
        MenuItem.separator(),
        MenuItem(
          label: RightClickMenuItems.exit.label,
          onClick: (m) {
            windowManager.close();
          },
        ),
      ],
    );
    return popUpContextMenu(menu);
  }

  static Future<void> openSettingsMenu() async {
    SettingsModel settings = PreferencesHelper().settings();
    Menu menu = Menu(
      items: [
        MenuItem.checkbox(
          checked: settings.runAtStartUp,
          label: SettingsMenuItems.runAtStartUp.label,
          onClick: (m) async {
            PreferencesHelper().updateSettings(
              settings.copyWith(
                runAtStartUp: !settings.runAtStartUp,
              ),
            );
            if (!settings.runAtStartUp == true) {
              await launchAtStartup.enable();
            } else {
              await launchAtStartup.disable();
            }
          },
        ),
        MenuItem.submenu(
          label: SettingsMenuItems.screenPosition.label,
          onClick: (m) {},
          submenu: Menu(
            items: ScreenPosition.values
                .map(
                  (position) => MenuItem.checkbox(
                    label: position.name,
                    checked: settings.position == position.index,
                    onClick: (menuItem) async {
                      await PreferencesHelper().updateSettings(
                        settings.copyWith(position: position.index),
                      );

                      if (position == ScreenPosition.right) {
                        await windowManager.setAlignment(Alignment.centerRight);
                      } else {
                        await windowManager.setAlignment(Alignment.centerLeft);
                      }
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
    return popUpContextMenu(menu);
  }
}
