### 📂 文档二：UI/UX 设计规范 - 执行版 [Final]

> **适用对象**：Flutter UI 开发
> **设计风格**：**"Vibrant TCG" (活力卡牌)**
> **核心动效**：极致顺滑的卡片翻转 (The Perfect Flip)

#### 1. 颜色系统 (Color Palette)

```dart
class AppColors {
  // 品牌色
  static const primaryOrange = Color(0xFFFF6B35); // 活力橙 - Logo/主按钮
  static const flipBlue = Color(0xFF4A90E2);      // 翻转蓝 - 辅助色/链接

  // 词性色 (视觉核心)
  static const verbRed = Color(0xFFE74C3C);      // 动词
  static const nounBlue = Color(0xFF3498DB);     // 名词
  static const adjGreen = Color(0xFF2ECC71);     // 形容词
  static const advYellow = Color(0xFFF39C12);    // 副词

  // 稀有度 (光效/边框)
  static const rarityCommon = Color(0xFFBDC3C7);
  static const rarityRare = Color(0xFF3498DB);   // 稀有 - 蓝光
  static const rarityEpic = Color(0xFF9B59B6);   // 史诗 - 紫光+粒子
  static const rarityLegend = Color(0xFFF39C12); // 传说 - 金色全屏光效

  // 星尘色
  static const stardust = Color(0xFFFFD700);     // 金色粉末
}

```

#### 2. 核心组件规范 (Widgets)

* **Logo 设计概念**：
* 一张正在空中翻转的橙色卡片，卡片周围有几颗金色的星尘点缀。
* 简洁、动感，呼应 "Flip"。


* **单词卡片 (FlipCard)**：
* **物理质感**：`Elevation: 4`，圆角 `16dp`。
* **正面**：单词(大号 Bold)、音标、稀有度边框。
* **背面**：释义、例句、词形变化列表。


* **关键动画：The Flip**：
* **时长**：500ms
* **曲线**：`Curves.easeInOutBack` (带一点回弹，增加Q弹的手感)。
* **3D效果**：在翻转过程中，稍微增加阴影深度，模拟卡片离屏飞起的感觉。


* **开包动画 (PackOpening)**：
* **关键帧**：
1. **Shake**: 卡包在屏幕中央晃动。
2. **Rip**: 手指划过 -> 撕裂效果 -> 爆出星尘光芒。
3. **Deal**: 5张卡片呈扇形飞出 (Fan out)。
4. **Flip**: 单张点击翻转，根据稀有度播放不同强度的音效和震动。





#### 3. 导航结构

* **底部导航 (NavBar)**：
1. **📖 翻翻 (Home)** - 首页，大大的 "Flip" 按钮。
2. **📚 图鉴 (Binder)** - 之前的“卡册”，改叫图鉴更有游戏感。
3. **🎯 任务 (Tasks)** - 赚取卡包。
4. **👤 我的 (Me)** - 星尘商城入口。



---
