import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'data/datasources/remote_data_source.dart';
import 'data/repositories/app_repository_impl.dart';
import 'domain/repositories/app_repository.dart';
import 'domain/usecases/get_course_details.dart';
import 'domain/usecases/get_home.dart';
import 'presentation/cubit/home_cubit.dart';
import 'presentation/screens/home_screen.dart';

void main() {
  runApp(const LearningApp());
}

class LearningApp extends StatelessWidget {
  const LearningApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Aici se "leagă" straturile: Data -> Domain -> Presentation.
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AppRepository>(
          create: (_) => AppRepositoryImpl(
            remote: RemoteDataSourceImpl(client: http.Client()),
          ),
        ),
        RepositoryProvider<GetHome>(
          create: (ctx) => GetHome(ctx.read<AppRepository>()),
        ),
        RepositoryProvider<GetCourseDetails>(
          create: (ctx) => GetCourseDetails(ctx.read<AppRepository>()),
        ),
      ],
      child: MaterialApp(
        title: 'Learning App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: const Color(0xFFF5F6FA),
          useMaterial3: true,
        ),
        home: BlocProvider(
          create: (ctx) => HomeCubit(ctx.read<GetHome>())..load(),
          child: const HomeScreen(),
        ),
      ),
    );
  }
}

/// Culorile folosite in tot design-ul, ca sa fie usor de ajustat.
class AppColors {
  static const gray = Color(0xFF4A4A4A);
  static const primary = Color(0xFF5B67F0); // albastru-violet header
  static const primaryDark = Color(0xFF4C58E0);
  static const accent = Color(0xFFFF7A45); // portocaliu buton / badge
  static const purpleBanner = Color(0xFFEDE7FF); // fundal card Meetup
  static const purpleBannerText = Color(0xFF6C4FD6);
  static const textDark = Color(0xFF1D1E2C);
  static const textGrey = Color(0xFF9098B1);
  static const cardBg = Colors.white;
}
