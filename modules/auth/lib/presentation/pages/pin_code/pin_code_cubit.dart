import 'package:auth/navigation/navigator.dart';
import 'package:common/bloc/base_cubit.dart';

class PinCodeCubit extends BaseCubit<PinCodeState> {
  final AuthNavigator navigator;

  PinCodeCubit(this.navigator) : super(PinCodeState());

  void navigateToMainScreen() => navigator.navigateToMainScreen();
}

class PinCodeState {}
