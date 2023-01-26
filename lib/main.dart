import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tms/screens/splash_screen/splash_view.dart';
import 'package:tms/utils/app_colors.dart';
import 'di/di.dart';

void main() async {
  {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.primaryThemeColor,
      // navigation bar color
      statusBarColor: AppColors.primaryThemeColor, // status bar color
    ));
    WidgetsFlutterBinding.ensureInitialized();
    await DI.initDI();
    runApp(MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.



  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false, home: SplashView());
  }

  @override
  void initState()  {
     checkPermision();
     super.initState();
  }

  Future<void> checkPermision() async {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await [
          Permission.storage,
        ].request();
        checkPermision();
      }

    if (await Permission.location.isRestricted) {
      await [
        Permission.storage,
      ].request();
      checkPermision();
    }

  }
}
