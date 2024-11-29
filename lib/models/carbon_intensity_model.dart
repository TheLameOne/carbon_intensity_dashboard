class CarbonIntensity {
  final String from;
  final String to;
  final int forecast;
  final int actual;
  final String index;

  CarbonIntensity({
    required this.from,
    required this.to,
    required this.forecast,
    required this.actual,
    required this.index,
  });

  factory CarbonIntensity.fromJson(Map<String, dynamic> json) {
    return CarbonIntensity(
      from: json['from'] as String,
      to: json['to'] as String,
      forecast: json['intensity']['forecast'] as int,
      actual: json['intensity']['actual'] as int,
      index: json['intensity']['index'] as String,
    );
  }
}
