import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../model/chapter/chapter.dart';
import '../../../service/category/category_api.dart';
import '../../../themes/colors.dart';
part 'list_chapter_logic.dart';

class ListChapter extends StatefulWidget {
  const ListChapter({super.key});

  @override
  State<ListChapter> createState() => _ListChapterState();
}

class _ListChapterState extends State<ListChapter> {
  late ListChapterLogic logic;
  @override
  void initState() {
    super.initState();
    logic = ListChapterLogic(context: context);
  }

  List<ChapterModel> get arg =>
      ModalRoute.of(context)!.settings.arguments as List<ChapterModel>;
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
          title: const Text(
            'Danh sách các chương',
            style: TextStyle(
                color: AppColors.primary, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          child: Column(
            children: List.generate(
                arg.length,
                (index) => InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/chapterDetail',
                            arguments: arg);
                      },
                      child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              arg[index].header,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500),
                            ),
                          )),
                    )),
          ),
        ),
      ),
    );
  }
}
