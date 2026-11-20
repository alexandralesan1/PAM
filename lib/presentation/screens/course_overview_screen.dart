import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/course_cubit.dart';
import '../cubit/course_state.dart';
import '../../domain/entities/course_overview.dart';
import '../widgets/lesson_tile.dart';
import 'lesson_detail_screen.dart';

class CourseOverviewScreen extends StatelessWidget {
  const CourseOverviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.black,
        title: const Text('Course Overview', style: TextStyle(fontSize: 16)),
      ),
      body: BlocBuilder<CourseCubit, CourseState>(
        builder: (context, state) {
          if (state is CourseLoading) {
            return const Center(child: CircularProgressIndicator(color: kOrange));
          }
          if (state is CourseEmpty) {
            return const Center(child: Text('Nu există lecții'));
          }
          if (state is CourseError) {
            return Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Text(state.message),
                TextButton(
                  onPressed: () => context.read<CourseCubit>().load(),
                  child: const Text('Reîncearcă'),
                ),
              ]),
            );
          }
          final s = state as CourseSuccess;
          return Column(children: [
            Expanded(child: _Content(s)),
            _BottomBar(s.data),
          ]);
        },
      ),
    );
  }
}

class _Content extends StatelessWidget {
  final CourseSuccess s;
  const _Content(this.s);

  void _openLesson(BuildContext context, Lesson l) {
    if (l.locked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lecție blocată')),
      );
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<CourseCubit>(),
          child: LessonDetailScreen(lessonId: l.id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final d = s.data;
    final cubit = context.read<CourseCubit>();
    final lessons = s.visibleLessons;

    return ListView(padding: const EdgeInsets.fromLTRB(20, 8, 20, 20), children: [
      _Hero(d),
      const SizedBox(height: 18),
      Text(d.title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      const SizedBox(height: 8),
      Row(children: [
        const Icon(Icons.access_time, size: 16, color: Colors.grey),
        Text(' ${d.duration}  •  ${d.lessonCount} lessons',
            style: const TextStyle(color: Colors.grey)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFFFF3E0),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(children: [
            const Icon(Icons.star, color: Color(0xFFFFB300), size: 16),
            Text(' ${d.rating}',
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: kOrange)),
          ]),
        ),
      ]),
      const SizedBox(height: 16),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        _Tab('Lessons', s.showLessons, () => cubit.selectTab(true)),
        const SizedBox(width: 24),
        _Tab('Description', !s.showLessons, () => cubit.selectTab(false)),
      ]),
      const SizedBox(height: 8),
      if (s.showLessons) ...[
        _SearchBar(initial: s.query),
        const SizedBox(height: 8),
        _Controls(s),
        const SizedBox(height: 4),
        if (lessons.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Center(
              child: Text(
                s.filter == LessonFilter.favorites && s.query.isEmpty
                    ? 'No favorites yet'
                    : 'No lessons found',
              ),
            ),
          )
        else
          for (final l in lessons)
            LessonTile(
              lesson: l,
              highlighted: l.id == d.lessons.first.id,
              isFavorite: s.favorites.contains(l.id),
              onTap: () => _openLesson(context, l),
              onFavorite: () => cubit.toggleFavorite(l.id),
            ),
      ] else
        _Description(d),
    ]);
  }
}

/// Imaginea de sus, apropiată de designul Figma.
class _Hero extends StatelessWidget {
  final CourseOverview d;
  const _Hero(this.d);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF7B5CFF), Color(0xFFC98BC0), Color(0xFFE8A08F)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(alignment: Alignment.center, children: [
          // Poza din JSON, cu marginile estompate în gradient.
          Center(
            child: ShaderMask(
              shaderCallback: (rect) => const LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black,
                  Colors.black,
                  Colors.transparent,
                ],
                stops: [0, 0.3, 0.7, 1],
              ).createShader(rect),
              blendMode: BlendMode.dstIn,
              child: Image.network(
                d.heroImageUrl,
                width: 230,
                height: 150,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
                errorBuilder: (_, __, ___) =>
                const SizedBox(width: 230, height: 150),
              ),
            ),
          ),
          Positioned(
            top: 12,
            child: Text(
              d.heroLabel,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 15,
                letterSpacing: 0.5,
              ),
            ),
          ),
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                ),
              ],
            ),
            child: const Icon(Icons.play_arrow_rounded, color: kOrange, size: 30),
          ),
          Positioned(
            bottom: 10,
            child: Row(children: [
              _Chip(Icons.video_library_outlined, '${d.videoCount} Videos'),
              const SizedBox(width: 8),
              _Chip(Icons.school_outlined, '${d.classCount} Class'),
            ]),
          ),
        ]),
      ),
    );
  }
}

