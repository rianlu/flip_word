// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

UserWord _$UserWordFromJson(Map<String, dynamic> json) {
  return _UserWord.fromJson(json);
}

/// @nodoc
mixin _$UserWord {
  /// 用户 ID（UUID）
  @JsonKey(name: 'user_id')
  String get userId => throw _privateConstructorUsedError;

  /// 单词 ID
  @JsonKey(name: 'word_id')
  int get wordId => throw _privateConstructorUsedError;

  /// 是否已收集（点亮图鉴）
  @JsonKey(name: 'is_collected')
  bool get isCollected => throw _privateConstructorUsedError;

  /// 星级 (1-3)
  @JsonKey(name: 'star_level')
  int get starLevel => throw _privateConstructorUsedError; // ==========================================
  // SM-2 算法参数
  // ==========================================
  /// 下次复习时间（可选，未复习过则为 null）
  @JsonKey(name: 'next_review_at')
  DateTime? get nextReviewAt => throw _privateConstructorUsedError;

  /// 间隔天数（默认 0）
  int get interval => throw _privateConstructorUsedError;

  /// 难度系数（SM-2 算法，默认 2.5）
  @JsonKey(name: 'ease_factor')
  double get easeFactor => throw _privateConstructorUsedError;

  /// Serializes this UserWord to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserWordCopyWith<UserWord> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserWordCopyWith<$Res> {
  factory $UserWordCopyWith(UserWord value, $Res Function(UserWord) then) =
      _$UserWordCopyWithImpl<$Res, UserWord>;
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'word_id') int wordId,
    @JsonKey(name: 'is_collected') bool isCollected,
    @JsonKey(name: 'star_level') int starLevel,
    @JsonKey(name: 'next_review_at') DateTime? nextReviewAt,
    int interval,
    @JsonKey(name: 'ease_factor') double easeFactor,
  });
}

/// @nodoc
class _$UserWordCopyWithImpl<$Res, $Val extends UserWord>
    implements $UserWordCopyWith<$Res> {
  _$UserWordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? wordId = null,
    Object? isCollected = null,
    Object? starLevel = null,
    Object? nextReviewAt = freezed,
    Object? interval = null,
    Object? easeFactor = null,
  }) {
    return _then(
      _value.copyWith(
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            wordId: null == wordId
                ? _value.wordId
                : wordId // ignore: cast_nullable_to_non_nullable
                      as int,
            isCollected: null == isCollected
                ? _value.isCollected
                : isCollected // ignore: cast_nullable_to_non_nullable
                      as bool,
            starLevel: null == starLevel
                ? _value.starLevel
                : starLevel // ignore: cast_nullable_to_non_nullable
                      as int,
            nextReviewAt: freezed == nextReviewAt
                ? _value.nextReviewAt
                : nextReviewAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            interval: null == interval
                ? _value.interval
                : interval // ignore: cast_nullable_to_non_nullable
                      as int,
            easeFactor: null == easeFactor
                ? _value.easeFactor
                : easeFactor // ignore: cast_nullable_to_non_nullable
                      as double,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$UserWordImplCopyWith<$Res>
    implements $UserWordCopyWith<$Res> {
  factory _$$UserWordImplCopyWith(
    _$UserWordImpl value,
    $Res Function(_$UserWordImpl) then,
  ) = __$$UserWordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'user_id') String userId,
    @JsonKey(name: 'word_id') int wordId,
    @JsonKey(name: 'is_collected') bool isCollected,
    @JsonKey(name: 'star_level') int starLevel,
    @JsonKey(name: 'next_review_at') DateTime? nextReviewAt,
    int interval,
    @JsonKey(name: 'ease_factor') double easeFactor,
  });
}

