import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/services/supabase_service.dart';
import 'core/services/mock_database_service.dart';
import 'core/services/preferences_service.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';
import 'core/theme/app_theme.dart';
import 'main_screen.dart';

void main() async {
  // 确保 Flutter 绑定初始化
  WidgetsFlutterBinding.ensureInitialized();

  // 初始化 Supabase（使用占位符）
  // TODO: 替换为您的实际 Supabase URL 和 Key
  await SupabaseService.initialize(
    url: 'https://your-project.supabase.co',
    anonKey: 'your-anon-key-here',
  );
  
  // 初始化偏好设置
  await PreferencesService().init();

  // 初始化数据服务 (加载 JSON)
  await MockDatabaseService().init();

  // 运行应用（使用 Riverpod 的 ProviderScope）
  runApp(
    ProviderScope(
      child: FlipWordApp(showOnboarding: PreferencesService().isFirstTime),
    ),
  );
}

/// FlipWord 应用主入口
class FlipWordApp extends StatelessWidget {
  final bool showOnboarding;
  
  const FlipWordApp({
      super.key, 
      this.showOnboarding = true,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlipWord',
      
      // 使用我们创建的主题
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // 跟随系统主题
      
      // 根据引导状态决定首页
      home: showOnboarding ? const OnboardingScreen() : const MainScreen(),
      
      debugShowCheckedModeBanner: false,
    );
  }
}
