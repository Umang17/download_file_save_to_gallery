import 'dart:io';
import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class GalleryDownloader {
  static final Dio _dio = Dio();

  static Future<Map<String, dynamic>> downloadAndSaveToGallery({
    required String fileUrl,
    required Function(int received, int total) onReceiveProgress,
  }) async {
    if (!(await _requestPermission())) {
      return {
        'success': false,
        'filePath': null,
        'message': 'Permission denied',
      };
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = fileUrl.split('/').last;
      final savePath = '${tempDir.path}/$fileName';

      final response = await _dio.download(
        fileUrl,
        savePath,
        onReceiveProgress: onReceiveProgress,
      );

      if (response.statusCode == 200) {
        final result = await ImageGallerySaver.saveFile(savePath);
        final isSuccess = (result['isSuccess'] ?? false) == true;
        return {
          'success': isSuccess,
          'filePath': result['filePath'],
          'message': isSuccess ? 'Saved successfully' : 'Save failed',
        };
      } else {
        return {
          'success': false,
          'filePath': null,
          'message': 'Download failed: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'filePath': null,
        'message': 'Download error: $e',
      };
    }
  }

  static Future<bool> _requestPermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;
      if (androidInfo.version.sdkInt >= 33) {
        return true;
      }
      return await Permission.storage.request().isGranted;
    } else {
      return await Permission.photos.request().isGranted;
    }
  }
}