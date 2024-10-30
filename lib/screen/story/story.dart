import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:truyen_full/model/story/story.dart';
import 'package:truyen_full/model/category.dart';
import '../../service/category/category_api.dart';
import '../../themes/colors.dart';
import '../../widgets/image_widget.dart';
part 'story_logic.dart';

class ListStory extends StatefulWidget {
  const ListStory({super.key});

  @override
  State<ListStory> createState() => _ListStoryState();
}

class _ListStoryState extends State<ListStory> {
  late StoryLogic logic;
  @override
  void initState() {
    super.initState();
    logic = StoryLogic(context: context);
  }

  Category get slug => ModalRoute.of(context)!.settings.arguments as Category;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          elevation: 1,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            slug.name,
            style: const TextStyle(
                color: AppColors.primary,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppColors.white,
        ),
        body: Selector<StoryLogic, List<StoryModel>>(
            selector: (p0, p1) => p1.data,
            builder: (_, value, __) {
              return ListView.builder(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.all(10),
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/chapter',
                          arguments: value[index]);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(bottom: 10),
                      width: double.infinity,
                      color: AppColors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: ImageCustom(
                                urlImage: value[index].poster,
                                width: 80,
                                height: 80,
                                fit: BoxFit.cover,
                              )),
                          const SizedBox(
                            width: 15,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  value[index].title,
                                  style: const TextStyle(
                                      height: 1.5,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                Text(
                                  value[index].author,
                                  style: const TextStyle(
                                      color: AppColors.gray,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 3),
                                  child: Text(
                                    value[index].status,
                                    style: const TextStyle(
                                        color: AppColors.gray,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Text(
                                  DateFormat("HH:mm:ss dd-MM-yyyy").format(
                                      DateTime.parse(value[index].uploadDate)),
                                  style: const TextStyle(
                                      color: AppColors.gray,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              );
            }),
      ),
    );
  }
}
