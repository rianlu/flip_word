// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'word.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Word _$WordFromJson(Map<String, dynamic> json) {
  return _Word.fromJson(json);
}

/// @nodoc
mixin _$Word {
  /// 单词 ID（自增主键）
  int get id => throw _privateConstructorUsedError;

  /// 单词拼写（必填）
  String get text => throw _privateConstructorUsedError;

  /// 音标（可选）
  String? get phonetic => throw _privateConstructorUsedError;

  /// 中文释义（可选）
  String? get definition => throw _privateConstructorUsedError;

  /// 词性 (n., v., adj., adv.)（可选）
  @JsonKey(name: 'part_of_speech')
  String? get partOfSpeech => throw _privateConstructorUsedError;

  /// 稀有度 (common, rare, epic, legend)（可选）
  String? get rarity => throw _privateConstructorUsedError;

  /// 主题 ID（可选）
  @JsonKey(name: 'theme_id')
  String? get themeId => throw _privateConstructorUsedError;

  /// 词形变化（JSON 格式）
  /// 例如：{"past": "ran", "plural": "runs", "present_participle": "running"}
  Map<String, dynamic>? get forms => throw _privateConstructorUsedError;

  /// Serializes this Word to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordCopyWith<Word> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordCopyWith<$Res> {
  factory $WordCopyWith(Word value, $Res Function(Word) then) =
      _$WordCopyWithImpl<$Res, Word>;
  @useResult
  $Res call({
    int id,
    String text,
    String? phonetic,
    String? definition,
    @JsonKey(name: 'part_of_speech') String? partOfSpeech,
    String? rarity,
    @JsonKey(name: 'theme_id') String? themeId,
    Map<String, dynamic>? forms,
  });
}

/// @nodoc
class _$WordCopyWithImpl<$Res, $Val extends Word>
    implements $WordCopyWith<$Res> {
  _$WordCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? phonetic = freezed,
    Object? definition = freezed,
    Object? partOfSpeech = freezed,
    Object? rarity = freezed,
    Object? themeId = freezed,
    Object? forms = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as int,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            phonetic: freezed == phonetic
                ? _value.phonetic
                : phonetic // ignore: cast_nullable_to_non_nullable
                      as String?,
            definition: freezed == definition
                ? _value.definition
                : definition // ignore: cast_nullable_to_non_nullable
                      as String?,
            partOfSpeech: freezed == partOfSpeech
                ? _value.partOfSpeech
                : partOfSpeech // ignore: cast_nullable_to_non_nullable
                      as String?,
            rarity: freezed == rarity
                ? _value.rarity
                : rarity // ignore: cast_nullable_to_non_nullable
                      as String?,
            themeId: freezed == themeId
                ? _value.themeId
                : themeId // ignore: cast_nullable_to_non_nullable
                      as String?,
            forms: freezed == forms
                ? _value.forms
                : forms // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WordImplCopyWith<$Res> implements $WordCopyWith<$Res> {
  factory _$$WordImplCopyWith(
    _$WordImpl value,
    $Res Function(_$WordImpl) then,
  ) = __$$WordImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int id,
    String text,
    String? phonetic,
    String? definition,
    @JsonKey(name: 'part_of_speech') String? partOfSpeech,
    String? rarity,
    @JsonKey(name: 'theme_id') String? themeId,
    Map<String, dynamic>? forms,
  });
}

