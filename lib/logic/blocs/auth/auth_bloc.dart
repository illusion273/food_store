import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/data/models/auth_model.dart';
import 'package:food_store/data/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  late final StreamSubscription<Auth> _userSubscription;

  AuthBloc({required AuthRepository authRepository})
      : _authRepository = authRepository,
        super(AuthLoading()) {
    on<SignUpRequested>(_onSignUpRequested);
    on<SignInRequested>(_onSignInRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<SignOutRequested>(_onSignOutRequested);
    on<AuthUserChanged>(_onUserChanged);

    // _userSubscription = _authRepository.getAuthStateChanges().listen((user) {
    //   print(user.email.toString());
    //   add(AuthUserChanged(user: user));
    // });
  }

  void _onUserChanged(AuthUserChanged event, Emitter<AuthState> emit) {
    //emit(AuthLoading());
    if (event.user.uid != "") {
      print('AuthBloc: User is currently signed in!');
      emit(Authenticated(auth: event.user));
    } else {
      print('AuthBloc: User is currently signed out!');
      emit(Unauthenticated());
    }
  }

  void _onSignInRequested(
      SignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signIn(
          email: event.email, password: event.password);
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignUpRequested(
      SignUpRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUp(
          email: event.email, password: event.password);
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onGoogleSignInRequested(
      GoogleSignInRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _authRepository.signInWithGoogle();
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void _onSignOutRequested(SignOutRequested event, Emitter<AuthState> emit) {
    emit(AuthLoading());
    unawaited(_authRepository.signOut());
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
