import 'package:flutter/material.dart';
import '../models/course_overview.dart';

const kOrange = Color(0xFFFF6F00);

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  final bool highlighted;
  final bool isFavorite;
  final VoidCallback onTap;
  final VoidCallback onFavorite;

  const LessonTile({
    super.key,
    required this.lesson,
    required this.isFavorite,
    required this.onTap,
    required this.onFavorite,
    this.highlighted = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = lesson.locked ? const Color(0xFFFFE0CC) : kOrange;
    return Opacity(
      opacity: lesson.locked ? 0.5 : 1,
      child: ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,
        leading: CircleAvatar(
          radius: 22,
          backgroundColor: highlighted ? kOrange : Colors.white,
          child: Icon(Icons.play_arrow,
              color: highlighted ? Colors.white : color),
        ),
        title: Text(lesson.title,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        subtitle: Text('${lesson.duration} min',
            style: const TextStyle(fontSize: 12)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: onFavorite,
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.grey,
                size: 20,
              ),
            ),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }
}