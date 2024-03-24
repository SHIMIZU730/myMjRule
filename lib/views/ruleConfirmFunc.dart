// Convert the screen shot to image
import 'dart:io' as io;
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// Convert the widget to image
Future<ByteData?> exportWidgetToImage(GlobalKey globalKey) async {
  // Get target widget
  final boundary =
      globalKey.currentContext?.findRenderObject() as RenderRepaintBoundary;
  // Convert to image
  final image = await boundary.toImage(pixelRatio: 3);
  // Convert to bytedata
  final ByteData = await image.toByteData(
    format: ImageByteFormat.png,
  );
  return ByteData;
}

// Save the image to the local path
// args : text -> file name, imagedata : imagedata
Future<io.File> getApplicationDocumentsFile(
  String text,
  List<int> imageData,
) async {
  // Get automatically the current dir
  final directory = await getApplicationDocumentsDirectory();
  // Set the save path
  final exportFile = io.File('${directory.path}/$text.png');
  // If not exists, create. recursive:true(create dirs too)
  if (!await exportFile.exists()) {
    await exportFile.create(recursive: true);
  }
  // Write imagedata to the file
  final file = await exportFile.writeAsBytes(imageData);
  return file;
}

// Share the widget image
// args : globalkey -> Globalkey
void shareWidgetImage(
    {required GlobalKey globalKey, GlobalKey? textFielldKey}) async {
  final List<GlobalKey> gloKeyList = [];
  gloKeyList.add(globalKey);
  if (textFielldKey != null) {
    gloKeyList.add(textFielldKey);
  }

  List<String> imgPathList = [];

  for (var globalKey in gloKeyList) {
// Convert the widget to image
    var byteData = await exportWidgetToImage(globalKey);
    if (byteData == null) {
      return;
    }
    // Convert the image to Uint8List
    var widgetImageBytes = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    // Save the image to local path
    var applicationDocumensFile = await getApplicationDocumentsFile(
      globalKey.toString(),
      widgetImageBytes,
    );
    imgPathList.add(applicationDocumensFile.path);
  }

  // Exec share action
  // await Share.shareXFiles(imgPathList.map((path) => XFile(path)).toList(),
  //     text: "今回の麻雀のルールです", subject: "My麻雀ルール");

  final result = await Share.shareXFiles(
      [XFile(imgPathList[0]), (XFile(imgPathList[1]))],
      text: "今回の麻雀のルールです。", subject: "My麻雀ルール");

  if (result.status == ShareResultStatus.dismissed) {
    print('写真じゃないらしい');
  }
}
