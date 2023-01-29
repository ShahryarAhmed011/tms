import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/screens/history_screen/history_view.dart';
import 'package:tms/screens/kanban_board_screen/kanban_board_view.dart';
import 'package:tms/screens/task_board_screen/task_board_view_model.dart';
import 'package:tms/utils/app_colors.dart';

class TaskBoardView extends StatelessWidget {
  TaskBoardView({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Widget> bottomNavItems = [
    KanbanBoardView(),
    const HistoryView(),
  ];

  ///This function is a build method that is being overridden from the StatefulWidget class. It returns a Scaffold widget that is used to create the layout of the screen. The Scaffold widget contains an AppBar widget with a title and an action button, a Container widget for the body and a BottomNavigationBar widget for navigation.
  ///The AppBar has a background color of AppColors.primaryThemeColor and the title is dynamic, it is obtained from the TaskBoardViewModel class by calling model.appBarTitle. The action button is a InkWell widget that when pressed, it calls the isTaskExist and exportCSV method of the TaskBoardViewModel class. If the result of isTaskExist is true, it shows a SnackBar with the message obtained from the exportCSV method, otherwise it shows a SnackBar with the message "No task available".
  ///The body of the Scaffold is a Container widget with a color of Colors.white and the child is obtained from the bottomNavItems list using the index obtained from the TaskBoardViewModel class by calling model.navItemIndex.
  ///The BottomNavigationBar is a ClipRRect widget with a border radius and a shadow. It has a background color of AppColors.primaryThemeColor, it shows selected and unselected labels, it has unselected and selected item color of AppColors.primaryTextColor. The current index of the selected item is obtained from the TaskBoardViewModel class by calling model.navItemIndex. The items are two BottomNavigationBarItem widgets with icons and labels. When an item is tapped, it calls the navigateTo method of the TaskBoardViewModel class passing the index as parameter.
  ///The ViewModelBuilder widget is used to create and handle the TaskBoardViewModel instance. It calls the viewModelBuilder function passing () => TaskBoardViewModel() as parameter.
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskBoardViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: AppColors.primaryThemeColor,
              title: Text(model.appBarTitle),
                actions: [
                  Center(
                    child: InkWell(
                      onTap: () async {
                        late var snackBar;
                        if(await model.isTaskExist()){
                          String exportMessage= model.exportCSV();
                           snackBar = SnackBar(content: Text(exportMessage));
                        }else{
                           snackBar = const SnackBar(content: Text('No task available'));
                        }
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      },
                      child:  Row(
                        children: const [
                           Text(
                            'CSV Export ',
                            style: TextStyle(fontSize: 12, color: Colors.white,fontWeight: FontWeight.bold),),
                          SizedBox(width: 10,)
                        ],
                      ),),
                  )]
            ),
            body: Container(
                color: Colors.white, child: bottomNavItems[model.navItemIndex]),
            bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: BottomNavigationBar(
                    backgroundColor: AppColors.primaryThemeColor,
                    // fixedColor: AppColors.primaryTextColor,
                    showSelectedLabels: true,
                    showUnselectedLabels: true,
                    unselectedItemColor: AppColors.primaryTextColor,
                    selectedItemColor: AppColors.primaryTextColor,
                    currentIndex: model.navItemIndex,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.grid_on, color: AppColors.primaryTextColor),
                        label: "Kanban Board",
                        backgroundColor: AppColors.primaryThemeColor,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.history, color: AppColors.primaryTextColor),
                        label: "History",
                        backgroundColor: AppColors.primaryThemeColor,
                      ),
                    ],
                    onTap: (int index) {
                      model.navigateTo(index);
                    },
                  ),
                )
            )
       );
      },
      viewModelBuilder: () => TaskBoardViewModel(),
    );
  }

}

