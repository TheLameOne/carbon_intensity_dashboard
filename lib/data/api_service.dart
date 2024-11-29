import 'dart:convert';
import 'dart:io';
import 'package:carbon_intensity_dashboard/models/carbon_intensity_hourly_model.dart';
import 'package:carbon_intensity_dashboard/models/carbon_intensity_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<CarbonIntensity> getCarbonIntensity() async {
    const url = "https://api.carbonintensity.org.uk/intensity";
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body)['data'][0];
        return CarbonIntensity.fromJson(data);
      } else {
        throw ApiException(
          message: 'Failed to fetch data',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException(message: 'No Internet connection');
    } on HttpException {
      throw ApiException(message: 'Invalid HTTP response');
    } on FormatException {
      throw ApiException(message: 'Bad response format');
    } catch (e) {
      throw ApiException(message: 'Unexpected error occurred: $e');
    }
  }

  Future<List<IntensityData>> getCarbonIntensityFor24Hours(String from) async {
    final url = 'https://api.carbonintensity.org.uk/intensity/$from/pt24h';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final parsedResponse =
            CarbonIntensityResponse24Hrs.fromJson(json.decode(response.body));
        return parsedResponse.data;
      } else {
        throw ApiException(
          message: 'Failed to fetch data',
          statusCode: response.statusCode,
        );
      }
    } on SocketException {
      throw ApiException(message: 'No Internet connection');
    } on HttpException {
      throw ApiException(message: 'Invalid HTTP response');
    } on FormatException {
      throw ApiException(message: 'Bad response format');
    } catch (e) {
      throw ApiException(message: 'Unexpected error occurred: $e');
    }
  }
}

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() {
    if (statusCode != null) {
      return 'Error $statusCode: $message';
    }
    return 'Error: $message';
  }
}