/// @nodoc
class __$$UserWordImplCopyWithImpl<$Res>
    extends _$UserWordCopyWithImpl<$Res, _$UserWordImpl>
    implements _$$UserWordImplCopyWith<$Res> {
  __$$UserWordImplCopyWithImpl(
    _$UserWordImpl _value,
    $Res Function(_$UserWordImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of UserWord
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? wordId = null,
    Object? isCollected = null,
    Object? starLevel = null,
    Object? nextReviewAt = freezed,
    Object? interval = null,
    Object? easeFactor = null,
  }) {
    return _then(
      _$UserWordImpl(
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        wordId: null == wordId
            ? _value.wordId
            : wordId // ignore: cast_nullable_to_non_nullable
                  as int,
        isCollected: null == isCollected
            ? _value.isCollected
            : isCollected // ignore: cast_nullable_to_non_nullable
                  as bool,
        starLevel: null == starLevel
            ? _value.starLevel
            : starLevel // ignore: cast_nullable_to_non_nullable
                  as int,
        nextReviewAt: freezed == nextReviewAt
            ? _value.nextReviewAt
            : nextReviewAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        interval: null == interval
            ? _value.interval
            : interval // ignore: cast_nullable_to_non_nullable
                  as int,
        easeFactor: null == easeFactor
            ? _value.easeFactor
            : easeFactor // ignore: cast_nullable_to_non_nullable
                  as double,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$UserWordImpl implements _UserWord {
  const _$UserWordImpl({
    @JsonKey(name: 'user_id') required this.userId,
    @JsonKey(name: 'word_id') required this.wordId,
    @JsonKey(name: 'is_collected') this.isCollected = false,
    @JsonKey(name: 'star_level') this.starLevel = 1,
    @JsonKey(name: 'next_review_at') this.nextReviewAt,
    this.interval = 0,
    @JsonKey(name: 'ease_factor') this.easeFactor = 2.5,
  });

  factory _$UserWordImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserWordImplFromJson(json);

  /// 用户 ID（UUID）
  @override
  @JsonKey(name: 'user_id')
  final String userId;

  /// 单词 ID
  @override
  @JsonKey(name: 'word_id')
  final int wordId;

  /// 是否已收集（点亮图鉴）
  @override
  @JsonKey(name: 'is_collected')
  final bool isCollected;

  /// 星级 (1-3)
  @override
  @JsonKey(name: 'star_level')
  final int starLevel;
  // ==========================================
  // SM-2 算法参数
  // ==========================================
  /// 下次复习时间（可选，未复习过则为 null）
  @override
  @JsonKey(name: 'next_review_at')
  final DateTime? nextReviewAt;

  /// 间隔天数（默认 0）
  @override
  @JsonKey()
  final int interval;

  /// 难度系数（SM-2 算法，默认 2.5）
  @override
  @JsonKey(name: 'ease_factor')
  final double easeFactor;

  @override
  String toString() {
    return 'UserWord(userId: $userId, wordId: $wordId, isCollected: $isCollected, starLevel: $starLevel, nextReviewAt: $nextReviewAt, interval: $interval, easeFactor: $easeFactor)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserWordImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.isCollected, isCollected) ||
                other.isCollected == isCollected) &&
            (identical(other.starLevel, starLevel) ||
                other.starLevel == starLevel) &&
            (identical(other.nextReviewAt, nextReviewAt) ||
                other.nextReviewAt == nextReviewAt) &&
            (identical(other.interval, interval) ||
                other.interval == interval) &&
            (identical(other.easeFactor, easeFactor) ||
                other.easeFactor == easeFactor));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    wordId,
    isCollected,
    starLevel,
    nextReviewAt,
    interval,
    easeFactor,
  );

  /// Create a copy of UserWord
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserWordImplCopyWith<_$UserWordImpl> get copyWith =>
      __$$UserWordImplCopyWithImpl<_$UserWordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserWordImplToJson(this);
  }
}

abstract class _UserWord implements UserWord {
  const factory _UserWord({
    @JsonKey(name: 'user_id') required final String userId,
    @JsonKey(name: 'word_id') required final int wordId,
    @JsonKey(name: 'is_collected') final bool isCollected,
    @JsonKey(name: 'star_level') final int starLevel,
    @JsonKey(name: 'next_review_at') final DateTime? nextReviewAt,
    final int interval,
    @JsonKey(name: 'ease_factor') final double easeFactor,
  }) = _$UserWordImpl;

  factory _UserWord.fromJson(Map<String, dynamic> json) =
      _$UserWordImpl.fromJson;

  /// 用户 ID（UUID）
  @override
  @JsonKey(name: 'user_id')
  String get userId;

  /// 单词 ID
  @override
  @JsonKey(name: 'word_id')
  int get wordId;

  /// 是否已收集（点亮图鉴）
  @override
  @JsonKey(name: 'is_collected')
  bool get isCollected;

  /// 星级 (1-3)
  @override
  @JsonKey(name: 'star_level')
  int get starLevel; // ==========================================
  // SM-2 算法参数
  // ==========================================
  /// 下次复习时间（可选，未复习过则为 null）
  @override
  @JsonKey(name: 'next_review_at')
  DateTime? get nextReviewAt;

  /// 间隔天数（默认 0）
  @override
  int get interval;

  /// 难度系数（SM-2 算法，默认 2.5）
  @override
  @JsonKey(name: 'ease_factor')
  double get easeFactor;

  /// Create a copy of UserWord
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserWordImplCopyWith<_$UserWordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
