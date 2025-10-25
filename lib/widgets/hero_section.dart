import 'package:flutter/material.dart';
import '../styles/theme.dart';
import 'animated_tile.dart';
import 'navigation_pill.dart';

/// Main hero section with "Your Vision" headline and animated tiles
class HeroSection extends StatefulWidget {
  const HeroSection({super.key});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _titleAnimation;
  late Animation<double> _tilesAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    // Title animates first (0% to 50% of timeline)
    _titleAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.5, curve: Curves.easeOut),
    );
    
    // Tiles animate second (30% to 100% of timeline)
    _tilesAnimation = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeOutBack),
    );
    
    // Start animation after a slight delay
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Hero title section
        FadeTransition(
          opacity: _titleAnimation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, -0.5),
              end: Offset.zero,
            ).animate(_titleAnimation),
            child: Column(
              children: [
                Text(
                  'Your Vision',
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width > 600 ? 72 : 48,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Engineered By Us',
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.textSecondary,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        
        // Three animated hero tiles
        ScaleTransition(
          scale: _tilesAnimation,
          child: FadeTransition(
            opacity: _tilesAnimation,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              alignment: WrapAlignment.center,
              children: const [
                AnimatedTile(assetPath: 'assets/hero_1.png', index: 0),
                AnimatedTile(assetPath: 'assets/hero_2.png', index: 1),
                AnimatedTile(assetPath: 'assets/hero_3.png', index: 2),
              ],
            ),
          ),
        ),
        const SizedBox(height: 40),
        
        // Navigation pill
        const NavigationPill(),
      ],
    );
  }
}