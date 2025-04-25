import 'package:common/bloc/bloc.dart';
import 'package:home/navigation/navigator.dart';

class HomeCubit extends BaseCubit<HomeState> {
  final HomeNavigator navigator;

  HomeCubit(this.navigator) : super(HomeState()) {
    navigator.listenDidPop(() {
      addNews(ShowEventOnListener()); // вот тут мы получим колбек на didPop который реализовали в навигаторе
    });
  }

  @override
  Future<void> close() {
    navigator.unregisterListener(); // ну и не забываем удалять обзервер из стека если экран утилизирован
    return super.close();
  }

  void navigateToAccountDetailsScreen() => navigator.navigateToAccountDetailsScreen();
  void navigateToInternalScreen() => navigator.navigateToInternalScreen();
  void jumpToMoreScreen() => navigator.jumpToMoreScreen();
  void jumpToMoreScreenAndInternalScreen() => navigator.jumpToMoreScreenAndInternalScreen();
}

class HomeState {}

class ShowEventOnListener extends BlocNews {}
