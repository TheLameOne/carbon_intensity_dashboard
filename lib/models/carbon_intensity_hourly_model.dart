import 'dart:convert';

class CarbonIntensityResponse24Hrs {
  List<IntensityData> data;

  CarbonIntensityResponse24Hrs({required this.data});

  factory CarbonIntensityResponse24Hrs.fromJson(Map<String, dynamic> json) {
    return CarbonIntensityResponse24Hrs(
      data: (json['data'] as List)
          .map((item) => IntensityData.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}

class IntensityData {
  final DateTime from;
  final DateTime to;
  final Intensity intensity;

  IntensityData({
    required this.from,
    required this.to,
    required this.intensity,
  });

  factory IntensityData.fromJson(Map<String, dynamic> json) {
    return IntensityData(
      from: DateTime.parse(json['from']),
      to: DateTime.parse(json['to']),
      intensity: Intensity.fromJson(json['intensity']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from.toIso8601String(),
      'to': to.toIso8601String(),
      'intensity': intensity.toJson(),
    };
  }
}

class Intensity {
  final int? forecast;
  final int? actual;
  final String index;

  Intensity({
    required this.forecast,
    required this.actual,
    required this.index,
  });

  factory Intensity.fromJson(Map<String, dynamic> json) {
    return Intensity(
      forecast: json['forecast'],
      actual: json['actual'],
      index: json['index'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'forecast': forecast,
      'actual': actual,
      'index': index,
    };
  }
}

CarbonIntensityResponse24Hrs parseCarbonIntensityResponse(String jsonStr) {
  final Map<String, dynamic> jsonMap = json.decode(jsonStr);
  return CarbonIntensityResponse24Hrs.fromJson(jsonMap);
}
