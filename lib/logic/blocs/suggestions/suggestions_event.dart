part of 'suggestions_bloc.dart';

abstract class SuggestionsEvent extends Equatable {
  const SuggestionsEvent();

  @override
  List<Object> get props => [];
}

class SuggestionsRequested extends SuggestionsEvent {
  final String input;
  const SuggestionsRequested(this.input);

  @override
  List<Object> get props => [input];
}
