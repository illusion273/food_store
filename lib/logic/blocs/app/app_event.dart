part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AppUserChanged extends AppEvent {
  final String uid;
  const AppUserChanged(this.uid);
  @override
  List<Object> get props => [uid];
}

class AppSignOutRequested extends AppEvent {}

class AppSelectedLocationSet extends AppEvent {
  final Location selectedLocation;
  const AppSelectedLocationSet(this.selectedLocation);
  @override
  List<Object> get props => [selectedLocation];
}
