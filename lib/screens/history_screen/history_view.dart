import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:tms/screens/history_screen/history_view_model.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: ListView.builder(
            itemCount: model.taskList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xff764abc),
                  child: Text(model.taskList![index].taskTitle!),
                ),
                title: Text('Task ${model.taskList![index].taskTitle!}'),
                subtitle: Column(
                  children: [
                    const SizedBox(height: 4),
                    (model.taskList[index].startTime!=null)?
                    Align(alignment: Alignment.bottomLeft,child: Text('Start Time: ${model.appUtil.format(model.taskList[index].startTime!)}')):
                    Container(),
                    const SizedBox(height: 4),
                    (model.taskList[index].timeSpent!=null)?
                    Align(alignment: Alignment.bottomLeft,child: Text('Spend Time: ${model.taskList[index].timeSpent}')):
                    Align(alignment: Alignment.bottomLeft,child: Text('Spend Time: ${model.appUtil.measureTotal(model.taskList[index].startTime!)}')),
                    const SizedBox(height: 4),
                  ],
                ),
              );
            }, ),
          );
      },
      viewModelBuilder: () => HistoryViewModel(),
    );
  }
}


