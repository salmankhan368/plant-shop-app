import 'package:demo_proj/core/services/shared_ref.dart';

class SharedPrefRepository {
  final SharedPrefServices _services;
  SharedPrefRepository(this._services);
  Future<void> savedOnboardStatus() {
    return _services.savedOnboardStatus();
  }

  Future<bool> getOnboardStatus() async {
    return _services.getOnboardStatus();
  }
}
