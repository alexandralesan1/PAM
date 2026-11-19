import 'package:flutter/material.dart';
import '../app_images.dart';
import '../main.dart';
import '../widgets/course_card.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  int _selectedTab = 0;
  final _tabs = const ['All', 'Popular', 'New'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _header(context),
              const SizedBox(height: 20),
              _searchBar(),
              const SizedBox(height: 20),
              _categories(),
              const SizedBox(height: 24),
              const Text(
                'Choice your course',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 14),
              _tabBar(),
              const SizedBox(height: 16),
              const CourseCard(
                title: 'Product Design v1.0',
                author: 'Robertson Connie',
                price: '\$190',
                duration: '16 hours',
                icon: Icons.design_services_rounded,
                iconBg: Color(0xFFB9D4FF),
              ),
              const CourseCard(
                title: 'Java Development',
                author: 'Nguyen Shane',
                price: '\$190',
                duration: '16 hours',
                icon: Icons.code_rounded,
                iconBg: AppColors.primary,
              ),
              const CourseCard(
                title: 'Visual Design',
                author: 'Bert Pullman',
                price: '\$250',
                duration: '14 hours',
                icon: Icons.palette_rounded,
                iconBg: Color(0xFFE8A3D6),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // Buton de back - te intoarce la Home (de unde ai dat click
            // pe bannerul Meetup).
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0F1FB),
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 16,
                  color: AppColors.textDark,
                ),
              ),
            ),
            const SizedBox(width: 12),
            const Text(
              'Course',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
          ],
        ),
        const CircleAvatar(
          radius: 20,
          backgroundColor: AppColors.primary,
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }

  Widget _searchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF0F1FB),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.search, color: AppColors.textGrey, size: 20),
          const SizedBox(width: 10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Find Course',
                hintStyle: TextStyle(color: AppColors.textGrey, fontSize: 14),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.tune, color: Colors.white, size: 16),
          ),
        ],
      ),
    );
  }

  Widget _categories() {
    return Row(
      children: [
        Expanded(
          child: _categoryCard(
            'Language',
            const Color(0xFFB9D4FF),
            AppImages.categoryLanguage,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _categoryCard(
            'Painting',
            const Color(0xFFF3D9EE),
            AppImages.categoryPainting,
          ),
        ),
      ],
    );
  }

  Widget _categoryCard(String label, Color bg, String imagePath) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 100,
        color: bg,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            // Ilustratia are fundal transparent, asa ca se aseaza direct
            // peste culoarea pastel a cardului, ca in Figma.
            Positioned(
              right: -14,
              bottom: -14,
              child: Image.asset(
                imagePath,
                height: 108,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  label,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                    color: AppColors.textDark,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _tabBar() {
    return Row(
      children: List.generate(_tabs.length, (i) {
        final selected = i == _selectedTab;
        return Padding(
          padding: const EdgeInsets.only(right: 10),
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = i),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: selected ? AppColors.primary : const Color(0xFFF0F1FB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                _tabs[i],
                style: TextStyle(
                  color: selected ? Colors.white : AppColors.textGrey,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
