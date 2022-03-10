import 'package:bloc/bloc.dart';

/// Handes slide transition of AppBar in CatalogScreen
class AnimBarCubit extends Cubit<bool> {
  AnimBarCubit() : super(false);
  void animate() {
    emit(!state);
  }
}

/// Handes slide transition of SearchBox in CatalogScreen
class AnimBoxCubit extends Cubit<bool> {
  AnimBoxCubit() : super(false);

  void animate() {
    emit(!state);
  }
}
