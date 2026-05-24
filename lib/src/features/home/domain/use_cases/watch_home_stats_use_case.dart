import 'package:admin_msar/src/core/utils/combine_latest.dart';
import 'package:admin_msar/src/features/ads/domain/repositories/ads_repository.dart';
import 'package:admin_msar/src/features/home/domain/entities/home_stats.dart';
import 'package:admin_msar/src/features/posts/domain/repositories/posts_repository.dart';
import 'package:admin_msar/src/features/users/domain/repositories/users_repository.dart';

class WatchHomeStatsUseCase {
  const WatchHomeStatsUseCase({
    required UsersRepository users,
    required PostsRepository posts,
    required AdsRepository ads,
  }) : _users = users,
       _posts = posts,
       _ads = ads;

  final UsersRepository _users;
  final PostsRepository _posts;
  final AdsRepository _ads;

  Stream<HomeStats> call() {
    return combineLatest3<int, int, int, HomeStats>(
      _users.usersCount(),
      _posts.postsCount(),
      _ads.adsCount(),
      (u, p, a) => HomeStats(usersCount: u, postsCount: p, adsCount: a),
    );
  }
}
