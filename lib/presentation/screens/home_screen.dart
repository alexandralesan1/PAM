import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app_images.dart';
import '../../domain/entities/home_data.dart';
import '../../domain/usecases/get_course_details.dart';
import '../../main.dart';
import '../cubit/course_cubit.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import '../widgets/progress_ring.dart';
import 'course_overview_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: SafeArea(
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              );
            }
            if (state is HomeError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Text(state.message, textAlign: TextAlign.center),
                    TextButton(
                      onPressed: () => context.read<HomeCubit>().load(),
                      child: const Text('Reîncearcă'),
                    ),
                  ]),
                ),
              );
            }
            final d = (state as HomeSuccess).data;
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(d),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        _buildTopCards(d),
                        const SizedBox(height: 24),
                        Text(
                          d.planTitle,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textDark,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _learningPlanCard(d),
                        const SizedBox(height: 20),
                        _meetupBanner(context, d),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(HomeData d) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 48),
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                d.greeting,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                d.subtitle,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ),
          CircleAvatar(
            radius: 22,
            backgroundColor: Colors.white,
            // iconița se vede dacă poza nu se încarcă
            foregroundImage: NetworkImage(d.avatarUrl),
            onForegroundImageError: (_, __) {},
            child: const Icon(Icons.person, color: AppColors.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildTopCards(HomeData d) {
    return Transform.translate(
      offset: const Offset(0, -34),
      child: Column(
        children: [
          _dailyProgressCard(d),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(child: _startLearningCard(d)),
              const SizedBox(width: 12),
              _checkCard(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _dailyProgressCard(HomeData d) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                d.learnedTitle,
                style: const TextStyle(color: AppColors.textGrey, fontSize: 12),
              ),
              Text(
                d.myCoursesLabel,
                style: const TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '${d.learnedMinutes}min ',
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextSpan(
                  text: '/ ${d.goalMinutes}min',
                  style: const TextStyle(
                      color: AppColors.textGrey, fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: d.learnedProgress,
              minHeight: 8,
              backgroundColor: const Color(0xFFF0F1F7),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.accent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _startLearningCard(HomeData d) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        height: 150,
        color: const Color(0xFFDCE7FF),
        child: Stack(
          children: [
            Positioned(
              right: -14,
              bottom: -6,
              child: Image.asset(
                AppImages.startLearning,
                height: 138,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 130,
                    child: Text(
                      d.promptTitle,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textDark,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(d.promptAction,
                          style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _checkCard() {
    return Container(
      width: 64,
      height: 150,
      decoration: BoxDecoration(
        color: const Color(0xFFE9F0FF),
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.topRight,
      padding: const EdgeInsets.all(10),
      child: const Icon(Icons.check_circle, color: AppColors.primary, size: 20),
    );
  }

  Widget _learningPlanCard(HomeData d) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.cardBg,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          for (var i = 0; i < d.plan.length; i++) ...[
            if (i > 0) const Divider(height: 1),
            _planRow(d.plan[i]),
          ],
        ],
      ),
    );
  }

  Widget _planRow(PlanItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          ProgressRing(progress: item.progress),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              item.title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
            ),
          ),
          Text(
            '${item.completed}/${item.total}',
            style: const TextStyle(fontSize: 13, color: AppColors.textGrey),
          ),
        ],
      ),
    );
  }

  Widget _meetupBanner(BuildContext context, HomeData d) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => CourseCubit(context.read<GetCourseDetails>())..load(),
              child: const CourseOverviewScreen(),
            ),
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(30),
          color: AppColors.purpleBanner,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      d.meetupTitle,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        color: AppColors.purpleBannerText,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      d.meetupSubtitle,
                      style: const TextStyle(
                          fontSize: 12, color: AppColors.textGrey),
                    ),
                  ],
                ),
              ),
              Image.asset(
                AppImages.meetup,
                height: 64,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
