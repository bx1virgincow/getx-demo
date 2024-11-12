import 'package:demo/features/home/presentation/pages/todo_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  HomeController get homeController => HomeController.instance;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: homeController.refreshEntities,
      child: FutureBuilder(
        future: homeController.future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          final todoList = homeController.todoList;
          return todoList.isEmpty
              ? const Center(
                  child: Text('No entity available'),
                )
              : Stack(
                  children: [
                    ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: todoList.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => TodoDetailPage(
                                todoModel: todoList[index],
                              ),
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Text(
                              '${todoList[index].id ?? 'id'}',
                            ),
                          ),
                          trailing: Obx(
                            () => Checkbox(
                              value: homeController.isItemChecked(index),
                              onChanged: (value) =>
                                  homeController.markEntity(index, value),
                            ),
                          ),
                          title: Text(
                            todoList[index].title ?? 'Title',
                          ),
                          subtitle: Text(
                            todoList[index].body ?? 'Body',
                          ),
                        );
                      },
                    ),
                    //position of banner
                    if (homeController.newFeedsAvailable.value)
                      Positioned(
                        top: 0,
                        right: 0,
                        child: Container(
                          width: 100,
                          height: 20,
                          color: Colors.amber,
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            children: [
                              const Text('New Post Available'),
                              IconButton(
                                onPressed: () async {
                                  await homeController.refreshEntities();
                                },
                                icon: const Icon(
                                  Icons.refresh,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                  ],
                );
        },
      ),
    );
  }
}
