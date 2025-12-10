import 'package:flutter/widgets.dart';

Widget imageFromPathImpl(String path,
    {double? width, double? height, BoxFit? fit}) {
  return Image.network(
    path,
    width: width,
    height: height,
    fit: fit,
  );
}