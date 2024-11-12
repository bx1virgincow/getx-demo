import 'package:demo/features/home/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../presentation/pages/home_screen.dart';

final homeController = Get.find<HomeController>();

List<Widget> bottomScreen = [
  HomeScreen(),
  Container(),
];
