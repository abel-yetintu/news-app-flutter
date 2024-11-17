import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String get apiKey {
    return dotenv.get('API_KEY');
  }
}
