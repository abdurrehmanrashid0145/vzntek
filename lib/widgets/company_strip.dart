import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../styles/theme.dart';

/// "Trusted by leading companies" section with lime green border
/// Animates in when scrolled into view
class CompanyStrip extends StatefulWidget {
  const CompanyStrip({super.key});

  @override
  State<CompanyStrip> createState() => _CompanyStripState();
}

class _CompanyStripState extends State<CompanyStrip>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AnimationConstants.scrollRevealDuration,
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onVisibilityChanged(VisibilityInfo info) {
    // Trigger animation when 30% visible
    if (!_isVisible && info.visibleFraction > 0.3) {
      setState(() => _isVisible = true);
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('company-strip'),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _animation,
        child: SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(0, 0.3),
            end: Offset.zero,
          ).animate(_animation),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              padding: const EdgeInsets.all(32),
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: AppColors.limeGreen, width: 2),
                boxShadow: [AppColors.neonGlowLime],
              ),
              child: Column(
                children: [
                  const Text(
                    'Trusted by leading companies',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.limeGreen,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Wrap(
                    spacing: 40,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: List.generate(5, (index) {
                      return Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Colors.white24,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Image.asset(
                              'assets/company_${index + 1}.png',
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.business,
                                  color: Colors.white54,
                                  size: 40,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'MedTagID',
                            style: TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
