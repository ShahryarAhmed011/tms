import 'dart:developer';
import 'package:get/get.dart';
import 'package:tms/core/base/base_repository.dart';
import 'package:tms/core/base/base_view_model.dart';
import 'package:tms/screens/home_screen/home_view.dart';


class SplashViewModel extends BaseVM {

  final String _title = 'Home View';
  String get title => _title;
  int _counter = 0;
  int get counter => _counter;

  /// This function updates the value of the _counter variable by increasing it by 1
  /// and notifying all the listeners.
  /// It also introduces a delay of 2 seconds before notifying the listeners.
  void updateCounter() {
    _counter++;
    Future.delayed(const Duration(seconds: 2));
    notifyListeners();
  }

  navigate()  {
    Future.delayed(const Duration(seconds: 0),() async{
      Get.offAll(HomeView());
    });
  }
}