part of 'location_bloc.dart';

enum LocationStatus { initial, loading, fullyLoaded, partiallyLoaded }

class LocationState extends Equatable {
  const LocationState({
    this.status = LocationStatus.initial,
    this.location = const Location(),
  });

  final LocationStatus status;
  final Location location;

  @override
  List<Object> get props => [status, location];
}
