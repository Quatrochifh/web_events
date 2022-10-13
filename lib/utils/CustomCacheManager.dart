import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CustomCacheManager extends CacheManager{
  static const key = 'cacheWebApp360';

  CustomCacheManager() : super(
    Config(
      key,
      stalePeriod: const Duration(days: 7)
    )
  );
}