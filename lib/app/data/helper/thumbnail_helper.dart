import 'dart:developer';
import 'dart:typed_data';

import 'package:windows_storage/windows_storage.dart';

class ThumbnailHelper {
  ThumbnailHelper._();

  static Future<Uint8List?> generate(String path) async {
    try {
      StorageFile? file = await StorageFile.getFileFromPathAsync(path);
      if (file == null) return null;
      final thumbnail = await file.getThumbnailAsync(ThumbnailMode.singleItem, 128, ThumbnailOptions.resizeThumbnail);
      if (thumbnail != null) {
        DataReader reader = DataReader.createDataReader(thumbnail.getInputStreamAt(0));
        await reader.loadAsync(thumbnail.size);
        return Uint8List.fromList(reader.readBytes(thumbnail.size));
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
