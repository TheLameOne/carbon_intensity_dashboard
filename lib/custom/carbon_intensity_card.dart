import 'package:carbon_intensity_dashboard/constants.dart';
import 'package:flutter/material.dart';

class CarbonIntensityCard extends StatefulWidget {
  final int intensityData;
  final String index;
  const CarbonIntensityCard(
      {super.key, required this.intensityData, required this.index});
  @override
  State<CarbonIntensityCard> createState() => _CarbonIntensityCardState();
}

class _CarbonIntensityCardState extends State<CarbonIntensityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blueAccent.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: Colors.blueAccent, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'National Carbon Intensity',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              '${widget.intensityData} gCO₂/kWh',
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),
            const Divider(
              color: Colors.white,
              thickness: 2,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Carbon intensity is ${widget.index}! ${contantCarbonText[widget.index]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                const SizedBox(width: 16),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                    // borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.blueAccent, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      widget.index.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
