part of 'suggestions_bloc.dart';

enum SuggestionStatus { loaded, failure }

class SuggestionsState extends Equatable {
  final SuggestionStatus status;
  final List<Suggestion> suggestions;
  const SuggestionsState({
    this.status = SuggestionStatus.loaded,
    this.suggestions = const [],
  });

  @override
  List<Object> get props => [status, suggestions];
}
