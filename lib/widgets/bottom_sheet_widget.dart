import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/core/network_layer/fireStore_utils.dart';

import '../model/task_model.dart';
import 'custom_text_form_field.dart';

class BottomSheetWidget extends StatefulWidget {
  BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(30),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Add new Task",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge?.copyWith(color: Colors.black),
            ),
            CustomTextFormField(
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return "you must provide task title";
                } else if (value.length < 10) {
                  return "your task title must be at least 10 characters";
                } else {
                  return null;
                }
              },
              title: "enter your task Title",
              controller: titleController,
            ),
            CustomTextFormField(
              controller: descriptionController,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return "you must provide task title";
                } else if (value.length < 10) {
                  return "your task title must be at least 10 characters";
                } else {
                  return null;
                }
              },
              maxLines: 4,
              title: "enter task description",
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Select time",
                  style: theme.textTheme.bodyLarge,
                ),
                GestureDetector(
                  onTap: () {
                    showCalender(context);
                  },
                  child: Text(DateFormat.yMMMd().format(selectedDate),
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: theme.primaryColor)),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  var model = TaskModel(
                    title: titleController.text,
                    description: descriptionController.text,
                    dateTime: DateTime.now(),
                    isDone: false,
                  );
                  FireStoreUtils.addDataToFIreStore(model);
                  Navigator.pop(context);
                }
              },
              child: Text(
                "Add Task",
                style: theme.textTheme.bodyLarge!.copyWith(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> showCalender(BuildContext context) async {
    var dateSelected = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (dateSelected == null) return;
    selectedDate = dateSelected;
    setState(() {});
  }
}
