class HomeStats {
  const HomeStats({
    required this.usersCount,
    required this.postsCount,
    required this.adsCount,
  });

  final int usersCount;
  final int postsCount;
  final int adsCount;

  HomeStats copyWith({int? usersCount, int? postsCount, int? adsCount}) =>
      HomeStats(
        usersCount: usersCount ?? this.usersCount,
        postsCount: postsCount ?? this.postsCount,
        adsCount: adsCount ?? this.adsCount,
      );

  static const empty = HomeStats(usersCount: 0, postsCount: 0, adsCount: 0);
}
