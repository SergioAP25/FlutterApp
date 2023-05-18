import 'dart:convert';
import 'package:http/http.dart' as http;
import 'constants/api_constants.dart';

class ApiService {
  static final ApiService _apiService = ApiService._sharedInstance();

  factory ApiService() {
    return _apiService;
  }

  ApiService._sharedInstance();

  Future<dynamic> getAllPokemons() async {
    const endpoint = base_url + allPokemons;
    final uri = Uri.parse(endpoint);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return json;
  }

  Future<dynamic> getPokemonByUrl(String endpoint) async {
    final uri = Uri.parse(endpoint);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return json;
  }

  Future<dynamic> getPokemonDescriptionByUrl(String endpoint) async {
    final uri = Uri.parse(endpoint);
    final response = await http.get(uri);
    final json = jsonDecode(response.body);
    return json;
  }
}
