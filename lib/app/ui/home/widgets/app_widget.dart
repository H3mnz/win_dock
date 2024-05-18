import 'package:animate_do/animate_do.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:win_dock/app/data/helper/launch_helper.dart';
import 'package:win_dock/app/data/helper/open_menu_helper.dart';
import 'package:win_dock/app/data/model/app_model.dart';

class AppWidget extends StatefulWidget {
  final AppModel app;

  const AppWidget({super.key, required this.app});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  bool hover = false;

  late AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (event) {
        hover = true;
        setState(() {});
      },
      onExit: (event) {
        hover = false;
        setState(() {});
      },
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1, end: hover ? 1.25 : 1),
        duration: const Duration(milliseconds: 100),
        builder: (context, value, child) {
          return FadeIn(
            duration: const Duration(milliseconds: 200),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Listener(
                behavior: HitTestBehavior.translucent,
                onPointerDown: (event) async {
                  if (event.kind == PointerDeviceKind.mouse && event.buttons == kSecondaryMouseButton) {
                    OpenMenuHelper.openRightClickMenu(widget.app);
                  } else {
                    animationController.reset();
                    await animationController.forward();
                    launchPath(widget.app.path);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: Dance(
                    duration: const Duration(milliseconds: 200),
                    manualTrigger: true,
                    controller: (p0) => animationController = p0,
                    child: Column(
                      children: [
                        if (widget.app.icon != null)
                          SizedBox(
                            width: 40 * value,
                            height: 40 * value,
                            child: Image.memory(widget.app.icon!),
                          ),
                        if (widget.app.icon == null)
                          Icon(
                            Icons.desktop_windows_rounded,
                            size: 40 * value,
                          ),
                        const SizedBox(height: 4),
                        Text(
                          widget.app.name,
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
