import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:truyen_full/model/chapter/chapter_id.dart';
import 'package:truyen_full/themes/colors.dart';
import 'package:tuple/tuple.dart';

import '../../../model/chapter/chapter.dart';
import '../../../service/category/category_api.dart';

part 'chapter_detail_logic.dart';

class ChapterDetail extends StatefulWidget {
  const ChapterDetail({super.key});

  @override
  State<ChapterDetail> createState() => _ChapterDetailState();
}

class _ChapterDetailState extends State<ChapterDetail> {
  late ChapterDetailLogic logic;
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    logic = ChapterDetailLogic(context: context);
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
  }

  void _scrollUp() {
    int seconds = 1;
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: Duration(seconds: seconds),
      curve: Curves.fastOutSlowIn,
    );
  }

  List<ChapterModel> get agr =>
      ModalRoute.of(context)!.settings.arguments as List<ChapterModel>;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: logic,
      child: Selector<ChapterDetailLogic, Tuple2<ChapterIDModel?, bool>>(
        selector: (p0, p1) => Tuple2(p1.data, p1.dark),
        builder: (context, value, child) {
          if (value.item1 == null) {
            return const Scaffold();
          }
          return Scaffold(
            backgroundColor:
                value.item2 ? AppColors.black : AppColors.backgroundColor,
            appBar: AppBar(
                backgroundColor:
                    value.item2 ? AppColors.black : AppColors.white,
                elevation: 1,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: value.item2 ? AppColors.white : AppColors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                title: Text(
                  value.item1!.header,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    color: value.item2 ? AppColors.white : AppColors.black,
                  ),
                ),
                bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(kToolbarHeight),
                    child: Container(
                      color: value.item2 ? AppColors.black : AppColors.white,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            InkWell(
                              child: PopupMenuButton(
                                offset: const Offset(-23, kToolbarHeight - 10),
                                child: Icon(
                                  Icons.abc,
                                  color: value.item2
                                      ? AppColors.white
                                      : AppColors.black,
                                  size: 35,
                                ),
                                onSelected: (value) {
                                  logic.changFont(value);
                                },
                                itemBuilder: (_) {
                                  return [
                                    const PopupMenuItem(
                                        value: 0, child: Text('Mặc định')),
                                    PopupMenuItem(
                                        value: 1,
                                        child: Text(
                                          'ABC',
                                          style: TextStyle(
                                            fontFamily:
                                                GoogleFonts.lato().fontFamily,
                                          ),
                                        )),
                                    PopupMenuItem(
                                        value: 2,
                                        child: Text(
                                          'ABC',
                                          style: TextStyle(
                                            fontFamily: GoogleFonts.montserrat()
                                                .fontFamily,
                                          ),
                                        ))
                                  ];
                                },
                              ),
                            ),
                            // IconButton(
                            //     onPressed: () {},
                            //     icon: Icon(
                            //       Icons.abc,
                            //       color: value.item2
                            //           ? AppColors.white
                            //           : AppColors.black,
                            //       size: 35,
                            //     )),
                            Selector<ChapterDetailLogic, bool>(
                              selector: (p0, p1) => p1.checkHorizontal,
                              builder: (context, val, child) {
                                return IconButton(
                                    onPressed: () {
                                      logic.checkFullScreen();
                                    },
                                    icon: Icon(
                                      val
                                          ? Icons.close_fullscreen
                                          : Icons.open_in_full,
                                      color: value.item2
                                          ? AppColors.white
                                          : AppColors.black,
                                    ));
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  logic.changDark();
                                },
                                icon: Icon(
                                  Icons.dark_mode,
                                  color: value.item2
                                      ? AppColors.white
                                      : AppColors.black,
                                )),
                            IconButton(
                                onPressed: () {
                                  logic.tang();
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: value.item2
                                      ? AppColors.white
                                      : AppColors.black,
                                )),
                            IconButton(
                                onPressed: () {
                                  logic.giam();
                                },
                                icon: Icon(
                                  Icons.remove,
                                  color: value.item2
                                      ? AppColors.white
                                      : AppColors.black,
                                ))
                          ]),
                    ))),
            body: SingleChildScrollView(
              controller: _controller,
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    value.item1!.header,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                      color: value.item2 ? AppColors.white : AppColors.black,
                    ),
                  ),
                  Selector<ChapterDetailLogic, Tuple2<String, double>>(
                    selector: (p0, p1) => Tuple2(p1.font, p1.count),
                    builder: (context, val, child) {
                      return Html(
                        data: value.item1!.body.first,
                        style: {
                          '*': Style(
                            color:
                                value.item2 ? AppColors.white : AppColors.black,
                            fontSize: FontSize(val.item2),
                            fontFamily: val.item1.isEmpty ? null : val.item1,
                          )
                        },
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          onPressed: () {
                            if (value.item1!.id != agr.first.id) {
                              int page = --value.item1!.id;
                              logic.getChapterDetail(page.toString());
                            }
                            _scrollUp();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color:
                                value.item2 ? AppColors.white : AppColors.black,
                          )),
                      Expanded(
                          child: Text(
                        value.item1!.header,
                        style: TextStyle(
                          color:
                              value.item2 ? AppColors.white : AppColors.black,
                        ),
                      )),
                      IconButton(
                          onPressed: () {
                            if (value.item1!.id != agr.last.id) {
                              int page = ++value.item1!.id;
                              logic.getChapterDetail(page.toString());
                            }
                            _scrollUp();
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color:
                                value.item2 ? AppColors.white : AppColors.black,
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
