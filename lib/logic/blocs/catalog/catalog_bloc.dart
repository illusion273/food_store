import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:food_store/data/models/catalog_model.dart';
import 'package:food_store/data/models/item_model.dart';
import 'package:food_store/data/repositories/category_repository.dart';
import 'package:food_store/data/repositories/products_repository.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  late final Catalog _catalog;
  final ProductsRepository _productsRepository;
  final CategoryRepository _categoryRepository;

  CatalogBloc(ProductsRepository productsRepository,
      CategoryRepository categoryRepository,
      {catalogRepository})
      : _productsRepository = productsRepository,
        _categoryRepository = categoryRepository,
        super(const CatalogState()) {
    on<CatalogStarted>(_onCatalogStarted);
    on<CatalogSearched>(_onCatalogSearched);
  }

  Future _onCatalogStarted(
      CatalogStarted event, Emitter<CatalogState> emit) async {
    emit(CatalogState(status: CatalogStatus.loading));
    var products = await _productsRepository.getProducts();
    var categories = await _categoryRepository.getCategories();
    _catalog = Catalog.generate(categories, products);
    emit(CatalogState(
      status: CatalogStatus.loading,
      catalog: _catalog,
    ));
  }

  void _onCatalogSearched(CatalogSearched event, Emitter<CatalogState> emit) {
    Map<String, List<Item>> temp = {};
    for (var entrie in _catalog.catalogTiles.entries) {
      var items = entrie.value
          .where((product) => product.title.toLowerCase().contains(event.value))
          .toList();
      if (items.isNotEmpty) {
        temp[entrie.key] = items;
      }
    }
    emit(CatalogState(
      status: CatalogStatus.loaded,
      catalog: _catalog.copyWith(catalogTiles: temp),
    ));
  }
}
