# Task Management System App

A Task Management System App created in flutter using Stacked MVVM Architecture. TMS supports both Android/IOS.

## Getting Started

The Task Management application (TMS) is a Flutter based application that allows you to manage your tasks in an efficient way. With TMS, you can create, edit and move tasks between different columns using the Kanban board feature. Additionally, you can track the time spent on each task using the built-in timer function and keep a history of completed tasks.

**How to Use**

To add a new task, click on the "Add Task" button.

To edit a task, click on the edit button in the task.

To move a task to a different stage, such as from "To-Do" to "In Progress", simply drag and drop the task to the desired stage.

To track time spent on a task.

To view the history of tasks, use the history tab.

To export data to CSV file, use the export button provided in the application.

## Installation

**Step 1:**

Install the flutter in your system:

```
https://docs.flutter.dev/get-started/install
```

**Step 2:**

Download or clone this repo by using the link below:

```
https://github.com/ShahryarAhmed011/tms.git
```

**Step 3:**

Go to the "View" menu and select "Tool Windows" and then "Terminal" or you can use the shortcut Alt + F12. The terminal window should appear at the bottom of the screen. You can use this terminal to execute command:

```
flutter pub get 
```

**Step 4:**

Connect your Android device to your computer or start an emulator:

**Step 5:**

In order to keep the source code synced automatically run the command:

```
flutter packages pub run build_runner watch
```

**Step 6:**

run the command 'flutter run'

Android Studio will build and deploy the app to your device or emulator.

## TMS Features Features:

* Splash
* Project listing
* Kanban board
* Create task
* Edit Task
* Drag and drop between columns
* Time tracking
* Export CSV

### Libraries & Tools Used

* [stacked](https://pub.dev/packages/stacked)
* [appflowy_board](https://pub.dev/packages/appflowy_board)
* [get](https://pub.dev/packages/get)
* [lottie](https://pub.dev/packages/lottie)
* [animated_text_kit](https://pub.dev/packages/animated_text_kit)
* [floor](https://pub.dev/packages/floor)
* [intl](https://pub.dev/packages/intl)
* [get_it](https://pub.dev/packages/get_it)
* [permission_handler](https://pub.dev/packages/permission_handler)
* [to_csv](https://pub.dev/packages/to_csv)

### Folder Structure
Here is the core folder structure which flutter provides.

```
flutter-app/
|- android
|- build
|- ios
|- lib
|- test
```

Here is the folder structure we have been using in this project

```
lib/
|- core/
|- db/
|- di/
|- models/
|- repositories/
|- screens/
|- utils/
|- main.dart
```

Now, lets dive into the lib folder which has the main code for the application.

```
1- core - All the application level constants and base classes are defined in this directory with-in their respective files.
2- db - Contains the data layer of the project, includes local storage floor/sqflte related code .
3- di - Contains dependency injection related code. 
4- models -Contains all the entity models used in the project.
5- util - Contains the utilities/common functions of your application.
6- repositories - Contains the busines logic of the project.
7- screens - contains all the ui related stuff and view models which are midleware between ui and repositories .
8- main.dart - This is the starting point of the application. All the application level configurations are defined in this file i.e, title, orientation etc.
```

### Main

This is the starting point of the application. All the application level configurations are defined in this file i.e, theme, routes, title, orientation etc.

```dart
import 'dart:developer';
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

    log("Main Method Called");
    Future.delayed(const Duration(seconds: 0),() async{
      //await addData();
    }).then((value)  {
      runApp(MyApp());
    });

  }
}
```
