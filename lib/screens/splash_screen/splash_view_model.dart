import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/screens/home_screen/home_view.dart';

class SplashViewModel extends BaseViewModel {
  final String _title = 'Home View';
  String get title => _title;
  int _counter = 0;
  int get counter => _counter;

  void updateCounter() {
    _counter++;
    Future.delayed(const Duration(seconds: 2));
    notifyListeners();
  }

  navigate() {
    Future.delayed(const Duration(seconds: 0),(){
      Get.offAll(HomeView());
    });
  }
}