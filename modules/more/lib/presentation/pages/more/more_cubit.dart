import 'package:common/bloc/base_cubit.dart';
import 'package:more/navigation/navigator.dart';

class MoreCubit extends BaseCubit<MoreState> {
  final MoreNavigator navigator;

  MoreCubit(this.navigator) : super(MoreState());

  void navigateToAccountDetailsScreen() => navigator.navigateToAccountDetailsScreen();
  void navigateToInternalScreen() => navigator.navigateToInternalScreen();
  void jumpToHomeScreen() => navigator.jumpToHomeScreen();
  void jumpToHomeScreenAndInternalScreen() => navigator.jumpToHomeScreenAndInternalScreen();
}

class MoreState {}
