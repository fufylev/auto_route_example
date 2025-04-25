import 'package:common/bloc/bloc.dart';
import 'package:home/navigation/navigator.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeNavigator navigator;

  HomeCubit(this.navigator) : super(HomeState()) {
    navigator.listenDidPop(() {
      addNews(ShowEventOnListener());
    });
  }

  @override
  Future<void> close() {
    navigator.unregisterListener();
    return super.close();
  }

  void navigateToAccountDetailsScreen() => navigator.navigateToAccountDetailsScreen();
  void navigateToInternalScreen() => navigator.navigateToInternalScreen();
  void jumpToMoreScreen() => navigator.jumpToMoreScreen();
  void jumpToMoreScreenAndInternalScreen() => navigator.jumpToMoreScreenAndInternalScreen();
}

class HomeState {}

class ShowEventOnListener extends BlocNews {}
