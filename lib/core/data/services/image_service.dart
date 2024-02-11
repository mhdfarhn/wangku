import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageService {
  Future<String> storeImageToInternalStorage(String path) async {
    try {
      final image = XFile(path);
      final directory = await getExternalStorageDirectory();
      final fileName = basename(image.path);
      final imagePath = '${directory?.path}/$fileName';

      await image.saveTo(imagePath);

      return imagePath;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> removeImageFromInternalStorage(String path) async {
    final image = File(path);
    try {
      if (await image.exists()) {
        await image.delete();
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
