import 'package:demo/features/home/presentation/controllers/home_controller.dart';
import 'package:demo/features/home/utils/bottom_nav_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../widgets/exit_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = HomeController.instance;
  //controllers
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final userIdController = TextEditingController();
  final idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        final bool shouldPop = await showDialog(
                context: context,
                builder: (context) {
                  return buildAlertDialog(context);
                }) ??
            false;
        if (shouldPop) {
          SystemNavigator.pop();
          return;
        }
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trial App'),
        ),
        body: Obx(
          () => IndexedStack(
            index: homeController.currentIndex.value,
            children: bottomScreen,
          ),
        ),
        //bottom navigation
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: homeController.currentIndex.value,
            selectedItemColor: Colors.orange,
            unselectedItemColor: Colors.green,
            onTap: homeController.onTap,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: 'Account'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: idController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Enter id',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: userIdController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                  hintText: 'Enter userId',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  hintText: 'Enter title',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: bodyController,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                  hintText: 'Enter description',
                                  border: OutlineInputBorder()),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () async {
                                  final data = {
                                    'id': idController.text,
                                    'userId': userIdController.text,
                                    'title': titleController.text,
                                    'body': bodyController.text,
                                  };
                                  await homeController.addItem(data);

                                  //
                                },
                                child: const Text('Add Item'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          },
          label: const Text('Add Item'),
          icon: const Icon(Icons.add_outlined),
        ),
      ),
    );
  }
}
