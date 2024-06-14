import 'package:flutter/material.dart';

class GraficoBarrasPainter extends CustomPainter {
  final List<double> data;
  final List<Color> colors;
  final List<String> labels;
  final double barSpacing = 4; 

  GraficoBarrasPainter({required this.data, required this.colors, required this.labels});

  @override
  void paint(Canvas canvas, Size size) {
    final double totalBarWidth = size.width - (barSpacing * (data.length + 2));
    final double barWidth = totalBarWidth / data.length;
    final double maxData = data.reduce((value, element) => value > element ? value : element);
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
          style: TextStyle(color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout(minWidth: 0, maxWidth: barWidth);
      textPainter.paint(canvas, Offset(x + (barWidth / 2 - textPainter.width / 2), y - 20)); 
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}