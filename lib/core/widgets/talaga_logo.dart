import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';
import '../../app/theme/app_text_styles.dart';

class TalagaLogo extends StatelessWidget {
  final double iconSize;
  final double fontSize;
  final bool showText;

  const TalagaLogo({
    super.key,
    this.iconSize = 58,
    this.fontSize = 26,
    this.showText = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: iconSize,
          height: iconSize,
          child: CustomPaint(
            painter: _HouseLeafPainter(),
          ),
        ),
        if (showText) ...[
          const SizedBox(height: 6),
          Text(
            'Talaga',
            style: AppTextStyles.logoTitle.copyWith(fontSize: fontSize),
          ),
        ],
      ],
    );
  }
}

class _HouseLeafPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint housePaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.085
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Draw Roof
    final Path roofPath = Path()
      ..moveTo(w * 0.10, h * 0.48)
      ..lineTo(w * 0.50, h * 0.12)
      ..lineTo(w * 0.90, h * 0.48);
    canvas.drawPath(roofPath, housePaint);

    // Draw House Walls
    final Path wallsPath = Path()
      ..moveTo(w * 0.22, h * 0.42)
      ..lineTo(w * 0.22, h * 0.88)
      ..lineTo(w * 0.78, h * 0.88)
      ..lineTo(w * 0.78, h * 0.42);
    canvas.drawPath(wallsPath, housePaint);

    // Draw Left Leaf inside house
    final Paint leftLeafPaint = Paint()
      ..color = AppColors.accentGreen
      ..style = PaintingStyle.fill;

    final Path leftLeaf = Path()
      ..moveTo(w * 0.50, h * 0.80)
      ..quadraticBezierTo(w * 0.28, h * 0.72, w * 0.34, h * 0.50)
      ..quadraticBezierTo(w * 0.50, h * 0.56, w * 0.50, h * 0.80);
    canvas.drawPath(leftLeaf, leftLeafPaint);

    // Draw Right Leaf inside house
    final Paint rightLeafPaint = Paint()
      ..color = AppColors.primaryLight
      ..style = PaintingStyle.fill;

    final Path rightLeaf = Path()
      ..moveTo(w * 0.50, h * 0.80)
      ..quadraticBezierTo(w * 0.72, h * 0.68, w * 0.66, h * 0.42)
      ..quadraticBezierTo(w * 0.46, h * 0.52, w * 0.50, h * 0.80);
    canvas.drawPath(rightLeaf, rightLeafPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}