/// @nodoc
class __$$WordImplCopyWithImpl<$Res>
    extends _$WordCopyWithImpl<$Res, _$WordImpl>
    implements _$$WordImplCopyWith<$Res> {
  __$$WordImplCopyWithImpl(_$WordImpl _value, $Res Function(_$WordImpl) _then)
    : super(_value, _then);

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? text = null,
    Object? phonetic = freezed,
    Object? definition = freezed,
    Object? partOfSpeech = freezed,
    Object? rarity = freezed,
    Object? themeId = freezed,
    Object? forms = freezed,
  }) {
    return _then(
      _$WordImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as int,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        phonetic: freezed == phonetic
            ? _value.phonetic
            : phonetic // ignore: cast_nullable_to_non_nullable
                  as String?,
        definition: freezed == definition
            ? _value.definition
            : definition // ignore: cast_nullable_to_non_nullable
                  as String?,
        partOfSpeech: freezed == partOfSpeech
            ? _value.partOfSpeech
            : partOfSpeech // ignore: cast_nullable_to_non_nullable
                  as String?,
        rarity: freezed == rarity
            ? _value.rarity
            : rarity // ignore: cast_nullable_to_non_nullable
                  as String?,
        themeId: freezed == themeId
            ? _value.themeId
            : themeId // ignore: cast_nullable_to_non_nullable
                  as String?,
        forms: freezed == forms
            ? _value._forms
            : forms // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WordImpl implements _Word {
  const _$WordImpl({
    required this.id,
    required this.text,
    this.phonetic,
    this.definition,
    @JsonKey(name: 'part_of_speech') this.partOfSpeech,
    this.rarity,
    @JsonKey(name: 'theme_id') this.themeId,
    final Map<String, dynamic>? forms,
  }) : _forms = forms;

  factory _$WordImpl.fromJson(Map<String, dynamic> json) =>
      _$$WordImplFromJson(json);

  /// 单词 ID（自增主键）
  @override
  final int id;

  /// 单词拼写（必填）
  @override
  final String text;

  /// 音标（可选）
  @override
  final String? phonetic;

  /// 中文释义（可选）
  @override
  final String? definition;

  /// 词性 (n., v., adj., adv.)（可选）
  @override
  @JsonKey(name: 'part_of_speech')
  final String? partOfSpeech;

  /// 稀有度 (common, rare, epic, legend)（可选）
  @override
  final String? rarity;

  /// 主题 ID（可选）
  @override
  @JsonKey(name: 'theme_id')
  final String? themeId;

  /// 词形变化（JSON 格式）
  /// 例如：{"past": "ran", "plural": "runs", "present_participle": "running"}
  final Map<String, dynamic>? _forms;

  /// 词形变化（JSON 格式）
  /// 例如：{"past": "ran", "plural": "runs", "present_participle": "running"}
  @override
  Map<String, dynamic>? get forms {
    final value = _forms;
    if (value == null) return null;
    if (_forms is EqualUnmodifiableMapView) return _forms;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'Word(id: $id, text: $text, phonetic: $phonetic, definition: $definition, partOfSpeech: $partOfSpeech, rarity: $rarity, themeId: $themeId, forms: $forms)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.phonetic, phonetic) ||
                other.phonetic == phonetic) &&
            (identical(other.definition, definition) ||
                other.definition == definition) &&
            (identical(other.partOfSpeech, partOfSpeech) ||
                other.partOfSpeech == partOfSpeech) &&
            (identical(other.rarity, rarity) || other.rarity == rarity) &&
            (identical(other.themeId, themeId) || other.themeId == themeId) &&
            const DeepCollectionEquality().equals(other._forms, _forms));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    phonetic,
    definition,
    partOfSpeech,
    rarity,
    themeId,
    const DeepCollectionEquality().hash(_forms),
  );

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      __$$WordImplCopyWithImpl<_$WordImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordImplToJson(this);
  }
}

abstract class _Word implements Word {
  const factory _Word({
    required final int id,
    required final String text,
    final String? phonetic,
    final String? definition,
    @JsonKey(name: 'part_of_speech') final String? partOfSpeech,
    final String? rarity,
    @JsonKey(name: 'theme_id') final String? themeId,
    final Map<String, dynamic>? forms,
  }) = _$WordImpl;

  factory _Word.fromJson(Map<String, dynamic> json) = _$WordImpl.fromJson;

  /// 单词 ID（自增主键）
  @override
  int get id;

  /// 单词拼写（必填）
  @override
  String get text;

  /// 音标（可选）
  @override
  String? get phonetic;

  /// 中文释义（可选）
  @override
  String? get definition;

  /// 词性 (n., v., adj., adv.)（可选）
  @override
  @JsonKey(name: 'part_of_speech')
  String? get partOfSpeech;

  /// 稀有度 (common, rare, epic, legend)（可选）
  @override
  String? get rarity;

  /// 主题 ID（可选）
  @override
  @JsonKey(name: 'theme_id')
  String? get themeId;

  /// 词形变化（JSON 格式）
  /// 例如：{"past": "ran", "plural": "runs", "present_participle": "running"}
  @override
  Map<String, dynamic>? get forms;

  /// Create a copy of Word
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordImplCopyWith<_$WordImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
