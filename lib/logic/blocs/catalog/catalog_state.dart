part of 'catalog_bloc.dart';

enum CatalogStatus { initial, loading, loaded }

class CatalogState extends Equatable {
  final CatalogStatus status;
  final Catalog catalog;
  const CatalogState(
      {this.status = CatalogStatus.initial, this.catalog = const Catalog()});

  @override
  List<Object> get props => [status, catalog];
}
