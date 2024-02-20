// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityImpl _$$ActivityImplFromJson(Map<String, dynamic> json) =>
    _$ActivityImpl(
      title: json['title'] as String,
      isLiked: json['isLiked'] as bool,
      isSaved: json['isSaved'] as bool,
    );

Map<String, dynamic> _$$ActivityImplToJson(_$ActivityImpl instance) =>
    <String, dynamic>{
      'title': instance.title,
      'isLiked': instance.isLiked,
      'isSaved': instance.isSaved,
    };
