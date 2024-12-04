import 'dart:convert';
import 'package:http/http.dart' as http;

class Util {
  /// 从文本中提取 JSON 对象
  ///
  /// 该方法使用 `dart:convert` 库来解析 JSON 字符串，并返回一个包含解析后的 JSON 对象的列表。
  ///
  ///  参数：
  ///    text: 包含 JSON 字符串的文本。
  ///
  ///  返回值：
  ///    一个包含解析后的 JSON 对象的列表。
  static List<Map<String, dynamic>> extractJsonObjects(String text) {
    List<Map<String, dynamic>> jsonObjects = [];
    int braceCount = 0;
    int bracketCount = 0;
    StringBuffer currentJson = StringBuffer();
    bool inJson = false;
    bool inString = false;

    for (int i = 0; i < text.length; i++) {
      if (text[i] == '"' && (i == 0 || text[i - 1] != '\\')) {
        inString = !inString;
      }

      if (!inString) {
        if (text[i] == '{') {
          if (braceCount == 0 && bracketCount == 0) {
            inJson = true;
          }
          braceCount++;
        } else if (text[i] == '}') {
          braceCount--;
          if (braceCount == 0 && bracketCount == 0) {
            inJson = false;
            currentJson.write(text[i]);
            try {
              Map<String, dynamic> jsonObject =
                  json.decode(currentJson.toString());
              jsonObjects.add(jsonObject);
            } catch (e) {
              // Handle invalid JSON
              print('Invalid JSON: ${currentJson.toString()}');
            }
            currentJson.clear();
            continue;
          }
        } else if (text[i] == '[') {
          bracketCount++;
        } else if (text[i] == ']') {
          bracketCount--;
        }
      }

      if (inJson) {
        currentJson.write(text[i]);
      }
    }

    return jsonObjects;
  }

  /// 检查是否可以连接到 Google
  static Future<bool> canConnectToGoogle() async {
    try {
      // 设置请求 URL 和超时时间
      final url = Uri.parse('https://www.google.com');
      final response = await http.get(url).timeout(Duration(seconds: 5));

      // 如果状态码为 200，表示成功连接
      return response.statusCode == 200;
    } catch (e) {
      // 处理其他异常
      return false;
    }
  }
}
