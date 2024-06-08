import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:sixam_mart/controller/splash_controller.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkInfo {
  final Connectivity connectivity;
  NetworkInfo(this.connectivity);

  Future<bool> get isConnected async {
    final List<ConnectivityResult> result =
        await (Connectivity().checkConnectivity());
    return !result.contains(ConnectivityResult.none);
  }

  static void checkConnectivity(BuildContext context) {
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      if (Get.find<SplashController>().firstTimeConnectionCheck) {
        Get.find<SplashController>().setFirstTimeConnectionCheck(false);
      } else {
        bool isNotConnected = result.contains(ConnectivityResult.none);
        isNotConnected
            ? const SizedBox()
            : ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: isNotConnected ? Colors.red : Colors.green,
          duration: Duration(seconds: isNotConnected ? 6000 : 3),
          content: Text(
            isNotConnected ? 'no_connection' : 'connected',
            textAlign: TextAlign.center,
          ),
        ));
      }
      // Received changes in available connectivity types!
    });
  }

  static Future<XFile?> compressImage(File file,targetPath) async {
   var result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path, targetPath,
        quality:  88,
        rotate: 180,
      );

  

    return result;
  }
}

 