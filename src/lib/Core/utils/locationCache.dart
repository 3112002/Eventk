import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Features/Home/Data/model/locationModel.dart';

/*Yara Adel Mohamed*/
class LocationCacheManager {
  static final _cache = getIt<CacheHelper>();

  static Future<void> clearLocationCache() async {
    await _cache.removeData(key: 'latitude');
    await _cache.removeData(key: 'longitude');
    await _cache.removeData(key: 'address');
    await _cache.removeData(key: 'last_updated');
  }

  static Future<void> saveLocationData(LocationModel location) async {
    await _cache.saveData(key: 'latitude', value: location.latitude);
    await _cache.saveData(key: 'longitude', value: location.longitude);
    await _cache.saveData(key: 'address', value: location.address);
    await _cache.saveData(
        key: 'last_updated', value: DateTime.now().toIso8601String());
  }

  static Future<LocationModel?> getCachedLocation() async {
    final lat = _cache.getData(key: 'latitude');
    final long = _cache.getData(key: 'longitude');
    final address = _cache.getData(key: 'address');
    final lastUpdated = _cache.getData(key: 'last_updated');

    if (lat == null || long == null) return null;

    // Validate cache freshness (1 hour max age)
    if (lastUpdated != null) {
      final age = DateTime.now().difference(DateTime.parse(lastUpdated));
      if (age.inHours > 1) {
        await clearLocationCache();
        return null;
      }
    }

    return LocationModel(
      latitude: lat,
      longitude: long,
      address: address ?? 'Unknown address',
    );
  }
}
