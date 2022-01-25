import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:song_tea_app/helper/st_color.dart';
import 'package:song_tea_app/helper/st_text.dart';
import 'package:song_tea_app/helper/st_textformfield.dart';
import 'package:song_tea_app/helper/st_variable.dart';
import 'package:song_tea_app/models/banner.dart';
import 'package:song_tea_app/models/category.dart';
import 'package:song_tea_app/models/product.dart';
import 'package:song_tea_app/pages/cart_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);
  late Timer _timer;
  late bool isAdd;
  String address = '';
  late Position position;
  late List<Product> cartList;
  int badge = 0;

  List<STBanner> bannerList = [
    STBanner(1, 'Test', 'images/intro1.jpg'),
    STBanner(1, 'Test', 'images/intro2.jpg'),
    STBanner(1, 'Test', 'images/intro3.jpg'),
    STBanner(1, 'Test', 'images/intro4.jpg'),
  ];
  List<Product> productList = [
    Product(
        category: Category(id: 1, categoryName: 'Fruit Tea'),
        id: 1,
        productName: 'Grap Tea',
        image: 'images/grap_tea.jpg',
        cartImage: 'images/tea1.png',
        price: 2.9,
        discount: 25),
    Product(
        category: Category(id: 1, categoryName: 'Fruit Tea'),
        id: 1,
        productName: 'Grap Tea',
        cartImage: 'images/tea2.png',
        price: 3.19,
        image: 'images/grap_tea.jpg'),
    Product(
        category: Category(id: 1, categoryName: 'Fruit Tea'),
        id: 1,
        productName: 'Grap Tea',
        price: 2.8,
        cartImage: 'images/tea3.png',
        image: 'images/grap_tea.jpg'),
    Product(
        category: Category(id: 1, categoryName: 'Fruit Tea'),
        id: 1,
        productName: 'Grap Tea',
        image: 'images/grap_tea.jpg',
        cartImage: 'images/tea1.png',
        price: 3.2,
        discount: 50),
  ];
  _setTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      if (currentPage == bannerList.length - 1) {
        _pageController.animateTo(0,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      } else {
        _pageController.animateToPage(currentPage + 1,
            duration: const Duration(milliseconds: 300), curve: Curves.linear);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _setTimer();
    _getLocation();

    cartList = <Product>[];
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
    _pageController.dispose();
  }

  Future<String> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    getAddressFromLatLong(pos);
    setState(() {});
    return address;
  }

  Future<void> getAddressFromLatLong(Position pos) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);
    print(placemark);
    Placemark place = placemark[0];
    address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.country}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    mainWidth = MediaQuery.of(context).size.width;
    mainHeight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            children: [
              SizedBox(
                height: mainWidth * wPaddingAll,
              ),
              Container(
                height: mainWidth * 0.30,
                margin:
                    EdgeInsets.symmetric(horizontal: mainWidth * wPaddingAll),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const ImageIcon(AssetImage('images/menu.png'))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(Icons.location_on_outlined),
                        SizedBox(
                          width: mainWidth * wPaddingAll,
                        ),
                        SizedBox(
                          width: mainWidth * 0.5,
                          child: STText(
                            text: address,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: mainWidth * 0.1,
                      height: mainWidth * 0.1,
                      child: Stack(
                        children: [
                          Positioned(
                            child: Container(
                              width: mainWidth * wPaddingAll * 2.5,
                              height: mainWidth * wPaddingAll * 2.5,
                              decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(
                                      mainWidth * wPaddingAll)),
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CartView(product: cartList)));
                                  },
                                  icon: Icon(
                                    Icons.shopping_cart_outlined,
                                    size: mainWidth * wPaddingAll * 1.4,
                                  )),
                            ),
                          ),
                          badge == 0
                              ? Container()
                              : Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: mainWidth * wPaddingAll,
                                    height: mainWidth * wPaddingAll,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(
                                            mainWidth * wPaddingAll)),
                                    child: STText(
                                      text: badge.toString(),
                                      fontWeight: FontWeight.bold,
                                      fontSize: STFontSize.smallPx,
                                      stColor: STColor.white,
                                    ),
                                  ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: mainWidth,
                height: mainWidth * 0.2,
                // color: ClsSTColor.getColor(color: STColor.white),
                child: Stack(
                  children: [
                    // Positioned(
                    //     top: 0,
                    //     left: mainWidth * 0.3,
                    //     width: mainWidth * 0.3,
                    //     height: mainWidth * 0.3,
                    //     child: Image.asset('images/logo.jpeg')),
                    Positioned(
                      top: 0,
                      left: mainWidth * wPaddingAll,
                      child: Container(
                          // alignment: Alignment.centerLeft,
                          width: mainWidth * 0.92,
                          height: mainWidth * wPaddingAll * 3,
                          // margin: EdgeInsets.symmetric(
                          //     horizontal: mainWidth * wPaddingAll),
                          // margin: EdgeInsets.only(
                          //     left: mainWidth * wPaddingAll,
                          //     right: mainWidth * wPaddingAll),
                          padding: EdgeInsets.only(bottom: mainWidth * 0.01),
                          decoration: BoxDecoration(
                            color: ClsSTColor.getColor(color: STColor.grey)
                                .withOpacity(0.3),
                            borderRadius:
                                BorderRadius.circular(mainWidth * wPaddingAll),
                          ),
                          child: STTextFormField(
                            isShowBorder: false,
                            textAlign: TextAlign.left,
                            labelDesc: 'Search for your favorite drinks',
                            fontWeight: FontWeight.w400,
                            fontSize: STFontSize.small,
                            onChange: (value) {},
                            isSearch: true,
                          )),
                    ),
                    // Positioned(
                    //     top: 0,
                    //     right: mainWidth * 0.02,
                    //     child: Container(
                    //       height: mainWidth * wPaddingAll * 3,
                    //       width: mainWidth * wPaddingAll * 3,
                    //       decoration: BoxDecoration(
                    //           color: ClsSTColor.getColor(color: STColor.grey)
                    //               .withOpacity(0.5),
                    //           borderRadius:
                    //               BorderRadius.circular(mainWidth * wPaddingAll)),
                    //       child: IconButton(
                    //         onPressed: () {},
                    //         icon:
                    //             const ImageIcon(AssetImage('images/search.png')),
                    //         iconSize: mainWidth * 0.04,
                    //       ),
                    //     )),
                  ],
                ),
              ),
              SizedBox(
                width: mainWidth,
                height: mainWidth * 0.35,
                child: Stack(
                  children: [
                    Positioned(
                        child: Container(
                      width: mainWidth,
                      height: mainHeight * 0.15,
                      margin: EdgeInsets.symmetric(
                          horizontal: mainWidth * wPaddingAll),
                      child: PageView.builder(
                          itemCount: bannerList.length,
                          controller: _pageController,
                          onPageChanged: (value) {
                            setState(() {
                              currentPage = value;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          mainWidth * wPaddingAll),
                                      image: DecorationImage(
                                          image: AssetImage(
                                              bannerList[index].image),
                                          fit: BoxFit.fitWidth)),
                                )
                              ],
                            );
                          }),
                    )),
                    Positioned(
                        top: mainWidth * avatarSizeBig * 2.6,
                        left: mainWidth * 0.40,
                        child: Row(
                          children: List.generate(
                              bannerList.length, (index) => _buildDot(index)),
                        ))
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(mainWidth * wPaddingAll),
                width: mainWidth,
                height: mainWidth * 0.1,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    STText(
                      text: 'Exclusive Offer',
                      fontFamily: STFontFamily.poppin,
                      fontWeight: FontWeight.bold,
                      fontSize: STFontSize.small,
                    ),
                    STText(
                      text: 'See all',
                      fontWeight: FontWeight.bold,
                      stColor: STColor.appBarColor,
                    )
                  ],
                ),
              ),
              Container(
                width: mainWidth,
                height: mainWidth * 0.6,
                margin:
                    EdgeInsets.symmetric(horizontal: mainWidth * wPaddingAll),
                child: ListView.builder(
                    itemCount: productList.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        width: mainWidth * 0.4,
                        margin: EdgeInsets.only(right: mainWidth * wPaddingAll),
                        child: Card(
                          elevation: 1,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  mainWidth * wPaddingAll)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: mainWidth * 0.30,
                                width: mainWidth * 0.4,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            mainWidth * wPaddingAll),
                                        topRight: Radius.circular(
                                            mainWidth * wPaddingAll)),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            productList[index].image),
                                        fit: BoxFit.fill)),
                                child: Stack(
                                  children: [
                                    productList[index].discount == 0
                                        ? Container()
                                        : Positioned(
                                            right: 0,
                                            top: mainWidth * wPaddingAll,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: mainWidth *
                                                      wPaddingAll *
                                                      1.8,
                                                  vertical: mainWidth * 0.03),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(
                                                          mainWidth *
                                                              wPaddingAll),
                                                      bottomLeft:
                                                          Radius.circular(
                                                              mainWidth *
                                                                  wPaddingAll)),
                                                  color: ClsSTColor.getColor(
                                                          color:
                                                              STColor.stawberry)
                                                      .withOpacity(0.8)),
                                              child: STText(
                                                  text:
                                                      '${productList[index].discount}%'),
                                            ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: mainWidth * wPaddingAll,
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: mainWidth * wPaddingAll),
                                child: STText(
                                  text: productList[index].productName,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: mainWidth * wPaddingAll),
                                child: STText(
                                  text:
                                      productList[index].category.categoryName,
                                  stColor: STColor.grey,
                                  fontFamily: STFontFamily.poppin,
                                  fontSize: STFontSize.smaller,
                                ),
                              ),
                              SizedBox(
                                height: mainWidth * wPaddingAll,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  STText(
                                    text: '\$${productList[index].price}',
                                    fontWeight: FontWeight.bold,
                                    fontSize: STFontSize.medium,
                                  ),
                                  SizedBox(
                                    width: mainWidth * wPaddingAll,
                                  ),
                                  Container(
                                    width: mainWidth * wPaddingAll * 2.5,
                                    height: mainHeight * wPaddingAll * 1.2,
                                    decoration: BoxDecoration(
                                        color: ClsSTColor.getColor(
                                            color: STColor.appBarColor),
                                        borderRadius: BorderRadius.circular(
                                            mainWidth * wPaddingAll)),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          cartList.add(productList[index]);
                                          badge += 1;
                                        });
                                      },
                                      icon: const Icon(Icons.add),
                                      color: Colors.white,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        ),
        bottomNavigationBar: cartList.isNotEmpty
            ? Container(
                width: mainWidth,
                height: mainHeight * 0.1,
                color: ClsSTColor.getColor(color: STColor.appBarColor),
                child: Row(
                  children: [
                    SizedBox(
                      width: mainWidth * 0.75,
                      height: mainHeight * 0.1,
                      child: ListView.builder(
                          itemCount: cartList.length,
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.symmetric(
                              horizontal: mainWidth * 0.025),
                          itemBuilder: (context, index) {
                            return Container(
                              width: mainWidth * avatarSizeBig * 1.5,
                              height: mainHeight * 0.1,
                              margin: EdgeInsets.symmetric(
                                  horizontal: mainWidth * 0.02),
                              child: Stack(
                                children: [
                                  Positioned(
                                    // width: mainWidth * avatarSizeBig * 0.8,
                                    // height: mainWidth * avatarSizeBig * 1.2,
                                    top: 10,
                                    left: 5,
                                    child: Container(
                                      width: mainWidth * avatarSizeBig * 1.2,
                                      height: mainWidth * avatarSizeBig * 1.7,
                                      padding: EdgeInsets.all(mainWidth * 0.02),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            mainWidth * 0.03),
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.2)),
                                      ),
                                      child: Image.asset(
                                        cartList[index].cartImage,
                                        width: mainWidth * avatarSizeBig * 0.9,
                                        height: mainWidth * 1.5,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                      top: 2,
                                      right: 0,
                                      child: Container(
                                        width: mainWidth * wPaddingAll * 1.3,
                                        height: mainWidth * wPaddingAll * 1.3,
                                        // alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                            color:
                                                Colors.white.withOpacity(0.2),
                                            borderRadius: BorderRadius.circular(
                                                mainWidth * wPaddingAll)),
                                        child: Stack(
                                          children: [
                                            Positioned(
                                              top: -13,
                                              left: -13,
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      badge -= 1;
                                                      cartList.removeAt(index);
                                                    });
                                                  },
                                                  icon: Icon(
                                                    Icons.remove,
                                                    size: mainWidth *
                                                        wPaddingAll *
                                                        0.9,
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            );
                          }),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    CartView(product: cartList)));
                      },
                      child: Container(
                        padding: EdgeInsets.all(mainWidth * wPaddingAll * 0.8),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                                mainWidth * wPaddingAll * 1.5)),
                        child: const STText(
                          text: 'View Cart',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
              )
            : null);
  }

  _buildDot(int index) {
    return AnimatedContainer(
      duration: kThemeAnimationDuration,
      child: Container(
        width: currentPage == index
            ? mainWidth * wPaddingAll * 1.2
            : mainWidth * 0.01,
        height: mainWidth * 0.010,
        padding: EdgeInsets.symmetric(horizontal: mainWidth * wPaddingAll),
        margin: EdgeInsets.symmetric(horizontal: mainWidth * wPaddingAll * 0.1),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(mainWidth * 0.01),
          color: currentPage == index
              ? ClsSTColor.getColor(color: STColor.stawberry)
              : Colors.grey,
        ),
      ),
    );
  }
}
