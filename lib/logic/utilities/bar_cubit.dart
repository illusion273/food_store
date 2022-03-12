import 'package:bloc/bloc.dart';

/// Handes slide transition of AppBar in CatalogScreen
class AnimBarCubit extends Cubit<bool> {
  AnimBarCubit() : super(false);
  void animate() {
    emit(!state);
  }
}

/// Handes slide transition of CartTile in OrderScreen
class AnimCartTileCubit extends Cubit<bool> {
  AnimCartTileCubit() : super(false);

  void animate() {
    emit(!state);
  }
}
