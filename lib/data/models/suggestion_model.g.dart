// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'suggestion_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Suggestion _$SuggestionFromJson(Map<String, dynamic> json) => Suggestion(
      json['place_id'] as String,
      json['description'] as String,
    );

Map<String, dynamic> _$SuggestionToJson(Suggestion instance) =>
    <String, dynamic>{
      'place_id': instance.placeId,
      'description': instance.description,
    };
