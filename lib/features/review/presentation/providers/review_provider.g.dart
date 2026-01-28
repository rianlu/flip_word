// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$reviewSessionHash() => r'd37977f261f8e42ff9340bdd49f24b94c6b904c8';

/// 复习会话 Provider
/// 管理复习流程逻辑
///
/// Copied from [ReviewSession].
@ProviderFor(ReviewSession)
final reviewSessionProvider =
    AutoDisposeAsyncNotifierProvider<
      ReviewSession,
      ReviewSessionState
    >.internal(
      ReviewSession.new,
      name: r'reviewSessionProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$reviewSessionHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$ReviewSession = AutoDisposeAsyncNotifier<ReviewSessionState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
