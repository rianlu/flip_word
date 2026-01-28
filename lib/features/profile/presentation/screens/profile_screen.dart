import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_colors.dart';
import '../providers/profile_provider.dart';
import '../widgets/shop_item_card.dart';
import '../../../../core/services/sound_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final profile = state.profile;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), // 柔和的浅灰背景
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // 顶部个人信息区
          SliverToBoxAdapter(
            child: _buildHeader(context, state),
          ),

          // 钱包区
          SliverToBoxAdapter(
            child: _buildWalletSection(context, profile.stardust),
          ),

          // 商店标题
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
              child: Row(
                children: [
                  const Icon(Icons.storefront_rounded, color: AppColors.primaryOrange),
                  const SizedBox(width: 8),
                  Text(
                    'Stardust Shop',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ],
              ),
            ),
          ),

          // 商店网格
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75, // 宽高比
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate(
                [
                  _buildShopItem(
                    context,
                    ref,
                    name: "Ocean Blue Back",
                    price: 500,
                    color: Colors.blueAccent,
                    userStardust: profile.stardust,
                  ),
                  _buildShopItem(
                    context,
                    ref,
                    name: "Sakura Pink Back",
                    price: 500,
                    color: const Color(0xFFFFB7C5),
                    userStardust: profile.stardust,
                  ),
                  _buildShopItem(
                    context,
                    ref,
                    name: "Gold Legend Frame",
                    price: 1000,
                    color: const Color(0xFFFFD700),
                    userStardust: profile.stardust,
                  ),
                ],
              ),
            ),
          ),

          // 设置区域标题
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
              child: Text(
                'Settings',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),

          // 设置列表
          SliverList(
            delegate: SliverChildListDelegate([
              _SettingsList(),
              const SizedBox(height: 50), // 底部留白
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileState state) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        bottom: 30,
        left: 20,
        right: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              // 头像
              CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.primaryOrange.withOpacity(0.1),
                child: Text(
                  state.profile.nickname?.substring(0, 1).toUpperCase() ?? 'U',
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primaryOrange,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              // 昵称信息
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.profile.nickname ?? 'Guest',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Level 5 Explorer', // Mock Level
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // 统计数据
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatItem(
                context, 
                value: state.daysStreak.toString(), 
                label: 'Days Streak', 
                icon: Icons.local_fire_department_rounded,
                color: Colors.orange,
              ),
              _buildContainerDivider(),
              _buildStatItem(
                context, 
                value: state.wordsCollected.toString(), 
                label: 'Words Collected', 
                icon: Icons.style_rounded,
                color: AppColors.flipBlue,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContainerDivider() {
    return Container(
      height: 40,
      width: 1,
      color: Colors.grey[300],
    );
  }

  Widget _buildStatItem(
    BuildContext context, {
    required String value,
    required String label,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 6),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[500],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildWalletSection(BuildContext context, int stardust) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF2C3E50),
            const Color(0xFF4CA1AF).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF2C3E50).withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'My Stardust',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Exchange for Rewards',
                style: TextStyle(
                  color: Colors.white30,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.stardust, size: 28)
                  .animate(onPlay: (c) => c.repeat(reverse: true))
                  .scale(begin: const Offset(1, 1), end: const Offset(1.2, 1.2)),
              const SizedBox(width: 12),
              Text(
                '$stardust',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildShopItem(
    BuildContext context,
    WidgetRef ref, {
    required String name,
    required int price,
    required Color color,
    required int userStardust,
  }) {
    return ShopItemCard(
      name: name,
      price: price,
      color: color,
      canAfford: userStardust >= price,
      onBuy: () {
        final success = ref.read(profileProvider.notifier).spendStardust(price);
        if (success) SoundService().playStardust();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success 
                ? 'Purchase successful! - $price Stardust' 
                : 'Not enough Stardust!',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: success ? Colors.green : Colors.red,
            duration: const Duration(seconds: 1),
            behavior: SnackBarBehavior.floating, // 浮动样式，更现代
          ),
        );
      },
    );
  }
}

class _SettingsList extends StatefulWidget {
  @override
  State<_SettingsList> createState() => _SettingsListState();
}

class _SettingsListState extends State<_SettingsList> {
  // Local state to reflect changes immediately
  // In a real app, this might come from a stream or provider
  bool _soundEnabled = SoundService().isSoundEnabled;
  bool _hapticsEnabled = SoundService().isHapticsEnabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSwitchTile(
          icon: Icons.volume_up_outlined,
          title: 'Sound Effects',
          value: _soundEnabled,
          onChanged: (val) {
             setState(() => _soundEnabled = val);
             SoundService().toggleSound(val);
          },
        ),
        _buildSwitchTile(
          icon: Icons.vibration_rounded,
          title: 'Haptic Feedback',
          value: _hapticsEnabled,
          onChanged: (val) {
             setState(() => _hapticsEnabled = val);
             SoundService().toggleHaptics(val);
          },
        ),
        _buildActionTile(Icons.notifications_outlined, 'Notifications'),
        _buildActionTile(Icons.logout_rounded, 'Log Out', isDestructive: true),
      ],
    );
  }

  Widget _buildSwitchTile({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SwitchListTile(
        secondary: Icon(icon, color: Colors.grey[700]),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        value: value,
        activeColor: AppColors.primaryOrange,
        onChanged: onChanged,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, {bool isDestructive = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isDestructive ? Colors.red : Colors.grey[700],
        ),
        title: Text(
          title,
          style: TextStyle(
            color: isDestructive ? Colors.red : Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: () {},
      ),
    );
  }
}
