import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/screens/home_screen/home_view_model.dart';
import 'package:tms/utils/app_colors.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.primaryThemeColor,
              title: const Text('Projects'),
           ),

            body: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // const Text(Strings.allProjects,style: TextStyle(color: AppColors.headingTextColor,fontSize: 16),),
                model.isLoading == false
                    ? Expanded(
                        flex: 1,
                        child: Container(
                          child: ListView.builder(
                            itemCount: model.projectList.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: CircleAvatar(
                                  backgroundColor:
                                      AppColors.secondaryThemeColor,
                                  child: customText(
                                      'SL', AppColors.primaryTextColor),
                                ),
                                title: customText(
                                    model.projectList[index].name!,
                                    AppColors.secondaryTextColor),
                                trailing: const Icon(Icons.arrow_forward_ios,
                                    color: AppColors.secondaryThemeColor),
                                subtitle: Text(model
                                    .projectList[index].description
                                    .toString()),
                                onTap: () {
                                  model.navigate(model.projectList[index]);
                                },
                              );
                            },
                          ),
                        ),
                      )
                    : const Expanded(
                        flex: 1,
                        child: Center(child: CircularProgressIndicator()),
                      ),
              ],
            ));
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }

  Widget customText(String text, Color color) {
    return Text(
      text,
      style: TextStyle(
        color: color,
      ),
    );
  }
}






