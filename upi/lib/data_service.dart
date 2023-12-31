import 'dart:convert';
import 'package:http/http.dart' as http;

class DataService {
  Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('http://localhost:3000/data'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
