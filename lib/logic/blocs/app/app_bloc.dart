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
  final PrefsRepository _prefsRepository;
  final CatalogBloc _catalogBloc;
  AppBloc(
    UserRepository userRepository,
    AuthRepository authRepository,
    PrefsRepository prefsRepository,
    CatalogBloc catalogBloc,
  )   : _userRepository = userRepository,
        _authRepository = authRepository,
        _prefsRepository = prefsRepository,
        _catalogBloc = catalogBloc,
        super(const AppState()) {
    //on<AppUserChanged>(_onAppUserChanged);
    on<AppPrefLocationSet>(_onAppPrefLocationSet);
    _authRepository.getAuthStateChanges().listen((uid) {
      //add(AppUserChanged(uid));
      _onAppUserChanged(uid);
    });
  }

  //void _onAppUserChanged(AppUserChanged event, Emitter<AppState> emit) {
  void _onAppUserChanged(String uid) {
    uid.isEmpty
        ? print("No user signed in")
        : print("User with id: " + uid.toString() + " is signed in");
    if (uid.isEmpty) {
      emit(const AppState(status: AppStatus.noUser));
    } else {
      _userRepository.getUserData(uid).listen((user) async {
        // Catalog data should be fetched after user
        // authentication and firestore user data fetching
        if (_catalogBloc.state.status == CatalogStatus.initial) {
          _catalogBloc.add(CatalogStarted());
        }
        if (user.locations.isEmpty) {
          // Go to '/location_search'
          emit(AppState(status: AppStatus.noLocation, user: user));
        } else {
          // Retrieve last selected location
          final prefLocation = await _prefsRepository.getPrefLocation();

          // Go to '/catalog'
          emit(AppState(
            status: AppStatus.hasLocation,
            user: user,
            prefLocation: prefLocation,
          ));
        }
      });
    }
  }

  void _onAppPrefLocationSet(
      AppPrefLocationSet event, Emitter<AppState> emit) async {
    _prefsRepository.setPrefLocation(event.location);
    emit(state.copyWith(prefLocation: event.location));
  }
}