/// Tab-ul Description: textul din JSON, sau un rezumat construit din JSON
/// dacă `description.text` este gol.
class _Description extends StatelessWidget {
  final CourseOverview d;
  const _Description(this.d);

  @override
  Widget build(BuildContext context) {
    final text = d.description.trim().isNotEmpty
        ? d.description
        : '${d.title} is a ${d.duration} course with ${d.lessonCount} '
        'lessons, ${d.videoCount} videos and ${d.classCount} classes. '
        'Rated ${d.rating} by students.';

    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 12, 4, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('About this course',
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(text,
              style: const TextStyle(color: Colors.black87, height: 1.5)),
          const SizedBox(height: 16),
          _InfoRow(Icons.access_time, 'Duration', d.duration),
          _InfoRow(Icons.menu_book_outlined, 'Lessons', '${d.lessonCount}'),
          _InfoRow(Icons.video_library_outlined, 'Videos', '${d.videoCount}'),
          _InfoRow(Icons.school_outlined, 'Classes', '${d.classCount}'),
          _InfoRow(Icons.star_outline, 'Rating', '${d.rating}'),
          _InfoRow(Icons.sell_outlined, 'Price', d.priceLabel),
          const SizedBox(height: 16),
          const Text("What you'll learn",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          for (final l in d.lessons)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(children: [
                const Icon(Icons.check_circle_outline, size: 18, color: kOrange),
                const SizedBox(width: 8),
                Expanded(child: Text(l.title)),
              ]),
            ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoRow(this.icon, this.label, this.value);

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 6),
    child: Row(children: [
      Icon(icon, size: 18, color: Colors.grey),
      const SizedBox(width: 8),
      Text(label, style: const TextStyle(color: Colors.grey)),
      const Spacer(),
      Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
    ]),
  );
}

class _SearchBar extends StatefulWidget {
  final String initial;
  const _SearchBar({required this.initial});

  @override
  State<_SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<_SearchBar> {
  late final TextEditingController _c =
  TextEditingController(text: widget.initial);

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _c,
      onChanged: context.read<CourseCubit>().setQuery,
      decoration: InputDecoration(
        hintText: 'Search lessons',
        prefixIcon: const Icon(Icons.search, size: 20),
        filled: true,
        fillColor: Colors.white,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

class _Controls extends StatelessWidget {
  final CourseSuccess s;
  const _Controls(this.s);

  static const _filterLabels = {
    LessonFilter.all: 'All',
    LessonFilter.available: 'Available',
    LessonFilter.locked: 'Locked',
    LessonFilter.favorites: 'Favorites',
  };

  static const _sortLabels = {
    LessonSort.none: 'Default',
    LessonSort.shortest: 'Shortest first',
    LessonSort.longest: 'Longest first',
  };

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<CourseCubit>();
    return Row(children: [
      Expanded(
        child: Wrap(spacing: 8, children: [
          for (final f in LessonFilter.values)
            ChoiceChip(
              label: Text(_filterLabels[f]!, style: const TextStyle(fontSize: 12)),
              selected: s.filter == f,
              selectedColor: const Color(0xFFFFE0CC),
              onSelected: (_) => cubit.setFilter(f),
            ),
        ]),
      ),
      PopupMenuButton<LessonSort>(
        icon: const Icon(Icons.sort, color: kOrange),
        initialValue: s.sort,
        onSelected: cubit.setSort,
        itemBuilder: (_) => [
          for (final e in _sortLabels.entries)
            PopupMenuItem(value: e.key, child: Text(e.value)),
        ],
      ),
    ]);
  }
}

class _Chip extends StatelessWidget {
  final IconData icon;
  final String text;
  const _Chip(this.icon, this.text);

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      Icon(icon, size: 13, color: const Color(0xFF5B67F0)),
      const SizedBox(width: 4),
      Text(text, style: const TextStyle(fontSize: 11)),
    ]),
  );
}

class _Tab extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _Tab(this.label, this.selected, this.onTap);

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
              color: selected ? kOrange : Colors.transparent, width: 2),
        ),
      ),
      child: Text(label,
          style: TextStyle(
              color: selected ? kOrange : Colors.grey,
              fontWeight: FontWeight.w600)),
    ),
  );
}

class _BottomBar extends StatelessWidget {
  final CourseOverview d;
  const _BottomBar(this.d);

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(children: [
        OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(80, 52),
            side: const BorderSide(color: Color(0xFFFFE0CC)),
          ),
          child: Text(d.priceLabel, style: const TextStyle(color: kOrange)),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: d.enrollEnabled ? () {} : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: kOrange,
              foregroundColor: Colors.white,
              minimumSize: const Size(0, 52),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
            ),
            child: Text(d.enrollLabel),
          ),
        ),
      ]),
    ),
  );
}