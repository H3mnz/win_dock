enum RightClickMenuItems {
  open('Open'),
  delete('Delete'),
  exit('Exit');

  final String label;
  const RightClickMenuItems(this.label);
}

enum SettingsMenuItems {
  screenPosition('Screen Position'),
  runAtStartUp('Run at Startup');

  final String label;

  const SettingsMenuItems(this.label);
}

enum ScreenPosition {
  left('Left'),
  right('Right');

  final String label;

  const ScreenPosition(this.label);
}
