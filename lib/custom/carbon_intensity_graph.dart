import 'package:carbon_intensity_dashboard/models/carbon_intensity_hourly_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CarbonIntensityGraph extends StatefulWidget {
  final List<IntensityData> data;

  CarbonIntensityGraph({super.key, required this.data});
  @override
  State<CarbonIntensityGraph> createState() => _CarbonIntensityGraphState();
}

class _CarbonIntensityGraphState extends State<CarbonIntensityGraph> {
  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        lineBarsData: [
          LineChartBarData(
              spots: [
                for (int i = 0; i < widget.data.length; i++)
                  FlSpot(
                      i.toDouble(),
                      (widget.data[i].intensity.actual != null)
                          ? (widget.data[i].intensity.actual!.toDouble())
                          : (widget.data[i].intensity.forecast!.toDouble()))
              ],
              isCurved: false,
              barWidth: 2,
              color: Colors.blueAccent,
              curveSmoothness: 2),
        ],
        backgroundColor: Colors.blueAccent.withOpacity(0.1),
        maxX: 48,
        minY: 0,
        maxY: findMaxIntensity(widget.data) + 50,
        titlesData: const FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
                showTitles: true, reservedSize: 36), // Keep left titles
          ),
          rightTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide right titles
          ),
          topTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide top titles
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(showTitles: false), // Hide x-axis titles
          ),
        ),
      ),
    );
  }
}

double findMaxIntensity(List<IntensityData> data) {
  IntensityData maxIntensityData = data.reduce((current, next) {
    return current.intensity.forecast! > next.intensity.forecast!
        ? current
        : next;
  });
  return maxIntensityData.intensity.forecast!.toDouble();
}
