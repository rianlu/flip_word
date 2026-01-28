import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase 服务（单例模式）
/// 管理 Supabase 客户端的初始化和访问
class SupabaseService {
  // 单例实例
  static SupabaseService? _instance;
  
  // 私有构造函数
  SupabaseService._();

  /// 获取单例实例
  static SupabaseService get instance {
    _instance ??= SupabaseService._();
    return _instance!;
  }

  /// 获取 Supabase 客户端
  SupabaseClient get client => Supabase.instance.client;

  /// 初始化 Supabase
  /// 
  /// [url] - Supabase 项目 URL
  /// [anonKey] - Supabase 匿名密钥
  static Future<void> initialize({
    required String url,
    required String anonKey,
  }) async {
    try {
      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
        debug: kDebugMode, // 仅在调试模式下启用日志
      );
      
      if (kDebugMode) {
        print('✅ Supabase initialized successfully');
        print('URL: $url');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Supabase initialization failed: $e');
      }
      rethrow;
    }
  }

  /// 检查用户是否已登录
  bool get isLoggedIn => client.auth.currentUser != null;

  /// 获取当前用户
  User? get currentUser => client.auth.currentUser;

  /// 获取当前用户 ID
  String? get currentUserId => client.auth.currentUser?.id;

  /// 登出
  Future<void> signOut() async {
    await client.auth.signOut();
  }
}
