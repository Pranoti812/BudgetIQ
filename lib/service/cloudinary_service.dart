import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer';

class CloudinaryService {
  // Tuzya Cloudinary account madhle values
  static const String cloudName = 'dwnwxk9ks';
  static const String uploadPreset = 'budgetiq_preset';

  // Image upload karto, Cloudinary chi secure URL return karto
  static Future<Map<String, String>?> uploadImage(File imageFile) async {
    try {
      final uri = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
      );

      final request = http.MultipartRequest('POST', uri);
      request.fields['upload_preset'] = uploadPreset;
      request.files.add(
        await http.MultipartFile.fromPath('file', imageFile.path),
      );

      final response = await request.send();
      final responseData = await response.stream.bytesToString();
      final jsonData = json.decode(responseData);

      if (response.statusCode == 200) {
        return {
          'url': jsonData['secure_url'],
          'public_id': jsonData['public_id'],
        };
      }
      return null;
    } catch (e) {
      log('Cloudinary upload error: $e');
      return null;
    }
  }

  static Future<bool> deleteImage(String publicId) async {
    try {
      final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/$cloudName/image/destroy',
      );

      final response = await http.post(
        url,
        body: {'public_id': publicId, 'upload_preset': uploadPreset},
      );

      return response.statusCode == 200;
    } catch (e) {
      log('Delete error: $e');
      return false;
    }
  }
}