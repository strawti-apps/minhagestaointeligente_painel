import 'package:supabase_flutter/supabase_flutter.dart';

import '../shared/constants/app_constants.dart';

class SupabaseConfig {
  static const String supabaseUrl = AppConstants.supabaseUrl;
  static const String supabaseAnonKey = AppConstants.supabaseAnonKey;

  static Future<void> initialize() async {
    await Supabase.initialize(url: supabaseUrl, anonKey: supabaseAnonKey);
  }
}
