import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/neo_feed_model.dart';

/// Remote data source for NASA NEO API
class NeoRemoteDataSource {
  final http.Client client;
  static const String baseUrl = 'https://api.nasa.gov/neo/rest/v1';
  static const String apiKey = '77TeBtWgzeBQrxI6tPHUmdbfn5d70969D97mKKGc';

  NeoRemoteDataSource({http.Client? client}) : client = client ?? http.Client();

  /// Fetch NEO feed from NASA API
  ///
  /// Throws [Exception] if the API call fails
  Future<NeoFeedModel> getNeoFeed({
    required String startDate,
    required String endDate,
  }) async {
    final url = Uri.parse(
      '$baseUrl/feed?start_date=$startDate&end_date=$endDate&api_key=$apiKey',
    );

    try {
      final response = await client.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;
        return NeoFeedModel.fromJson(jsonData);
      } else if (response.statusCode == 429) {
        throw Exception('API rate limit exceeded. Please try again later.');
      } else if (response.statusCode == 400) {
        throw Exception('Invalid date range. Maximum 7 days allowed.');
      } else {
        throw Exception(
          'Failed to fetch NEO data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Network error: $e');
    }
  }
}
