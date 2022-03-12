import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'sign_state.dart';

class SignCubit extends Cubit<SignState> {
  SignCubit() : super(SignInitial());
}
