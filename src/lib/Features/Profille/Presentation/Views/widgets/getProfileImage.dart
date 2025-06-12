import 'dart:typed_data';

import 'package:flutter/material.dart';

/*Yara Adel Mohamed*/
class Getprofileimage {
  static ImageProvider getProfileImage({
    Uint8List? localImage,
    String? profilePictureUrl,
    required String defaultAssetImage,
  }) {
    if (localImage != null) {
      return MemoryImage(localImage);
    }
    if (profilePictureUrl != null && profilePictureUrl.trim().isNotEmpty) {
      return NetworkImage(profilePictureUrl);
    }
    return AssetImage(defaultAssetImage);
  }
}
