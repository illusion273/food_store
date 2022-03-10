import 'package:json_annotation/json_annotation.dart';

part 'suggestion_model.g.dart';

//Models Google Places Autocomplete

@JsonSerializable()
class Suggestion {
  @JsonKey(name: 'place_id')
  final String placeId;
  final String description;

  const Suggestion(this.placeId, this.description);

  factory Suggestion.fromJson(Map<String, dynamic> json) =>
      _$SuggestionFromJson(json);
}
