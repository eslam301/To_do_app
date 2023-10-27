import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

import '../core/network_layer/fireStore_utils.dart';
import '../model/task_model.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;

  TaskItemWidget({super.key, required this.taskModel});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
          color: Color(0xFFEC4B4B), borderRadius: BorderRadius.circular(20)),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              onPressed: (context) async {
                await FireStoreUtils.deleteDataFromFireStore(taskModel);
              },
              backgroundColor: Color(0xFFEC4B4B),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: Container(
          height: 115,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 100,
                  decoration: BoxDecoration(
                      color: theme.primaryColor,
                      borderRadius: BorderRadius.circular(8)),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        taskModel.title,
                        style: theme.textTheme.bodyLarge,
                      ),
                      Text(
                        taskModel.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.alarm,
                            size: 18,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            DateFormat.yMMMd().format(taskModel.dateTime),
                            style: theme.textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const ImageIcon(
                      color: Colors.white,
                      AssetImage("assets/images/Icons/Icon awesome-check.png")),
                ),
              ]),
        ),
      ),
    );
  }
}
