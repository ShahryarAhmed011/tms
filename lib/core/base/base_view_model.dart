import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/utils/app_util.dart';

///BaseVM is a class that extends BaseViewModel and is used to provide an instance of AppUtil
class BaseVM extends BaseViewModel {
  ///initializes the AppUtil instance
  AppUtil appUtil = AppUtil();
}
