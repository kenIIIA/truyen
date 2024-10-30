import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:truyen_full/model/chapter/chapter.dart';
import 'package:truyen_full/model/story/story.dart';
import 'package:truyen_full/service/category/category_api.dart';
import 'package:truyen_full/themes/colors.dart';

import '../../widgets/image_widget.dart';
part 'chapter_logic.dart';

class ChapTerUI extends StatefulWidget {
  const ChapTerUI({super.key});

  @override
  State<ChapTerUI> createState() => _ChapTerUIState();
}

class _ChapTerUIState extends State<ChapTerUI> {
  late ChapterLogic logic;
  @override
  void initState() {
    super.initState();
    logic = ChapterLogic(context: context);
  }

  StoryModel get arg =>
      ModalRoute.of(context)!.settings.arguments as StoryModel;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: AppBar(
          backgroundColor: AppColors.white,
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
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(50)),
                          child: ImageCustom(
                            urlImage: arg.poster,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )),
                    ),
                    Text(
                      arg.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                          text: 'Tác giả: ',
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: arg.author,
                                style: const TextStyle(
                                    color: AppColors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                          text: 'Thể loại: ',
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          children: List.generate(
                              arg.categoryList.length,
                              (index) => TextSpan(
                                  text: '${arg.categoryList[index]}, ',
                                  style: const TextStyle(
                                      color: AppColors.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600))),
                        ),
                      ),
                    ),
                    Selector<ChapterLogic, int>(
                      selector: (p0, p1) => p1.dataArg.length,
                      builder: (context, value, child) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: RichText(
                            text: TextSpan(
                              text: 'Chương: ',
                              style: const TextStyle(
                                  color: AppColors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500),
                              children: [
                                TextSpan(
                                    text: value.toString(),
                                    style: const TextStyle(
                                        color: AppColors.blue,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(
                          text: 'Trạng thái: ',
                          style: const TextStyle(
                              color: AppColors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                          children: [
                            TextSpan(
                                text: arg.status,
                                style: const TextStyle(
                                    color: AppColors.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/chapterDetail',
                        arguments: logic.dataArg);
                  },
                  child: const Text(
                    'Đọc truyện',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
                  )),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(
                        arg.description.length,
                        (index) => Text(
                              arg.description[index],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ))),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.white),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Các chương mới nhất',
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w500),
                          ),
                          InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/lstChapter',
                                    arguments: logic.dataArg);
                              },
                              child: const Text(
                                'Xem thêm',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500),
                              ))
                        ],
                      ),
                    ),
                    Selector<ChapterLogic, List<ChapterModel>>(
                      selector: (p0, p1) => p1.data,
                      builder: (context, value, child) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              value.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 15),
                                    child: Text(value[index].header),
                                  )),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
