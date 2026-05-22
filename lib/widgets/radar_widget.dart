import 'package:flutter/material.dart';
import 'dart:math';

class RadarWidget extends StatefulWidget {
  final double size;
  final int ringCount;

  const RadarWidget({
    super.key,
    this.size = 200,
    this.ringCount = 4,
  });

  @override
  State<RadarWidget> createState() => _RadarWidgetState();
}

class _RadarWidgetState extends State<RadarWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).primaryColor;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) => CustomPaint(
        size: Size(widget.size, widget.size),
        painter: _RadarPainter(
          angle: _controller.value * 2 * pi,
          color: color,
          ringCount: widget.ringCount,
        ),
      ),
    );
  }
}

class _RadarPainter extends CustomPainter {
  final double angle;
  final Color color;
  final int ringCount;

  _RadarPainter({
    required this.angle,
    required this.color,
    required this.ringCount,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final gridPaint = Paint()
      ..color = color.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    // Anillos concéntricos
    for (int i = 1; i <= ringCount; i++) {
      canvas.drawCircle(center, radius * i / ringCount, gridPaint);
    }

    // Cruz central
    canvas.drawLine(Offset(center.dx, 0), Offset(center.dx, size.height), gridPaint);
    canvas.drawLine(Offset(0, center.dy), Offset(size.width, center.dy), gridPaint);

    // Barrido con gradiente
    final sweepPaint = Paint()..style = PaintingStyle.fill;
    final sweepGradient = SweepGradient(
      startAngle: angle - 1.2,
      endAngle: angle,
      colors: [
        color.withOpacity(0),
        color.withOpacity(0.4),
      ],
    );
    sweepPaint.shader = sweepGradient.createShader(
      Rect.fromCircle(center: center, radius: radius),
    );
    canvas.drawCircle(center, radius, sweepPaint);

    // Línea del radar
    final linePaint = Paint()
      ..color = color
      ..strokeWidth = 2;
    final lineEnd = Offset(
      center.dx + radius * cos(angle),
      center.dy + radius * sin(angle),
    );
    canvas.drawLine(center, lineEnd, linePaint);

    // Punto central
    canvas.drawCircle(center, 3, Paint()..color = color);
  }

  @override
  bool shouldRepaint(_RadarPainter old) =>
      old.angle != angle || old.color != color;
}