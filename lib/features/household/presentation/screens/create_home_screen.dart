import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';

class CreateHomeScreen extends StatefulWidget {
  const CreateHomeScreen({super.key});

  @override
  State<CreateHomeScreen> createState() => _CreateHomeScreenState();
}

class _CreateHomeScreenState extends State<CreateHomeScreen> {
  final TextEditingController _homeNameController = TextEditingController();

  @override
  void dispose() {
    _homeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // House with Plus Icon Illustration
              SizedBox(
                width: 86,
                height: 86,
                child: CustomPaint(
                  painter: _HousePlusPainter(),
                ),
              ),

              const SizedBox(height: 22),
              const Text('Create Your Home', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              const Text(
                'Give your home a name to start\nmanaging your fridge together',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 28),

              // Form Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.75),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Home Name',
                      style: TextStyle(
                        fontSize: 13.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: 'e.g. My Family Home',
                      controller: _homeNameController,
                    ),
                    const SizedBox(height: 20),
                    PrimaryButton(
                      text: 'Create Home',
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.inviteMembers);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HousePlusPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    final Paint housePaint = Paint()
      ..color = AppColors.primary
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.075
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    // Roof
    final Path roof = Path()
      ..moveTo(w * 0.10, h * 0.48)
      ..lineTo(w * 0.48, h * 0.14)
      ..lineTo(w * 0.86, h * 0.48);
    canvas.drawPath(roof, housePaint);

    // Walls
    final Path walls = Path()
      ..moveTo(w * 0.22, h * 0.42)
      ..lineTo(w * 0.22, h * 0.84)
      ..lineTo(w * 0.62, h * 0.84);
    canvas.drawPath(walls, housePaint);

    final Path rightWall = Path()
      ..moveTo(w * 0.74, h * 0.42)
      ..lineTo(w * 0.74, h * 0.56);
    canvas.drawPath(rightWall, housePaint);

    // Door / Inner Arch
    final Path door = Path()
      ..moveTo(w * 0.40, h * 0.84)
      ..lineTo(w * 0.40, h * 0.58)
      ..lineTo(w * 0.56, h * 0.58)
      ..lineTo(w * 0.56, h * 0.70);
    canvas.drawPath(door, housePaint);

    // Plus Circle Badge on bottom-right
    final Offset badgeCenter = Offset(w * 0.72, h * 0.74);
    final double badgeRadius = w * 0.18;

    final Paint bgCirclePaint = Paint()
      ..color = AppColors.scaffoldBg
      ..style = PaintingStyle.fill;
    canvas.drawCircle(badgeCenter, badgeRadius + 3, bgCirclePaint);

    final Paint badgePaint = Paint()
      ..color = AppColors.primaryLight
      ..style = PaintingStyle.fill;
    canvas.drawCircle(badgeCenter, badgeRadius, badgePaint);

    final Paint plusPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = w * 0.055
      ..strokeCap = StrokeCap.round;

    final double arm = badgeRadius * 0.48;
    canvas.drawLine(
      Offset(badgeCenter.dx - arm, badgeCenter.dy),
      Offset(badgeCenter.dx + arm, badgeCenter.dy),
      plusPaint,
    );
    canvas.drawLine(
      Offset(badgeCenter.dx, badgeCenter.dy - arm),
      Offset(badgeCenter.dx, badgeCenter.dy + arm),
      plusPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}