import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/////////grafico de barras////////////////
class BarChart extends StatelessWidget {
  final List<double> data;
  final List<Color> colors;
  final List<String> labels;

  BarChart({required this.data, required this.colors, required this.labels});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(450, 300),
      painter: BarChartPainter(data: data, colors: colors, labels: labels),
    );
  }
}

class BarChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;
  final List<String> labels;
  final double barSpacing = 4;

  BarChartPainter(
      {required this.data, required this.colors, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final double totalBarWidth = size.width - (barSpacing * (data.length + 2));
    final double barWidth = totalBarWidth / data.length;
    final double maxData =
        data.reduce((value, element) => value > element ? value : element);
    final double unitHeight = size.height / maxData;

    for (int i = 0; i < data.length; i++) {
      final paint = Paint()..color = colors[i % colors.length];
      final double barHeight = data[i] * unitHeight;
      final double x = i * (barWidth + barSpacing);
      final double y = size.height - barHeight;
      final RRect rrect = RRect.fromRectAndRadius(
        Rect.fromLTWH(x, y, barWidth, barHeight),
        Radius.circular(4),
      );
      canvas.drawRRect(rrect, paint);

      final TextPainter textPainter = TextPainter(
        text: TextSpan(
          text: 'R\$${data[i].toStringAsFixed(0)}',
          style: TextStyle(
              color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: barWidth);
      textPainter.paint(
          canvas, Offset(x + (barWidth / 2 - textPainter.width / 2), y - 20));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
///////////fim grafico de barras////////////////

class PieChart extends StatelessWidget {
  final List<double> data;
  final List<Color> colors;

  PieChart({required this.data, required this.colors});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(400, 400), // Tamanho do gráfico de pizza
      painter: PieChartPainter(data: data, colors: colors),
    );
  }
}

class PieChartPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;

  PieChartPainter({required this.data, required this.colors});

  @override
  void paint(Canvas canvas, Size size) {
    double total = data.reduce((acc, value) => acc + value);
    double startAngle = 0;
    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = min(size.width / 2, size.height / 2);

    for (int i = 0; i < data.length; i++) {
      double sweepAngle = 2 * pi * (data[i] / total);
      final paint = Paint()
        ..color = colors[i % colors.length]
        ..style = PaintingStyle.fill;
      canvas.drawArc(
          Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
          startAngle,
          sweepAngle,
          true,
          paint);
      startAngle += sweepAngle;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

void main() {
  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Grafico de barras'),
      ),
      body: Column(
        children: [
          Container(
            height: 300,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color.fromARGB(255, 233, 233, 233),
            ),
            padding: EdgeInsets.only(top: 30, left: 4),
            margin: EdgeInsets.all(10),
            child: BarChart(
              data: [100, 200, 150, 500, 700],
              colors: [
                Color(0xff07c2f3),
                Color(0xffe30224),
                Color.fromARGB(255, 212, 158, 57),
                Color.fromARGB(255, 5, 143, 74)
              ],
              labels: ['A', 'B', 'C', 'D', 'E'],
            ),
          ),
          Container(
            height: 300,
             decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color.fromARGB(255, 233, 233, 233),
            ),
            padding: EdgeInsets.only(top: 30, left: 4),
            margin: EdgeInsets.all(10),
            child: PieChart(
              data: [30, 20, 25, 15, 10],
              colors: [
                 Color(0xff07c2f3),
                Color(0xffe30224),
                Color.fromARGB(255, 212, 158, 57),
                Color.fromARGB(255, 5, 143, 74),
                Colors.orange
              ],
            ),
          ),
        ],
      ),
    ),
  ));
}
