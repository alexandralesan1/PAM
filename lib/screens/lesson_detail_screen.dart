import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/course_cubit.dart';
import '../cubit/course_state.dart';
import '../widgets/lesson_tile.dart';

class LessonDetailScreen extends StatelessWidget {
  final String lessonId;
  const LessonDetailScreen({super.key, required this.lessonId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state is! CourseSuccess) {
          return const Scaffold(body: SizedBox());
        }
        final lesson = state.data.lessons.firstWhere((l) => l.id == lessonId);
        final isFav = state.favorites.contains(lessonId);

        return Scaffold(
          backgroundColor: const Color(0xFFF9FAFF),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: Colors.black,
            title: const Text('Lesson', style: TextStyle(fontSize: 16)),
            actions: [
              IconButton(
                onPressed: () =>
                    context.read<CourseCubit>().toggleFavorite(lessonId),
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey,
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade200,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Center(
                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.play_arrow, color: kOrange, size: 34),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(lesson.title,
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600)),
                const SizedBox(height: 8),
                Row(children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.grey),
                  Text(' ${lesson.duration} min',
                      style: const TextStyle(color: Colors.grey)),
                ]),
                const SizedBox(height: 8),
                Text(
                  lesson.completed ? 'Completed' : 'Not completed',
                  style: TextStyle(
                    color: lesson.completed ? Colors.green : Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text('Course: ${state.data.title}',
                    style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        );
      },
    );
  }
}