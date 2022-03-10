import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/data/models/suggestion_model.dart';
import 'package:food_store/data/repositories/places_repository.dart';

part 'suggestions_event.dart';
part 'suggestions_state.dart';

class SuggestionsBloc extends Bloc<SuggestionsEvent, SuggestionsState> {
  final PlacesRepository _placesRepository;

  SuggestionsBloc(PlacesRepository placesRepository)
      : _placesRepository = placesRepository,
        super(const SuggestionsState()) {
    on<SuggestionsRequested>(_onSuggestionRequested);
  }

  void _onSuggestionRequested(
      SuggestionsRequested event, Emitter<SuggestionsState> emit) async {
    try {
      final List<Suggestion> suggestions =
          await _placesRepository.fetchSuggestions(event.input);
      emit(SuggestionsState(
          status: SuggestionStatus.loaded, suggestions: suggestions));
    } catch (e) {
      emit(const SuggestionsState(status: SuggestionStatus.failure));
    }
  }
}
