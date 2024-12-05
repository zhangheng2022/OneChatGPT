import 'package:http/http.dart' as http;

class ConnectivityChecker {
  /// 检查是否可以连接到 Google
  static Future<bool> canConnectToGoogle() async {
    try {
      // 设置请求 URL 和超时时间
      final url = Uri.parse('https://www.google.com');
      final response = await http.get(url).timeout(Duration(seconds: 3));
      // 如果状态码为 200，表示成功连接
      return response.statusCode == 200;
    } catch (e) {
      // 处理其他异常
      return false;
    }
  }
}
