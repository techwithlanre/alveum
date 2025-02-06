import 'package:flutter_dotenv/flutter_dotenv.dart';

String? getEnv({required String key}) {
  return dotenv.env[key];
}