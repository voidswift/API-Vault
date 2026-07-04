// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'secret_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SecretData _$SecretDataFromJson(Map<String, dynamic> json) => _SecretData(
  name: json['name'] as String,
  secret: json['secret'] as String,
  notes: json['notes'] as String?,
  environment: json['environment'] as String?,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  favorite: json['favorite'] as bool? ?? false,
  archived: json['archived'] as bool? ?? false,
);

Map<String, dynamic> _$SecretDataToJson(_SecretData instance) =>
    <String, dynamic>{
      'name': instance.name,
      'secret': instance.secret,
      'notes': instance.notes,
      'environment': instance.environment,
      'tags': instance.tags,
      'favorite': instance.favorite,
      'archived': instance.archived,
    };
