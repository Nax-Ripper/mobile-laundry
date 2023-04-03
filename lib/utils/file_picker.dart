import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var pickedFiles = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (pickedFiles != null && pickedFiles.files.isNotEmpty) {
      for (var i = 0; i < pickedFiles.files.length; i++) {
        images.add(File(pickedFiles.files[i].path!));
      }
    }
  } catch (e) {
    log(e.toString());
  }

  return images;
}
