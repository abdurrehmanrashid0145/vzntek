import 'package:flutter/material.dart';
import 'dart:math' as math;
import '../styles/theme.dart';

/// Interactive tile with 3D tilt effect based on mouse position
/// - Tilts away from cursor when near edges
/// - Flattens when cursor is near center
class AnimatedTile extends StatefulWidget {
  final String assetPath;
  final int index;

  const AnimatedTile({
    super.key,
    required this.assetPath,
    required this.index,
  });

  @override
  State<AnimatedTile> createState() => _AnimatedTileState();
}

class _AnimatedTileState extends State<AnimatedTile> with SingleTickerProviderStateMixin {
  double _rotateX = 0.0;
  double _rotateY = 0.0;
  double _scale = 1.0;
  bool _isHovered = false;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AnimationConstants.tileHoverDuration,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Calculate tilt based on cursor position
  void _handleHover(PointerEvent details, BoxConstraints constraints) {
    final box = context.findRenderObject() as RenderBox;
    final localPosition = box.globalToLocal(details.position);
    
    final width = constraints.maxWidth;
    final height = constraints.maxHeight;
    
    // Normalize position to range -1 to 1 (center is 0,0)
    final x = (localPosition.dx - width / 2) / (width / 2);
    final y = (localPosition.dy - height / 2) / (height / 2);
    
    // Calculate distance from center
    final distance = math.sqrt(x * x + y * y);
    
    setState(() {
      if (distance < 0.3) {
        // Near center - flatten the tile
        _rotateX = 0;
        _rotateY = 0;
        _scale = 0.98;
      } else {
        // Near edges - tilt based on position
        _rotateX = -y * 0.1; // Reduced tilt amount for subtlety
        _rotateY = x * 0.1;
        _scale = 1.02;
      }
    });
  }

  void _handleExit() {
    setState(() {
      _rotateX = 0;
      _rotateY = 0;
      _scale = 1.0;
      _isHovered = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => _handleExit(),
          onHover: (event) => _handleHover(event, constraints),
          child: AnimatedContainer(
            duration: AnimationConstants.tileHoverDuration,
            curve: Curves.easeOut,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // Add perspective
              ..rotateX(_rotateX)
              ..rotateY(_rotateY)
              ..scale(_scale),
            child: Container(
              width: 140,
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.cardBackground,
                borderRadius: BorderRadius.circular(8),
                boxShadow: _isHovered
                    ? [
                        AppColors.neonGlowPurple,
                        const BoxShadow(
                          color: Colors.black54,
                          blurRadius: 15,
                          offset: Offset(0, 10),
                        ),
                      ]
                    : [
                        const BoxShadow(
                          color: Colors.black26,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.assetPath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Fallback if image not found
                    return Container(
                      color: AppColors.cardBackground,
                      child: Center(
                        child: Icon(
                          Icons.image_outlined,
                          size: 40,
                          color: AppColors.neonPurple.withOpacity(0.5),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}