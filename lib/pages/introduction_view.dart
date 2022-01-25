import 'package:flutter/material.dart';
import 'package:song_tea_app/helper/st_color.dart';
import 'package:song_tea_app/helper/st_text.dart';
import 'package:song_tea_app/helper/st_variable.dart';
import 'package:song_tea_app/pages/home_view.dart';

class Intro {
  final int id;
  final String title;
  final String description;
  final String image;

  Intro(this.id, this.title, this.description, this.image);
}

class IntroductionView extends StatefulWidget {
  const IntroductionView({Key? key}) : super(key: key);

  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  int currentPage = 0;
  late PageController _controller;
  bool isButtonPress = false;

  List<Intro> introList = [
    Intro(1, 'Intro slider', 'description', 'images/intro1.jpg'),
    Intro(1, 'Intro slider', 'description', 'images/intro2.jpg'),
    Intro(1, 'Intro slider', 'description', 'images/intro3.jpg'),
    Intro(1, 'Intro slider', 'description', 'images/intro4.jpg'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    mainWidth = MediaQuery.of(context).size.width;
    mainHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: currentPage == 0
          ? ClsSTColor.getColor(color: STColor.appBarColor)
          : currentPage == 1
              ? ClsSTColor.getColor(color: STColor.background)
              : currentPage == 2
                  ? ClsSTColor.getColor(color: STColor.green60)
                  : ClsSTColor.getColor(color: STColor.stawberry),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            bottom: 0,
            child: SizedBox(
              height: mainHeight,
              width: mainWidth,
              child: PageView.builder(
                  itemCount: introList.length,
                  onPageChanged: (value) {
                    setState(() {
                      currentPage = value;
                    });
                  },
                  controller: _controller,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: mainWidth,
                      height: mainHeight,
                      child: Stack(
                        children: [
                          Positioned(
                            top: mainWidth * 0.5,
                            left: mainWidth * wPaddingAll * 2,
                            child: STText(
                              text: introList[index].title,
                              fontWeight: FontWeight.bold,
                              fontFamily: STFontFamily.poppin,
                              fontSize: STFontSize.large,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
          Positioned(
            bottom: mainWidth * wPaddingAll * 2,
            // left: mainWidth * wPaddingAll * 2,
            child: SizedBox(
              width: mainWidth,
              height: mainWidth * wPaddingAll * 2.8,
              child: Stack(
                children: [
                  currentPage == 0
                      ? Container()
                      : Positioned(
                          left: mainWidth * wPaddingAll * 1.5,
                          child: GestureDetector(
                              onTap: () {
                                if (currentPage != 0) {
                                  _controller.previousPage(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut);
                                }
                              },
                              child: Container(
                                  width: mainWidth * 0.1,
                                  height: mainWidth * 0.1,
                                  padding:
                                      EdgeInsets.only(left: mainWidth * 0.01),
                                  decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                            offset: const Offset(1, 1),
                                            blurRadius: 5,
                                            spreadRadius: 3,
                                            color: Colors.grey.withOpacity(0.5))
                                      ]),
                                  child: Icon(Icons.arrow_back_ios,
                                      color: Colors.white,
                                      size: mainWidth * wPaddingAll * 1.3))),
                        ),
                  Positioned(
                    left: mainWidth * 0.45,
                    top: mainWidth * wPaddingAll,
                    child: SizedBox(
                      child: Row(
                          children: List.generate(
                              introList.length, (index) => _buildDot(index))),
                    ),
                  ),
                  Positioned(
                    right: mainWidth * wPaddingAll * 1.5,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isButtonPress = true;
                          });
                          if (currentPage == introList.length - 1) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomeView()));
                          } else {
                            _controller.nextPage(
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut);
                          }
                        },
                        child: Container(
                          width: mainWidth * 0.1,
                          height: mainWidth * 0.1,
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.5),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                    offset: const Offset(1, 1),
                                    blurRadius: 5,
                                    spreadRadius: 3,
                                    color: Colors.grey.withOpacity(0.5))
                              ]),
                          child: Icon(
                            currentPage == introList.length - 1
                                ? Icons.done
                                : Icons.arrow_forward_ios,
                            color: Colors.white,
                            size: mainWidth * wPaddingAll * 1.3,
                          ),
                        )),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _buildDot(int index) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      child: Container(
        width: currentPage == index
            ? mainWidth * wPaddingAll * 1.5
            : mainWidth * 0.01,
        height: mainWidth * 0.010,
        padding: EdgeInsets.symmetric(horizontal: mainWidth * wPaddingAll),
        margin: EdgeInsets.symmetric(horizontal: mainWidth * wPaddingAll * 0.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mainWidth * 0.01),
          color: currentPage == index
              ? ClsSTColor.getColor(color: STColor.white)
              : Colors.white,
        ),
      ),
    );
  }
}
