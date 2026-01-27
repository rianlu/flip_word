// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pack.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Pack _$PackFromJson(Map<String, dynamic> json) {
  return _Pack.fromJson(json);
}

/// @nodoc
mixin _$Pack {
  /// 卡包 ID（前端生成，用于追踪）
  String get id => throw _privateConstructorUsedError;

  /// 卡包主题 ID（可选）
  int? get themeId => throw _privateConstructorUsedError;

  /// 卡包类型（普通包、主题包等）
  PackType get type => throw _privateConstructorUsedError;

  /// 卡包状态（未开/已开）
  PackStatus get status => throw _privateConstructorUsedError;

  /// 卡包内的单词列表（开包后填充）
  List<Word> get cards => throw _privateConstructorUsedError;

  /// 获得时间
  DateTime? get obtainedAt => throw _privateConstructorUsedError;

  /// Serializes this Pack to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Pack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PackCopyWith<Pack> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PackCopyWith<$Res> {
  factory $PackCopyWith(Pack value, $Res Function(Pack) then) =
      _$PackCopyWithImpl<$Res, Pack>;
  @useResult
  $Res call({
    String id,
    int? themeId,
    PackType type,
    PackStatus status,
    List<Word> cards,
    DateTime? obtainedAt,
  });
}

/// @nodoc
class _$PackCopyWithImpl<$Res, $Val extends Pack>
    implements $PackCopyWith<$Res> {
  _$PackCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Pack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? themeId = freezed,
    Object? type = null,
    Object? status = null,
    Object? cards = null,
    Object? obtainedAt = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            themeId: freezed == themeId
                ? _value.themeId
                : themeId // ignore: cast_nullable_to_non_nullable
                      as int?,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as PackType,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as PackStatus,
            cards: null == cards
                ? _value.cards
                : cards // ignore: cast_nullable_to_non_nullable
                      as List<Word>,
            obtainedAt: freezed == obtainedAt
                ? _value.obtainedAt
                : obtainedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PackImplCopyWith<$Res> implements $PackCopyWith<$Res> {
  factory _$$PackImplCopyWith(
    _$PackImpl value,
    $Res Function(_$PackImpl) then,
  ) = __$$PackImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int? themeId,
    PackType type,
    PackStatus status,
    List<Word> cards,
    DateTime? obtainedAt,
  });
}

/// @nodoc
class __$$PackImplCopyWithImpl<$Res>
    extends _$PackCopyWithImpl<$Res, _$PackImpl>
    implements _$$PackImplCopyWith<$Res> {
  __$$PackImplCopyWithImpl(_$PackImpl _value, $Res Function(_$PackImpl) _then)
    : super(_value, _then);

  /// Create a copy of Pack
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? themeId = freezed,
    Object? type = null,
    Object? status = null,
    Object? cards = null,
    Object? obtainedAt = freezed,
  }) {
    return _then(
      _$PackImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        themeId: freezed == themeId
            ? _value.themeId
            : themeId // ignore: cast_nullable_to_non_nullable
                  as int?,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as PackType,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as PackStatus,
        cards: null == cards
            ? _value._cards
            : cards // ignore: cast_nullable_to_non_nullable
                  as List<Word>,
        obtainedAt: freezed == obtainedAt
            ? _value.obtainedAt
            : obtainedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PackImpl implements _Pack {
  const _$PackImpl({
    required this.id,
    this.themeId,
    this.type = PackType.normal,
    this.status = PackStatus.unopened,
    final List<Word> cards = const [],
    this.obtainedAt,
  }) : _cards = cards;

  factory _$PackImpl.fromJson(Map<String, dynamic> json) =>
      _$$PackImplFromJson(json);

  /// 卡包 ID（前端生成，用于追踪）
  @override
  final String id;

  /// 卡包主题 ID（可选）
  @override
  final int? themeId;

  /// 卡包类型（普通包、主题包等）
  @override
  @JsonKey()
  final PackType type;

  /// 卡包状态（未开/已开）
  @override
  @JsonKey()
  final PackStatus status;

  /// 卡包内的单词列表（开包后填充）
  final List<Word> _cards;

  /// 卡包内的单词列表（开包后填充）
  @override
  @JsonKey()
  List<Word> get cards {
    if (_cards is EqualUnmodifiableListView) return _cards;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cards);
  }

  /// 获得时间
  @override
  final DateTime? obtainedAt;

  @override
  String toString() {
    return 'Pack(id: $id, themeId: $themeId, type: $type, status: $status, cards: $cards, obtainedAt: $obtainedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PackImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.themeId, themeId) || other.themeId == themeId) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._cards, _cards) &&
            (identical(other.obtainedAt, obtainedAt) ||
                other.obtainedAt == obtainedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    themeId,
    type,
    status,
    const DeepCollectionEquality().hash(_cards),
    obtainedAt,
  );

  /// Create a copy of Pack
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PackImplCopyWith<_$PackImpl> get copyWith =>
      __$$PackImplCopyWithImpl<_$PackImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PackImplToJson(this);
  }
}

abstract class _Pack implements Pack {
  const factory _Pack({
    required final String id,
    final int? themeId,
    final PackType type,
    final PackStatus status,
    final List<Word> cards,
    final DateTime? obtainedAt,
  }) = _$PackImpl;

  factory _Pack.fromJson(Map<String, dynamic> json) = _$PackImpl.fromJson;

  /// 卡包 ID（前端生成，用于追踪）
  @override
  String get id;

  /// 卡包主题 ID（可选）
  @override
  int? get themeId;

  /// 卡包类型（普通包、主题包等）
  @override
  PackType get type;

  /// 卡包状态（未开/已开）
  @override
  PackStatus get status;

  /// 卡包内的单词列表（开包后填充）
  @override
  List<Word> get cards;

  /// 获得时间
  @override
  DateTime? get obtainedAt;

  /// Create a copy of Pack
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PackImplCopyWith<_$PackImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
