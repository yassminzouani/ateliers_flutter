import 'package:flutter/widgets.dart';
import 'image_helper_io.dart' if (dart.library.html) 'image_helper_web.dart';

/// Returns a widget showing the image at [path]. On web this will use
/// `Image.network`, on IO platforms it will use `Image.file`.
Widget imageFromPath(String path,
    {double? width, double? height, BoxFit? fit}) {
  return imageFromPathImpl(path, width: width, height: height, fit: fit);
}