import 'package:flutter/material.dart';
import 'package:workin/core/services/hive_service.dart';
import 'package:workin/models/task_local_model.dart';
import 'package:workin/modules/home/components/task_card.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class OfflineScreen extends StatelessWidget {
  const OfflineScreen({super.key});

  List<Widget> _builder() {
    List<Widget> cards = [];
    for (TaskLocalModel task in HiveService.instance.tasks) {
      cards.add(
        TaskCard(
          task: task.task,
          assigneeName: task.assignee,
          onDelete: (t) {},
        ),
      );
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: AppColors.primaryBg),
      backgroundColor: AppColors.primaryBg,
      body: SingleChildScrollView(child: Column(children: _builder())),
    );
  }
}
