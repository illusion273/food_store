part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class SuggestionSubmitted extends LocationEvent {
  final String placeId;
  const SuggestionSubmitted(this.placeId);

  @override
  List<Object> get props => [placeId];
}

class GeolocationRequested extends LocationEvent {}

class LocationConfirmed extends LocationEvent {
  final Location location;

  const LocationConfirmed(this.location);

  @override
  List<Object> get props => [location];
}

class LocationUpdated extends LocationEvent {
  final Location location;
  const LocationUpdated(this.location);

  @override
  List<Object> get props => [location];
}
