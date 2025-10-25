import 'dart:convert';
// import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import '../config/configConstant.dart';

class VideoUploadService {
  Future createMulitPart(details) async {
    Dio dio = new Dio();
    var path = fileUploadUrl + "createMultipart";
    Response response = await dio.post(path, data: details);
    return jsonDecode(response.toString());
  }

  Future completeMultiPartUpload(details) async {
    Dio dio = new Dio();
    var path = fileUploadUrl + "completeMultipartUpload";
    Response response = await dio.post(path, data: details);
    return jsonDecode(response.toString());
  }

  Future preSignedURLForMulitpart(details) async {
    Dio dio = new Dio();
    var path = fileUploadUrl + "presignedUrlforMulitpart";
    Response response = await dio.post(path, data: details);
    return response.data;
  }

  // Future uploadVideoToAWS(url, path) async {
  //   // try {
  //   var request = http.MultipartRequest('PUT', Uri.parse(url));
  //   request.files.add(await http.MultipartFile.fromPath('file', path));

  //   var streamedResponse = await request.send();

  //   if (streamedResponse.statusCode == 200) {
  //     // Assuming ETag is returned in response headers
  //     return streamedResponse.headers['etag'];
  //   } else {
  //     throw Exception(
  //         'Failed to upload video: ${streamedResponse.reasonPhrase}');
  //   }
  //   // } catch (e) {
  //   //   throw Exception('Failed to upload video: $e');
  //   // }
  // }

  Future<String> uploadVideoToAWS(String url, videoBytes, fileName) async {
    try {
      final uri = Uri.parse(url);
      final streamedResponse = await http.put(uri, body: videoBytes);
      print(streamedResponse.headers);
      if (streamedResponse.statusCode == 200) {
        final etag = streamedResponse.headers['etag'];
        if (etag != null) {
          return etag;
        } else {
          throw Exception('Missing ETag header in response');
        }
      } else {
        throw Exception(
            'Error uploading video: ${streamedResponse.statusCode}');
      }
    } catch (error) {
      rethrow;
    }
  }

  // Future uploadVideoToAWS(path, details) async {
  //   Dio dio = new Dio();
  //   FormData formData = new FormData.fromMap({"file": details});
  //   var response = await dio.post(path, data: formData);
  //   return response;
  // }
}
