import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../services/movie.dart';
import '../utils/constants.dart';
import '../widgets/movie_card.dart';
import '../widgets/movie_card_container.dart';
import '../widgets/multi_select_chip.dart';
import '../widgets/shadowless_floating_button.dart';
import '../utils/scroll_top_with_controller.dart' as scrollTop;

class FinderScreen extends StatefulWidget {
  final Color themeColor;
  FinderScreen({required this.themeColor});
  @override
  _FinderScreenState createState() => _FinderScreenState();
}

class _FinderScreenState extends State<FinderScreen> {
  String textFieldValue = "";
  //for scroll upping
  late ScrollController _scrollController;
  bool showBackToTopButton = false;
  List<MovieCard>? _movieCards;
  bool showLoadingScreen = false;

  List<String> tagList = [
    "Action",
    "Crime",
    "Comedic",
    "Dark",
    "Drama",
    "Fantasy",
    "Horror",
    "Inspiring",
    "Mind-Bending",
    "Prison",
  ];

  List<String> selectedTagList = [];

  Future<void> loadData(List<String> tags) async {
    MovieModel movieModel = MovieModel();

    _movieCards = await movieModel.getMoviesByTags(
      tagList: tags,
      themeColor: widget.themeColor,
    );

    setState(() {
      scrollTop.scrollToTop(_scrollController);
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          showBackToTopButton = (_scrollController.offset >= 200);
        });
      });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10.h,
        shadowColor: Colors.transparent.withOpacity(0.1),
        elevation: 0,
        title: Text(kFinderScreenTitleText, style: kSmallAppBarTitleTextStyle),
        backgroundColor: kSearchAppBarColor,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          SizedBox(height: 2.h),
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.symmetric(horizontal: 1.w),
            child: MultiSelectChip(
              tagList,
              onSelectionChanged: (selectedList) {
                setState(() {
                  selectedTagList = selectedList;
                  loadData(selectedList);
                });
              },
            ),
          ),
          (_movieCards == null)
              ? Container()
              : (_movieCards!.length == 0)
                  ? Center(child: Text(k404Text))
                  : Container(
                      alignment: Alignment.topLeft,
                      child: MovieCardContainer(
                        scrollController: _scrollController,
                        themeColor: widget.themeColor,
                        movieCards: _movieCards!,
                      )),
        ],
      )),
      floatingActionButton: showBackToTopButton
          ? ShadowlessFloatingButton(
              backgroundColor: widget.themeColor,
              iconData: Icons.keyboard_arrow_up_outlined,
              onPressed: () =>
                  setState(() => scrollTop.scrollToTop(_scrollController)),
            )
          : null,
    );
  }
}
