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

class AppPrefLocationSet extends AppEvent {
  final Location location;
  const AppPrefLocationSet(this.location);
  @override
  List<Object> get props => [location];
}
