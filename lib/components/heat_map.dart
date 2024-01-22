import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class HeatMapOrigin extends StatelessWidget {
  final DateTime? startDate;
  final Map<DateTime, int>? datasets;
  const HeatMapOrigin({super.key, required this.startDate,required this.datasets});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
      endDate: DateTime.now(),
      datasets: datasets,
      colorMode: ColorMode.color,
      defaultColor: Theme.of(context).colorScheme.secondary,
      textColor: Colors.black,
      showColorTip: false,
      showText: true,
      scrollable: true,
      size: 30,
      colorsets: {
        1: Colors.orange.shade100,
        2:Colors.orange.shade300,
        3:Colors.orange.shade400,
        4:Colors.orange.shade500,
        5:Colors.orange.shade700,

      });
  }
}