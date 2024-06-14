import 'package:flutter/material.dart';

class GraficoBarras extends StatelessWidget {
  final List<double> data;
  final List<Color> colors;
  final List<String> labels;

  GraficoBarras({required this.data, required this.colors, required this.labels});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(450, 300), 
      painter: BarChartPainter(data: data, colors: colors, labels: labels),
    );
  }
}