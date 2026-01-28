# FlipWord 应用启动说明

## 🚀 快速启动

### 1. 安装依赖
```bash
flutter pub get
```

### 2. 运行应用
```bash
flutter run
```

或者指定设备：
```bash
# iOS 模拟器
flutter run -d ios

# Android 模拟器
flutter run -d android

# Chrome 浏览器（Web）
flutter run -d chrome
```

### 3. 热重载
应用运行后，修改代码可以使用热重载：
- 按 `r` 键：热重载（Hot Reload）
- 按 `R` 键：热重启（Hot Restart）
- 按 `q` 键：退出应用

## 📝 当前状态

- ✅ Supabase 服务已创建（使用占位符）
- ✅ Riverpod 已集成
- ✅ 主题系统已应用
- ✅ FlipCard 组件可用
- ✅ 临时首页展示可翻转卡片

## 🎯 测试功能

在临时首页，您可以：
1. **点击卡片**：查看 3D 翻转动画（500ms，easeInOutBack 曲线）
2. **查看正面**：单词 "Apple"、音标、词性标签、稀有度边框
3. **查看背面**：释义、词形变化
4. **翻转计数**：右上角显示翻转次数
5. **重置按钮**：清零翻转计数

## 🔧 下一步配置

### 配置 Supabase（实际使用前）

在 `lib/main.dart` 中替换占位符：

```dart
await SupabaseService.initialize(
  url: 'https://your-project.supabase.co',      // ← 替换为您的项目 URL
  anonKey: 'your-anon-key-here',                 // ← 替换为您的匿名密钥
);
```

获取 Supabase 凭据：
1. 访问 [https://supabase.com](https://supabase.com)
2. 创建项目或选择现有项目
3. 进入 Settings > API
4. 复制 `URL` 和 `anon/public` key

## 🐛 故障排除

### 问题 1: Supabase 初始化失败
- **原因**: 占位符 URL/Key 无效
- **解决**: 使用真实凭据，或暂时注释掉初始化代码

### 问题 2: 卡片不显示
- **检查**: 确保运行了 `flutter pub get`
- **检查**: 确保生成了 freezed 文件（`dart run build_runner build`）

### 问题 3: 主题颜色不正确
- **检查**: `lib/core/theme/app_theme.dart` 是否正确导入
- **检查**: `AppColors` 和 `AppTextStyles` 是否存在

## 📱 推荐测试设备

- **iOS**: iPhone 14 Pro（最佳视觉效果）
- **Android**: Pixel 7 或更高
- **Web**: Chrome（最新版本）

## 🎨 视觉效果预览

运行后您应该看到：
- ✅ 橙色主题（AppColors.primaryOrange）
- ✅ 圆角卡片（16dp）
- ✅ 3D 翻转动画
- ✅ 动态阴影效果
- ✅ 稀有度边框和发光

Enjoy! 🎉
