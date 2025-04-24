import 'package:auth/navigation/navigator.dart';
import 'package:common/bloc/base_cubit.dart';

class LoginCubit extends BaseCubit<LoginState> {
  final AuthNavigator navigator;

  LoginCubit(this.navigator) : super(LoginState());

  void navigateToPinCode() => navigator.navigateToPinCode();
}

class LoginState {}
