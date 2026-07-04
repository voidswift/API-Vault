import 'package:freezed_annotation/freezed_annotation.dart';

part 'secret_data.freezed.dart';
part 'secret_data.g.dart';

@freezed
class SecretData with _$SecretData {
  const factory SecretData({
    required String name,
    required String secret,
    String? notes,
    String? environment,
    @Default([]) List<String> tags,
    @Default(false) bool favorite,
    @Default(false) bool archived,
  }) = _SecretData;

  factory SecretData.fromJson(Map<String, dynamic> json) => _$SecretDataFromJson(json);
}
