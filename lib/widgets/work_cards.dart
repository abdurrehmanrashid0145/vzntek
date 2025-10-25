import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../styles/theme.dart';

/// "Some of our work" section with portfolio cards
/// Each card animates in with staggered timing
class WorkCards extends StatefulWidget {
  const WorkCards({super.key});

  @override
  State<WorkCards> createState() => _WorkCardsState();
}

class _WorkCardsState extends State<WorkCards> with SingleTickerProviderStateMixin {
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
    if (!_isVisible && info.visibleFraction > 0.2) {
      setState(() => _isVisible = true);
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: const Key('work-cards'),
      onVisibilityChanged: _onVisibilityChanged,
      child: FadeTransition(
        opacity: _animation,
        child: Column(
          children: [
            const Text(
              'Some of our work',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 40),
            Wrap(
              spacing: 24,
              runSpacing: 24,
              alignment: WrapAlignment.center,
              children: List.generate(3, (index) {
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 600 + (index * 150)),
                  tween: Tween(begin: 0.0, end: _isVisible ? 1.0 : 0.0),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: WorkCard(index: index),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

/// Individual work card with hover lift effect
class WorkCard extends StatefulWidget {
  final int index;

  const WorkCard({super.key, required this.index});

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        transform: Matrix4.identity()
          ..translate(0.0, _isHovered ? -8.0 : 0.0),
        child: Container(
          width: 280,
          height: 360,
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: _isHovered ? AppColors.neonPurple : Colors.transparent,
              width: 1,
            ),
            boxShadow: _isHovered
                ? [AppColors.neonGlowPurple]
                : [
                    const BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card image
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Container(
                  height: 200,
                  color: Colors.black45,
                  child: Image.asset(
                    'assets/work_${widget.index + 1}.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return const Center(
                        child: Icon(
                          Icons.web,
                          size: 60,
                          color: Colors.white24,
                        ),
                      );
                    },
                  ),
                ),
              ),
              // Card content
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MedTagID',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'About MedTagID',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Chip(
                          label: Text('Appstore', style: TextStyle(fontSize: 11)),
                          backgroundColor: Colors.white12,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        ),
                        SizedBox(width: 8),
                        Chip(
                          label: Text('Playstore', style: TextStyle(fontSize: 11)),
                          backgroundColor: Colors.white12,
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                        ),
                      ],
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