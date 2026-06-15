// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../../models/user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  json['name'] as String,
  json['email'] as String,
  json['phone'] as String,
  DateTime.parse(json['date'] as String),
  Education.fromJson(json['education'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'name': instance.name,
  'email': instance.email,
  'education': instance.education,
  'phone': instance.phone,
  'date': instance.date.toIso8601String(),
};

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
  json['major'] as String,
  json['university'] as String,
  (json['coolness'] as num).toInt(),
);

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
  'major': instance.major,
  'university': instance.university,
  'coolness': instance.coolness,
};
