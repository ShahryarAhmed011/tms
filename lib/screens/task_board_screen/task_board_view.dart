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

