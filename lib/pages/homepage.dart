import 'package:carbon_intensity_dashboard/custom/carbon_intensity_card.dart';
import 'package:carbon_intensity_dashboard/custom/carbon_intensity_graph.dart';
import 'package:carbon_intensity_dashboard/data/api_service.dart';
import 'package:carbon_intensity_dashboard/models/carbon_intensity_hourly_model.dart';
import 'package:carbon_intensity_dashboard/models/carbon_intensity_model.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService _apiService = ApiService();
  CarbonIntensity? _carbonIntensity;
  List<IntensityData>? _carbonIntensity24Hrs;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final intensity = await _apiService.getCarbonIntensity();
      final intensity24Hrs = await _apiService.getCarbonIntensityFor24Hours(
          DateTime.now().toUtc().toIso8601String());
      setState(() {
        _carbonIntensity = intensity;
        _carbonIntensity24Hrs = intensity24Hrs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          foregroundColor: Colors.blueAccent,
          title: const Text('Carbon Buddy 👻'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          elevation: 0,
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
                ? Center(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 18),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Reload the data:',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                            IconButton(
                              icon: const Icon(Icons.refresh),
                              color: Colors.blueAccent,
                              onPressed: _fetchData,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        if (_carbonIntensity != null)
                          CarbonIntensityCard(
                            intensityData: _carbonIntensity!.actual,
                            index: _carbonIntensity!.index,
                          ),
                        const SizedBox(height: 24),
                        const Text(
                          'National half-hourly carbon intensity for the current day.',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                        const SizedBox(height: 16),
                        if (_carbonIntensity24Hrs != null)
                          Expanded(
                            child: CarbonIntensityGraph(
                                data: _carbonIntensity24Hrs!),
                          ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
