part of 'app_bloc.dart';

enum AppStatus { initial, hasLocation, noLocation, noUser, error }

class AppState extends Equatable {
  final AppStatus status;
  final User user;
  final Location? selectedLocation;
  const AppState({
    this.status = AppStatus.initial,
    this.user = const User(),
    this.selectedLocation = const Location(),
  });

  @override
  List<Object?> get props => [status, user, selectedLocation];

  AppState copyWith({
    AppStatus? status,
    User? user,
    Location? selectedLocation,
  }) {
    return AppState(
        status: status ?? this.status,
        user: user ?? this.user,
        selectedLocation: selectedLocation ?? this.selectedLocation);
  }
}
