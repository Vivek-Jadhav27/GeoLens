import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://192.168.229.69:8000/api";

  Future<Map<String, dynamic>> uploadImage(String filePath) async {
    final uri = Uri.parse('$baseUrl/');
    final request = http.MultipartRequest('POST', uri);

    try {
      // Add the image file
      request.files.add(await http.MultipartFile.fromPath('image', filePath));

      // Send the request
      final response = await request.send();

      // Process the response
      if (response.statusCode == 200) {
        final responseBody = await http.Response.fromStream(response);
        return json.decode(responseBody.body) as Map<String, dynamic>;
      } else {
        return {
          'status': 'error',
          'message': 'Failed to upload image. Status code: ${response.statusCode}'
        };
      }
    } catch (e) {
      return {'status': 'error', 'message': 'Exception occurred: $e'};
    }
  }
}
