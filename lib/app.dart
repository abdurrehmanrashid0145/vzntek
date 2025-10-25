import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'styles/theme.dart';
import 'widgets/header.dart';
import 'widgets/hero_section.dart';
import 'widgets/company_strip.dart';
import 'widgets/work_cards.dart';
import 'widgets/auto_scroll_row.dart';
import 'widgets/testimonial.dart';
import 'widgets/footer.dart';

class VznTekApp extends StatelessWidget {
  const VznTekApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VznTek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        textTheme: GoogleFonts.poppinsTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _pageController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _pageController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _pageController,
      curve: Curves.easeInOut,
    );
    _pageController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: AppColors.background,
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            child: Column(
              children: const [
                Header(),
                SizedBox(height: 40),
                HeroSection(),
                SizedBox(height: 60),
                CompanyStrip(),
                SizedBox(height: 80),
                WorkCards(),
                SizedBox(height: 80),
                AutoScrollRow(
                  title: 'Technologies We Use',
                  items: [
                    'React',
                    'Flutter',
                    'Node.js',
                    'Python',
                    'TypeScript',
                    'React',
                    'Flutter',
                  ],
                ),
                SizedBox(height: 80),
                Testimonial(),
                SizedBox(height: 80),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}