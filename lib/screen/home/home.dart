import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:truyen_full/helper/helper.dart';
import 'package:truyen_full/model/category.dart';
import 'package:truyen_full/service/category/category_api.dart';

import 'package:truyen_full/themes/colors.dart';
import 'package:provider/provider.dart';
import 'dart:isolate';
part 'home_logic.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeLogic logic;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    logic = HomeLogic(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: logic,
        child: Scaffold(
          backgroundColor: AppColors.white,
          appBar: AppBar(
            title: const Text(
              'Danh mục',
              style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.white,
            bottomOpacity: 0,
            elevation: 1,
          ),
          body: Selector<HomeLogic, List<Category>>(
            selector: (p0, p1) => p1.dataCategory,
            builder: (context, value, child) {
              return GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 100 / 30,
                  crossAxisCount: 2,
                ),
                shrinkWrap: true,
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/story',
                          arguments: value[index]);
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.backgroundColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            value[index].name,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                        )),
                  );
                },
              );
            },
          ),
        ));
  }
}
