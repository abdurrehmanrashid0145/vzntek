import 'package:flutter/material.dart';
import 'dart:async';
import '../styles/theme.dart';

/// Auto-scrolling horizontal row for technologies or recommendations
/// Automatically scrolls left continuously, pauses on hover
class AutoScrollRow extends StatefulWidget {
  final String title;
  final List<String> items;

  const AutoScrollRow({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<AutoScrollRow> createState() => _AutoScrollRowState();
}

class _AutoScrollRowState extends State<AutoScrollRow> {
  late ScrollController _scrollController;
  Timer? _timer;
  bool _isPaused = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    // Scroll continuously at 50ms intervals
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (!_isPaused && _scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        final delta = 1.0; // pixels to scroll per tick

        // Loop back to start when reaching end
        if (currentScroll >= maxScroll) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(currentScroll + delta);
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Duplicate items 3 times to create seamless loop effect
    final duplicatedItems = [...widget.items, ...widget.items, ...widget.items];

    return Column(
      children: [
        Text(
          widget.title,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 40),
        // Pause scrolling on hover
        MouseRegion(
          onEnter: (_) => setState(() => _isPaused = true),
          onExit: (_) => setState(() => _isPaused = false),
          child: SizedBox(
            height: 60,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: duplicatedItems.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.neonPurple.withOpacity(0.3)),
                  ),
                  child: Center(
                    child: Text(
                      duplicatedItems[index],
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}