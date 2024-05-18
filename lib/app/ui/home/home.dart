import 'dart:async';
import 'dart:isolate';

import 'package:drag_and_drop_windows/drag_and_drop_windows.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:path/path.dart';
import 'package:win_dock/app/data/helper/open_menu_helper.dart';
import 'package:win_dock/app/data/helper/preferences_helper.dart';

import '../../data/helper/shortcut_helper.dart';
import '../../data/helper/thumbnail_helper.dart';
import '../../data/model/app_model.dart';
import 'widgets/app_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamSubscription? subscription;

  @override
  void initState() {
    super.initState();
    subscription = dropEventStream.listen(onData);
  }

  void onData(paths) async {
    for (var p in paths) {
      String path = p;
      if (extension(path) == '.lnk') {
        final target = await getShortcutTarget(path);
        if (target != null) {
          path = target;
        }
      }

      if (path.isNotEmpty) {
        PreferencesHelper().addApp(
          AppModel(
            name: basenameWithoutExtension(path),
            path: path,
            icon: await Isolate.run(
              () => ThumbnailHelper.generate(path),
              debugName: 'ThumbnailHelper Isolate :: ${basenameWithoutExtension(path)}',
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black54,
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: PreferencesHelper().appsBox.listenable(),
              builder: (context, box, child) {
                final apps = box.values.toList();
                return ListView.separated(
                  itemCount: apps.length,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final app = apps[index];
                    return AppWidget(app: app);
                  },
                );
              },
            ),
          ),
          const Divider(),
          SizedBox(
            width: 56,
            height: 56,
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => OpenMenuHelper.openSettingsMenu(),
              child: const Tooltip(
                message: 'Dock Settings',
                child: Icon(Icons.settings),
              ),
            ),
          )
        ],
      ),
    );
  }
}
