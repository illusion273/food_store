part of 'app_bloc.dart';

enum AppStatus { initial, hasLocation, noLocation, noUser, error }

class AppState extends Equatable {
  final AppStatus status;
  final User user;
  final Location? prefLocation;
  const AppState({
    this.status = AppStatus.initial,
    this.user = const User(),
    this.prefLocation,
  });

  @override
  List<Object?> get props => [status, user, prefLocation];

  AppState copyWith({
    AppStatus? status,
    AppStatus? prevStatus,
    User? user,
    Location? prefLocation,
  }) {
    return AppState(
      status: status ?? this.status,
      user: user ?? this.user,
      prefLocation: prefLocation ?? this.prefLocation,
    );
  }
}
