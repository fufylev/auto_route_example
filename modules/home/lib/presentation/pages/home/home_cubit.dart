import 'package:common/bloc/base_cubit.dart';
import 'package:home/navigation/navigator.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeNavigator navigator;

  HomeCubit(this.navigator) : super(HomeState());

  void navigateToAccountDetailsScreen() => navigator.navigateToAccountDetailsScreen();
  void navigateToInternalScreen() => navigator.navigateToInternalScreen();
  void jumpToMoreScreen() => navigator.jumpToMoreScreen();
  void jumpToMoreScreenAndInternalScreen() => navigator.jumpToMoreScreenAndInternalScreen();
}

class HomeState {}
