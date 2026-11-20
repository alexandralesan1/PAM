import 'package:equatable/equatable.dart';
import '../../domain/entities/home_data.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class HomeLoading extends HomeState {}

class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
  @override
  List<Object?> get props => [message];
}

class HomeSuccess extends HomeState {
  final HomeData data;
  HomeSuccess(this.data);
  @override
  List<Object?> get props => [data];
}