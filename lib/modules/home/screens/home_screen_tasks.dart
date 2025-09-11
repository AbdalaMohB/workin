import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workin/models/task_container.dart';
import 'package:workin/modules/home/components/task_card.dart';
import 'package:workin/modules/home/providers/home_provider.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

class HomeScreenTasks extends StatelessWidget {
  final List<TaskContainer> containers;

  const HomeScreenTasks({super.key, required this.containers});

  List<Widget> _builder(BuildContext context) {
    List<Widget> cards = [];
    for (var i = 0; i < containers.length; i++) {
      TaskCard card = TaskCard(
        task: containers[i].task,
        assigneeName: containers[i].dev.name,
        onDelete: context.read<HomeProvider>().deleteTask,
      );
      cards.add(card);
    }
    if (cards.isEmpty) {
      cards.add(
        Center(child: Text("No Tasks Here", style: AppTextStyles.normal)),
      );
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: containers.isEmpty
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: _builder(context),
      ),
    );
  }
}
