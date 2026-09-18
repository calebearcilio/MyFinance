import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myfinance_app/core/routes/app_route.dart';

@Deprecated("Sem uso")
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  Future<void> _initialize() async {
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, AppRoutes.home);
  }

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    _initialize();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == .dark;
    final availableWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 40,
          children: [
            Image.asset(
              "assets/icons/icon.png",
              width: 130,
            ),

            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 400,
                  ),
                  child: SizedBox(
                    width: availableWidth * 0.7,
                    child: LinearProgressIndicator(
                      value: _animationController.value,
                      minHeight: 8,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              },
            ),

            SvgPicture.asset(
              isDark
                  ? "assets/titles/inner-shaded-title-dark.svg"
                  : "assets/titles/shaded-title-light.svg",
              width: 250,
            ),
          ],
        ),
      ),
    );
  }
}
