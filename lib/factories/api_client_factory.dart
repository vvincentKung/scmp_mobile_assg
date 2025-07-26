import 'package:http/http.dart' as http;

class ApiClientFactory {
  static final ApiClientFactory _instance = ApiClientFactory._internal();
  factory ApiClientFactory() {
    return _instance;
  }
  ApiClientFactory._internal();
  
  http.Client create() {
    // You can add any custom headers or configurations here if needed
    return http.Client();
  }
}
