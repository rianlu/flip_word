// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ThemeModel _$ThemeModelFromJson(Map<String, dynamic> json) {
  return _Theme.fromJson(json);
}

/// @nodoc
mixin _$ThemeModel {
  /// 主题 ID (String)
  String get id => throw _privateConstructorUsedError;

  /// 主题名称（可选）
  String? get name => throw _privateConstructorUsedError;

  /// 主题 Emoji（可选）
  String? get emoji => throw _privateConstructorUsedError;

  /// 描述 (Description)
  String? get description => throw _privateConstructorUsedError;

  /// 分类 (Category)
  String? get category => throw _privateConstructorUsedError;

  /// 颜色 (Color Hex String)
  String? get color => throw _privateConstructorUsedError;

  /// Serializes this ThemeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ThemeModelCopyWith<ThemeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ThemeModelCopyWith<$Res> {
  factory $ThemeModelCopyWith(
    ThemeModel value,
    $Res Function(ThemeModel) then,
  ) = _$ThemeModelCopyWithImpl<$Res, ThemeModel>;
  @useResult
  $Res call({
    String id,
    String? name,
    String? emoji,
    String? description,
    String? category,
    String? color,
  });
}

/// @nodoc
class _$ThemeModelCopyWithImpl<$Res, $Val extends ThemeModel>
    implements $ThemeModelCopyWith<$Res> {
  _$ThemeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? emoji = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? color = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: freezed == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String?,
            emoji: freezed == emoji
                ? _value.emoji
                : emoji // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
            color: freezed == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ThemeImplCopyWith<$Res> implements $ThemeModelCopyWith<$Res> {
  factory _$$ThemeImplCopyWith(
    _$ThemeImpl value,
    $Res Function(_$ThemeImpl) then,
  ) = __$$ThemeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String? name,
    String? emoji,
    String? description,
    String? category,
    String? color,
  });
}

/// @nodoc
class __$$ThemeImplCopyWithImpl<$Res>
    extends _$ThemeModelCopyWithImpl<$Res, _$ThemeImpl>
    implements _$$ThemeImplCopyWith<$Res> {
  __$$ThemeImplCopyWithImpl(
    _$ThemeImpl _value,
    $Res Function(_$ThemeImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = freezed,
    Object? emoji = freezed,
    Object? description = freezed,
    Object? category = freezed,
    Object? color = freezed,
  }) {
    return _then(
      _$ThemeImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: freezed == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String?,
        emoji: freezed == emoji
            ? _value.emoji
            : emoji // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
        color: freezed == color
            ? _value.color
            : color // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ThemeImpl implements _Theme {
  const _$ThemeImpl({
    required this.id,
    this.name,
    this.emoji,
    this.description,
    this.category,
    this.color,
  });

  factory _$ThemeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ThemeImplFromJson(json);

  /// 主题 ID (String)
  @override
  final String id;

  /// 主题名称（可选）
  @override
  final String? name;

  /// 主题 Emoji（可选）
  @override
  final String? emoji;

  /// 描述 (Description)
  @override
  final String? description;

  /// 分类 (Category)
  @override
  final String? category;

  /// 颜色 (Color Hex String)
  @override
  final String? color;

  @override
  String toString() {
    return 'ThemeModel(id: $id, name: $name, emoji: $emoji, description: $description, category: $category, color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ThemeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emoji, emoji) || other.emoji == emoji) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, emoji, description, category, color);

  /// Create a copy of ThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ThemeImplCopyWith<_$ThemeImpl> get copyWith =>
      __$$ThemeImplCopyWithImpl<_$ThemeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ThemeImplToJson(this);
  }
}

abstract class _Theme implements ThemeModel {
  const factory _Theme({
    required final String id,
    final String? name,
    final String? emoji,
    final String? description,
    final String? category,
    final String? color,
  }) = _$ThemeImpl;

  factory _Theme.fromJson(Map<String, dynamic> json) = _$ThemeImpl.fromJson;

  /// 主题 ID (String)
  @override
  String get id;

  /// 主题名称（可选）
  @override
  String? get name;

  /// 主题 Emoji（可选）
  @override
  String? get emoji;

  /// 描述 (Description)
  @override
  String? get description;

  /// 分类 (Category)
  @override
  String? get category;

  /// 颜色 (Color Hex String)
  @override
  String? get color;

  /// Create a copy of ThemeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ThemeImplCopyWith<_$ThemeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
