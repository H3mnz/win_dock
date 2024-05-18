import 'dart:developer';
import 'dart:io';

Future<String?> getShortcutTarget(String path) async {
  try {
    const executable = 'Powershell.exe .\\script.ps1"';
    final p = await Process.run(
      executable,
      [
        '-lnk',
        '"$path"',
      ],
      workingDirectory: '${Directory.current.path}\\script',
    );

    if (p.exitCode == 0) {
      return (p.stdout as String).trim();
    }
  } catch (e) {
    log(e.toString());
  }
  return null;
}
