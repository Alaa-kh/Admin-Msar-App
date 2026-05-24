import 'package:admin_msar/src/features/home/domain/entities/home_stats.dart';

sealed class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoaded extends HomeState {
  const HomeLoaded(this.stats);
  final HomeStats stats;
}

class HomeError extends HomeState {
  const HomeError(this.message);
  final String message;
}
