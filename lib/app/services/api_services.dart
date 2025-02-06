import 'dart:io';
import 'dart:convert';

import 'package:alveum/app/helpers/helpers.dart';
import 'package:http/http.dart' as http;


import '../helpers/api_constants.dart';

class ApiService {
  ApiService._();

  Future protectedGetRequest({required String endPoint }) async {
    print('PROTECTED-GET-REQUEST');

    Map<String, String>? headers = {
      "Content-Type": "application/json",
      "Accept": "application/json",
      'User-Agent': Platform.isAndroid ? 'Dart/Flutter (Android)' : 'Dart/Flutter (iOS)',
    };

    try {
      var response = await http.get(Uri.parse("$API_BASE_URL$endPoint"), headers: headers);
      if(response.statusCode == 401) return false;
      print(response.body);
      return json.decode(response.body);
    } catch(error, stackTrace) {
      print("API Error: $error - $stackTrace", );
      return false;
    }
  }
}