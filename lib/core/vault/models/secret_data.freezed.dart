// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'secret_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SecretData {

 String get name; String get secret; String? get notes; String? get environment; List<String> get tags; bool get favorite; bool get archived;
/// Create a copy of SecretData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecretDataCopyWith<SecretData> get copyWith => _$SecretDataCopyWithImpl<SecretData>(this as SecretData, _$identity);

  /// Serializes this SecretData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecretData&&(identical(other.name, name) || other.name == name)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.environment, environment) || other.environment == environment)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,secret,notes,environment,const DeepCollectionEquality().hash(tags),favorite,archived);

@override
String toString() {
  return 'SecretData(name: $name, secret: $secret, notes: $notes, environment: $environment, tags: $tags, favorite: $favorite, archived: $archived)';
}


}

/// @nodoc
abstract mixin class $SecretDataCopyWith<$Res>  {
  factory $SecretDataCopyWith(SecretData value, $Res Function(SecretData) _then) = _$SecretDataCopyWithImpl;
@useResult
$Res call({
 String name, String secret, String? notes, String? environment, List<String> tags, bool favorite, bool archived
});




}
/// @nodoc
class _$SecretDataCopyWithImpl<$Res>
    implements $SecretDataCopyWith<$Res> {
  _$SecretDataCopyWithImpl(this._self, this._then);

  final SecretData _self;
  final $Res Function(SecretData) _then;

/// Create a copy of SecretData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? secret = null,Object? notes = freezed,Object? environment = freezed,Object? tags = null,Object? favorite = null,Object? archived = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,environment: freezed == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [SecretData].
extension SecretDataPatterns on SecretData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecretData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecretData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecretData value)  $default,){
final _that = this;
switch (_that) {
case _SecretData():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecretData value)?  $default,){
final _that = this;
switch (_that) {
case _SecretData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String secret,  String? notes,  String? environment,  List<String> tags,  bool favorite,  bool archived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecretData() when $default != null:
return $default(_that.name,_that.secret,_that.notes,_that.environment,_that.tags,_that.favorite,_that.archived);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String secret,  String? notes,  String? environment,  List<String> tags,  bool favorite,  bool archived)  $default,) {final _that = this;
switch (_that) {
case _SecretData():
return $default(_that.name,_that.secret,_that.notes,_that.environment,_that.tags,_that.favorite,_that.archived);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String secret,  String? notes,  String? environment,  List<String> tags,  bool favorite,  bool archived)?  $default,) {final _that = this;
switch (_that) {
case _SecretData() when $default != null:
return $default(_that.name,_that.secret,_that.notes,_that.environment,_that.tags,_that.favorite,_that.archived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SecretData implements SecretData {
  const _SecretData({required this.name, required this.secret, this.notes, this.environment, final  List<String> tags = const [], this.favorite = false, this.archived = false}): _tags = tags;
  factory _SecretData.fromJson(Map<String, dynamic> json) => _$SecretDataFromJson(json);

@override final  String name;
@override final  String secret;
@override final  String? notes;
@override final  String? environment;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  bool favorite;
@override@JsonKey() final  bool archived;

/// Create a copy of SecretData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecretDataCopyWith<_SecretData> get copyWith => __$SecretDataCopyWithImpl<_SecretData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SecretDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecretData&&(identical(other.name, name) || other.name == name)&&(identical(other.secret, secret) || other.secret == secret)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.environment, environment) || other.environment == environment)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.favorite, favorite) || other.favorite == favorite)&&(identical(other.archived, archived) || other.archived == archived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,secret,notes,environment,const DeepCollectionEquality().hash(_tags),favorite,archived);

@override
String toString() {
  return 'SecretData(name: $name, secret: $secret, notes: $notes, environment: $environment, tags: $tags, favorite: $favorite, archived: $archived)';
}


}

/// @nodoc
abstract mixin class _$SecretDataCopyWith<$Res> implements $SecretDataCopyWith<$Res> {
  factory _$SecretDataCopyWith(_SecretData value, $Res Function(_SecretData) _then) = __$SecretDataCopyWithImpl;
@override @useResult
$Res call({
 String name, String secret, String? notes, String? environment, List<String> tags, bool favorite, bool archived
});




}
/// @nodoc
class __$SecretDataCopyWithImpl<$Res>
    implements _$SecretDataCopyWith<$Res> {
  __$SecretDataCopyWithImpl(this._self, this._then);

  final _SecretData _self;
  final $Res Function(_SecretData) _then;

/// Create a copy of SecretData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? secret = null,Object? notes = freezed,Object? environment = freezed,Object? tags = null,Object? favorite = null,Object? archived = null,}) {
  return _then(_SecretData(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,secret: null == secret ? _self.secret : secret // ignore: cast_nullable_to_non_nullable
as String,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,environment: freezed == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String?,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,favorite: null == favorite ? _self.favorite : favorite // ignore: cast_nullable_to_non_nullable
as bool,archived: null == archived ? _self.archived : archived // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
