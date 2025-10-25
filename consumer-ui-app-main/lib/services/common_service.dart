import 'dart:convert';
import 'dart:io';

import 'package:black_locust/services/base_client.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

class CommonService {
  Future getPostalCode(value) async {
    var result = await BaseClient()
        .get('https://api.postalpincode.in/', 'pincode/' + value);
    if (result == null) return;
    return jsonDecode(result);
  }

  Future downloadBase64File(String fileName, String base64Data) async {
    try {
      if (Platform.isAndroid) {
        var status = await Permission.manageExternalStorage.request();
        if (status.isDenied) {
          showMessage("Storage permission denied");
          return;
        } else if (status.isPermanentlyDenied) {
          showMessage(
              "Storage permission denied. Please enable it in settings.");
          openAppSettings();
          return;
        }
      }

      // Decode base64 string
      final bytes = base64Decode(base64Data);

      // Get directory for storage
      Directory directory;
      if (Platform.isAndroid) {
        directory =
            Directory('/storage/emulated/0/Download'); // Download folder
      } else {
        directory = await getApplicationDocumentsDirectory(); // iOS or fallback
      }

      // File path
      final filePath = "${directory.path}/$fileName";

      // Save file
      showMessage("Downloading...");
      final file = File(filePath);
      await file.writeAsBytes(bytes);
      showMessage("Download completed: $filePath");
    } catch (e) {
      print("Error saving base64 file: $e");
      showMessage("Failed to download file");
    }
  }

  Future<void> downloadFile(fileName, fileUrl) async {
    try {
      if (Platform.isAndroid) {
        // For Android 9 and below, permission is required
        var status = await Permission.storage.request();
        if (status.isDenied) {
          showMessage("Storage permission denied");
          return;
        } else if (status.isPermanentlyDenied) {
          showMessage(
              "Storage permission denied. Please enable it in settings.");
          openAppSettings();
          return;
        }
      }

      // Get app-specific downloads directory
      Directory directory;
      if (Platform.isAndroid) {
        directory = await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
      } else {
        directory = await getApplicationDocumentsDirectory();
      }

      // Create "Download" folder inside app directory
      final downloadDir = Directory('/storage/emulated/0/Download');
      if (!(await downloadDir.exists())) {
        await downloadDir.create(recursive: true);
      }

      final filePath = "${downloadDir.path}/$fileName";

      // Start download
      showMessage("Downloading...");
      final response = await http.get(Uri.parse(fileUrl));
      if (response.statusCode == 200) {
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        showMessage("Download completed: $filePath");
      } else {
        showMessage("Failed to download file");
      }
    } catch (e) {
      print("❌ Error downloading file: $e");
      showMessage("Error: $e");
    }
  }

  showMessage(message) {
    ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Future getTemplate() async {
  //   var result =
  //       await BaseClient().get('$graphQlServiceUri', 'template/' + shopId);
  //   if (result == null) return;
  //   return jsonDecode(result);
  // }
}
