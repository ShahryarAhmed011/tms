import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tms/screens/splash_screen/splash_view.dart';
import 'package:tms/utils/app_colors.dart';
import 'di/di.dart';


///The main() function is the entry point of the Flutter application. It sets the system UI overlay style for the status bar and navigation bar to the colors specified in the AppColors class. It also initializes the DI (dependency injection) and calls a log function to log that the "Main Method Called".
void main() async {

  {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: AppColors.primaryThemeColor,
      // navigation bar color
      statusBarColor: AppColors.primaryThemeColor, // status bar color
    ));
    WidgetsFlutterBinding.ensureInitialized();
    await DI.initDI();

    log("Main Method Called");
    Future.delayed(const Duration(seconds: 0),() async{
     //await addData();
    }).then((value)  {
      runApp(MyApp());
    });

  }
}


///The MyApp class extends StatefulWidget and creates a state object _MyAppState that overrides the build and initState methods. The build method returns an instance of GetMaterialApp with a home screen of SplashView. The initState method calls the checkPermision method which asynchronously checks for the storage and location permissions. If either of these permissions are denied or restricted, it will request the user for these permissions. Once the user grants the permissions, the checkPermision method will be called again to ensure that the correct permissions have been granted.
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
