import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/core/network_layer/fireStore_utils.dart';

import '../model/task_model.dart';
import '../widgets/task_item_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      children: [
        Stack(
          alignment: Alignment(0, 2.5),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              height: 170,
              color: theme.primaryColor,
              child: Text(
                "To DO List",
                style: theme.textTheme.titleLarge,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(20),
              ),
              child: CalendarTimeline(
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) => print(date),
                leftMargin: 20,
                monthColor: Colors.black,
                dayColor: Colors.black,
                activeDayColor: theme.primaryColor,
                activeBackgroundDayColor: Colors.white,
                dotsColor: theme.primaryColor,
                selectableDayPredicate: (date) => date.day != 23,
                locale: 'en_ISO',
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 45,
        ),
        // Expanded(
        //   child: FutureBuilder<List<TaskModel>>(
        //       future: FireStoreUtils.getDataFromFireStore(),
        //       builder: (context, snaopshot) {
        //         if (snaopshot.hasError) {
        //           return Column(
        //             children: [
        //               Text(snaopshot.error.toString()),
        //               const SizedBox(
        //                 height: 20,
        //               ),
        //               IconButton(
        //                   onPressed: () {
        //                     FireStoreUtils.getDataFromFireStore();
        //                   },
        //                   icon: Icon(
        //                     Icons.refresh,
        //                     color: theme.primaryColor,
        //                   ))
        //             ],
        //           );
        //         }
        //         if (snaopshot.connectionState == ConnectionState.waiting) {
        //           return Center(
        //               child: CircularProgressIndicator(
        //             color: theme.primaryColor,
        //           ));
        //         }
        //         var tasksList = snaopshot.data ?? [];
        //         return Expanded(
        //             child: ListView.builder(
        //           itemBuilder: (BuildContext context, int index) =>
        //               TaskItemWidget(
        //             taskModel: tasksList[index],
        //           ),
        //           itemCount: 20,
        //         ));
        //       }),
        // )
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
              stream: FireStoreUtils.getRealTimeDataFromFireStore(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text(snapshot.error.toString()),
                      const SizedBox(
                        height: 20,
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.refresh,
                            color: theme.primaryColor,
                          ))
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                      child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ));
                }
                var tasksList =
                    snapshot.data?.docs.map((e) => e.data()).toList() ?? [];
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) =>
                      TaskItemWidget(
                    taskModel: tasksList[index],
                  ),
                  itemCount: tasksList.length,
                );
              }),
        )
      ],
    );
  }
}
