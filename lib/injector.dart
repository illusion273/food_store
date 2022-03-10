import 'package:food_store/data/repositories/all_repos.dart';
import 'package:food_store/logic/all_blocs.dart';

import 'data/models/cart_model.dart';

class Injector {
  final Cart _cart;

  final AuthRepository _authRepository;
  final CategoryRepository _categoryRepository;
  final GeoRepository _geoRepository;
  final PlacesRepository _placesRepository;
  final PrefsRepository _prefsRepository;
  final ProductsRepository _productsRepository;
  final UserRepository _userRepository;

  late final AppBloc appBloc;
  late final AuthBloc authBloc;
  late final CartBloc cartBloc;
  late final CatalogBloc catalogBloc;
  late final LocationBloc locationBloc;
  late final SuggestionsBloc suggestionsBloc;
  late final ItemCubit itemCubit;
  late final OrderCubit orderCubit;

  Injector()
      : _cart = Cart(),
        _authRepository = AuthRepository(),
        _categoryRepository = CategoryRepository(),
        _geoRepository = GeoRepository(),
        _placesRepository = PlacesRepository(),
        _prefsRepository = PrefsRepository(),
        _productsRepository = ProductsRepository(),
        _userRepository = UserRepository() {
    catalogBloc = CatalogBloc(_productsRepository, _categoryRepository);
    appBloc = AppBloc(
        _userRepository, _authRepository, _prefsRepository, catalogBloc);
    authBloc = AuthBloc(authRepository: _authRepository);
    cartBloc = CartBloc(_cart)..add(CartStarted());
    locationBloc =
        LocationBloc(_placesRepository, _geoRepository, _userRepository);
    suggestionsBloc = SuggestionsBloc(_placesRepository);
    itemCubit = ItemCubit(cartBloc);
    orderCubit = OrderCubit(_cart, _userRepository, _prefsRepository);
  }
}
