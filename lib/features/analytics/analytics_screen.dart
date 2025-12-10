import 'package:flutter/material.dart';

import '../../core/theme/app_theme.dart';
import '../../core/widgets/responsive_wrapper.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  // Mock data for 7 days (Mon..Sun)
  List<double> get _weeklyData => [3, 5, 4, 6, 7, 8, 6];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ResponsiveWrapper(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Analytics'),
          leading: BackButton(onPressed: () => Navigator.of(context).pop()),
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Chart Card
              Container(
                height: 360,
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x14000000),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Weekly Activity',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 12),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 12.0, left: 4.0),
                        child: Column(
                          children: [
                            Expanded(
                              child: CustomPaint(
                                size: Size.infinite,
                                painter: _LineChartPainter(
                                  data: _weeklyData,
                                  lineColor: AppColors.primary,
                                  maxY: 10,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            // Bottom labels
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(child: Center(child: Text('Mon'))),
                                Expanded(child: Center(child: Text('Tue'))),
                                Expanded(child: Center(child: Text('Wed'))),
                                Expanded(child: Center(child: Text('Thu'))),
                                Expanded(child: Center(child: Text('Fri'))),
                                Expanded(child: Center(child: Text('Sat'))),
                                Expanded(child: Center(child: Text('Sun'))),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Stats grid
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: const [
                  _StatCard(
                    icon: Icons.check_circle_outline,
                    title: 'Total Sober Days',
                    value: '12 Days',
                  ),
                  _StatCard(
                    icon: Icons.savings_outlined,
                    title: 'Money Saved',
                    value: '\$150',
                  ),
                  _StatCard(
                    icon: Icons.sentiment_satisfied_outlined,
                    title: 'Mood Score',
                    value: 'Happy',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  final Color lineColor;
  final double maxY;

  _LineChartPainter(
      {required this.data, required this.lineColor, this.maxY = 10});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final dotPaint = Paint()..color = lineColor;
    final strokePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final leftPadding = 0.0;
    final rightPadding = 0.0;
    final topPadding = 8.0;
    final bottomPadding = 8.0;

    final usableWidth = size.width - leftPadding - rightPadding;
    final usableHeight = size.height - topPadding - bottomPadding;
    final stepX = usableWidth / (data.length - 1);

    // convert data to points
    List<Offset> points = [];
    for (int i = 0; i < data.length; i++) {
      final x = leftPadding + i * stepX;
      final y = topPadding + (1 - (data[i] / maxY)) * usableHeight;
      points.add(Offset(x, y));
    }

    if (points.isEmpty) return;

    // create smooth path using quadratic beziers
    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      final prev = points[i - 1];
      final curr = points[i];
      final mid = Offset((prev.dx + curr.dx) / 2, (prev.dy + curr.dy) / 2);
      path.quadraticBezierTo(prev.dx, prev.dy, mid.dx, mid.dy);
    }
    // connect last mid to last point
    if (points.length >= 2) {
      final secondLast = points[points.length - 2];
      final last = points.last;
      path.quadraticBezierTo(secondLast.dx, secondLast.dy, last.dx, last.dy);
    }

    // draw area under curve
    final areaPath = Path.from(path)
      ..lineTo(points.last.dx, size.height)
      ..lineTo(points.first.dx, size.height)
      ..close();

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final gradient = LinearGradient(
      colors: [lineColor.withAlpha(77), Colors.transparent],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
    final areaPaint = Paint()..shader = gradient.createShader(rect);
    canvas.drawPath(areaPath, areaPaint);

    // draw line
    canvas.drawPath(path, paint);

    // draw dots with white stroke
    for (final p in points) {
      canvas.drawCircle(p, 6, dotPaint);
      canvas.drawCircle(p, 6, strokePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _StatCard(
      {required this.icon, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      width: 160,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: const Color(0x14000000),
                blurRadius: 8,
                offset: const Offset(0, 6)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.primary.withAlpha(25),
              child: Icon(icon, color: AppColors.primary),
            ),
            const SizedBox(height: 12),
            Text(title,
                style: theme.textTheme.bodySmall
                    ?.copyWith(color: Colors.grey.shade600)),
            const SizedBox(height: 8),
            Text(value,
                style: theme.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}
