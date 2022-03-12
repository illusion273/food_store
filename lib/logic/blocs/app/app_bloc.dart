import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/data/models/location_model.dart';
import 'package:food_store/data/models/user_model.dart';
import 'package:food_store/data/repositories/auth_repository.dart';
import 'package:food_store/data/repositories/prefs_repository.dart';
import 'package:food_store/data/repositories/user_repository.dart';
import 'package:food_store/logic/blocs/catalog/catalog_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final CatalogBloc _catalogBloc;
  AppBloc(
    UserRepository userRepository,
    AuthRepository authRepository,
    PrefsRepository prefsRepository,
    CatalogBloc catalogBloc,
  )   : _userRepository = userRepository,
        _authRepository = authRepository,
        _catalogBloc = catalogBloc,
        super(const AppState()) {
    on<AppUserChanged>(_onAppUserChanged);
    on<AppSignOutRequested>(_onAppSignOutRequested);
    on<AppSelectedLocationSet>(_onAppSelectedLocationSet);
    _authRepository.getAuthStateChanges().listen((String uid) {
      add(AppUserChanged(uid));
    });
  }

  void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) async {
    if (event.uid.isEmpty) {
      emit(const AppState(status: AppStatus.noUser));
    } else {
      await for (var user in _userRepository.getUserData(event.uid)) {
        if (_catalogBloc.state.status == CatalogStatus.initial) {
          _catalogBloc.add(CatalogStarted());
        }
        if (user.locations.isEmpty) {
          // Go to '/location_search'
          emit(AppState(status: AppStatus.noLocation, user: user));
        } else {
          // Wait for catalog data to be fetched, then go to '/catalog'
          // await for (var catalogState in _catalogBloc.stream) {
          //   if (catalogState.status == CatalogStatus.loaded) {
          emit(AppState(
            status: AppStatus.hasLocation,
            user: user,
            selectedLocation: user.prefLocation,
          ));
          //}
          //}
        }
      }
    }
  }

  void _onAppSignOutRequested(
      AppSignOutRequested event, Emitter<AppState> emit) {
    _authRepository.signOut();
  }

  void _onAppSelectedLocationSet(
      AppSelectedLocationSet event, Emitter<AppState> emit) async {
    //_prefsRepository.setPrefLocation(event.location);
    emit(state.copyWith(selectedLocation: event.selectedLocation));
  }
}
