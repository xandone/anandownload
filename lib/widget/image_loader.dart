import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';

/// @author: xiao
/// created on: 2024/12/19 10:08
/// description:

class ImageLoader {
  static Widget display(String file, double w, double h) {
    return CachedNetworkImage(
      fit: BoxFit.cover,
      imageUrl: file,
      placeholder: (context, url) => SvgPicture.asset('assets/pic_loading.svg'),
      errorWidget: (context, url, error) => SvgPicture.asset('assets/pic_error.svg'),
      width: w,
      height: h,
    );
  }
}
