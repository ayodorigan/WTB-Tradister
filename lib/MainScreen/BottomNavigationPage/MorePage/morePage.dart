import 'dart:convert';

import 'package:chatapp_new/API/api.dart';
import 'package:chatapp_new/Cards/MoreOptionsCard/moreCard.dart';
import 'package:chatapp_new/Cards/ProfileCard/profileCard.dart';
import 'package:chatapp_new/Forms/CreateShopForm/createShopForm.dart';
import 'package:chatapp_new/MainScreen/BusinessInfoPage/businessInfoPage.dart';
import 'package:chatapp_new/MainScreen/CreateShop_Page/create_shopPage.dart';
import 'package:chatapp_new/MainScreen/GroupPage/groupPage.dart';
import 'package:chatapp_new/MainScreen/LearnMorePage/LearnMorePage.dart';
import 'package:chatapp_new/MainScreen/LoginPage/loginPage.dart';
import 'package:chatapp_new/MainScreen/ProfileEditBasicPage/profileEditBasicPage.dart';
import 'package:chatapp_new/MainScreen/ProfileEditInterestPage/profileEditInterestPage.dart';
import 'package:chatapp_new/MainScreen/SettingsPage/settingsPage.dart';
import 'package:chatapp_new/MainScreen/ShopPage/shopPage.dart';
import 'package:chatapp_new/Preview/PreviewClass.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  var userData;
  bool _isLoaded = false;
  bool _isVerified = false;
  TextEditingController utubeController = TextEditingController();
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;
  int imgNum = 0;
  int count = 0;
  String _sound = "";
  String url;
  var data;

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    print("object_deactivate");
    // _ucontroller.pause();
    super.deactivate();
  }

  @override
  void initState() {
    //_getUserInfo();
    // utubeController = TextEditingController();
    // _videoMetaData = YoutubeMetaData();
    // _playerState = PlayerState.unknown;
    // _ucontroller = YoutubePlayerController(
    //   initialVideoId: '',
    //   flags: YoutubePlayerFlags(

    //     mute: false,
    //     autoPlay: false,
    //     disableDragSeek: false,
    //     loop: false,
    //     isLive: false,
    //     forceHideAnnotation: true,
    //   ),
    // )..addListener(listener);
    showUser();
    super.initState();
  }

//   void utube(String link) {
//     String utubelink = getIdFromUrl(link);
//     // print("test link");
//     // print(utubelink);
//     _ucontroller = YoutubePlayerController(
//       initialVideoId: utubelink,
//       flags: YoutubePlayerFlags(
//         mute: false,
//         autoPlay: false,
//         disableDragSeek: false,
//         loop: false,
//         isLive: false,
//         forceHideAnnotation: true,
//       ),
//     )..addListener(listener);
//   }

// //////////////
//   void listener() {
//     if (_isPlayerReady && mounted && !_ucontroller.value.isFullScreen) {
//       setState(() {
//         _playerState = _ucontroller.value.playerState;

//         _videoMetaData = _ucontroller.metadata;
//       });
//     }
//   }
// ///////////////////

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
      //_isLoaded = true;
    });

    //print("${userData['shop_id']}");
  }

  Future showUser() async {
    //await Future.delayed(Duration(seconds: 3));
    var postresponse = await CallApi().getData2('initData');
    var postcontent = postresponse.body;
    final body = json.decode(postcontent);
    print(body['user']);
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.setString('user', json.encode(body['user']));

    seeUser();
  }

  seeUser() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
      if (userData['isUserVerified'] == "Yes" &&
          userData['isBusinessInfoProvided'] == "Yes") {
        _isVerified = true;
      }
    });
  }

  Container profileContainer(Icon icon, String text) {
    return Container(
      padding: EdgeInsets.only(top: 13, bottom: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        //border: Border.all(width: 0.8, color: Colors.grey[300]),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Colors.grey[300],
            //offset: Offset(3.0, 4.0),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            //color: Colors.red,
            margin: EdgeInsets.only(left: 20, right: 20, top: 0),
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(right: 10), child: icon),
                Container(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.chevron_right,
                color: Colors.black45,
                size: 22,
              )),
        ],
      ),
    );
  }

  Container emailContainer(Icon icon, String text) {
    return Container(
      padding: EdgeInsets.only(top: 13, bottom: 13),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        //border: Border.all(width: 0.8, color: Colors.grey[300]),
        boxShadow: [
          BoxShadow(
            blurRadius: 5.0,
            color: Colors.grey[300],
            //offset: Offset(3.0, 4.0),
          ),
        ],
      ),
      margin: EdgeInsets.only(top: 2.5, bottom: 2.5, left: 0, right: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            //color: Colors.red,
            margin: EdgeInsets.only(left: 20, right: 20, top: 0),
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(margin: EdgeInsets.only(right: 10), child: icon),
                Container(
                  child: Text(
                    text,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontFamily: 'Oswald',
                        fontWeight: FontWeight.w300),
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _showMsg("Coming Soon");
            },
            child: Container(
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.only(right: 15),
                decoration: BoxDecoration(
                  color: header,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5.0,
                      color: Colors.grey[300],
                      //offset: Offset(3.0, 4.0),
                    ),
                  ],
                ),
                child: Text(
                  "Click to change email",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w300),
                )),
          ),
        ],
      ),
    );
  }

  _showMsg(msg) {
    //
    final snackBar = SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Close',
        onPressed: () {
          // Some code to undo the change!
        },
      ),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: userData == null
          ? Center(child: CircularProgressIndicator())
          : CustomScrollView(slivers: <Widget>[
              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ////// <<<<< Profile Card >>>>> //////
                      ProfileCard(userData),

                      ////// <<<<< Shop Cards >>>>> //////
                      userData['userType'] == "Buyer" ||
                              userData['shop_id'] == 0 ||
                              userData['shop_id'] == null ||
                              userData['shop_id'] == "" ||
                              userData['shop_id'] == "0"
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShopPage(
                                            userData['shop_id'],
                                            userData['id'])));
                                //_showMsg("Coming Soon");
                              },
                              child: profileContainer(
                                  Icon(
                                    Icons.shop,
                                    color: Colors.black45,
                                    size: 20,
                                  ),
                                  "Shop"),
                            ),

                      ////// <<<<< Create Shop Cards >>>>> //////

                      userData['userType'] == "Buyer" ||
                              userData['shop_id'] == 0 ||
                              userData['shop_id'] == null ||
                              userData['shop_id'] == "" ||
                              userData['shop_id'] == "0"
                          ? GestureDetector(
                              onTap: () {
                                // _isVerified == false
                                //     ? _showCompleteDialog()
                                //     : 
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateShopPage()));
                                //_showMsg("Coming Soon");
                              },
                              child: profileContainer(
                                  Icon(
                                    Icons.shop_two,
                                    color: Colors.black45,
                                    size: 20,
                                  ),
                                  "Create Shop"),
                            )
                          : Container(),

                      //// <<<<< Group Cards >>>>> //////
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GroupPage()));
                        },
                        child: profileContainer(
                            Icon(
                              Icons.group,
                              color: Colors.black45,
                              size: 20,
                            ),
                            "Your Community"),
                      ),

                      ////// <<<<< Basic Information Edit Cards >>>>> //////
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileBasisEditPage(userData)));
                          //_showMsg("Coming Soon");
                        },
                        child: profileContainer(
                            Icon(
                              Icons.account_circle,
                              color: Colors.black45,
                              size: 20,
                            ),
                            "Manage Basic Information"),
                      ),

                      ////// <<<<< Interests Edit Cards >>>>> //////
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileInterestEditPage(userData)));
                          //_showMsg("Coming Soon");
                        },
                        child: profileContainer(
                            Icon(
                              Icons.label_important,
                              color: Colors.black45,
                              size: 20,
                            ),
                            "Manage Interests"),
                      ),

                      ////// <<<<< Business Info Edit Cards >>>>> //////
                      userData['userType'] == "Buyer"
                          ? Container()
                          : GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BusinessInfoPage(userData)));
                                //_showMsg("Coming Soon");
                              },
                              child: profileContainer(
                                  Icon(
                                    Icons.business_center,
                                    color: Colors.black45,
                                    size: 20,
                                  ),
                                  "Manage Business Information"),
                            ),

                      ////// <<<<< Settings Cards >>>>> //////
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LearnMorePage()));
                          //_showMsg("Coming Soon");
                        },
                        child: profileContainer(
                            Icon(
                              Icons.more_horiz,
                              color: Colors.black45,
                              size: 20,
                            ),
                            "More"),
                      ),

                      ////// <<<<< Logout Cards >>>>> //////
                      GestureDetector(
                        onTap: () {
                          _showLogoutDialog();
                        },
                        child: profileContainer(
                            Icon(
                              Icons.power_settings_new,
                              color: Colors.black45,
                              size: 20,
                            ),
                            "Logout"),
                      ),

                      // Container(
                      //     alignment: Alignment.center,
                      //     child: Row(
                      //       children: <Widget>[
                      //         Flexible(
                      //           child: TextField(
                      //             controller: utubeController,
                      //             onChanged: (value) {
                      //               setState(() {
                      //                 url = value;
                      //               });
                      //             },
                      //           ),
                      //         ),
                      //         IconButton(
                      //             icon: Icon(Icons.add_box, color: header),
                      //             onPressed: () {
                      //               FetchPreview().fetch(url).then((res) {
                      //                 setState(() {
                      //                   data = res;
                      //                   print(data);
                      //                 });
                      //               });
                      //               // utubeController.text.isEmpty?
                      //               // _showMsg("Add video url"):

                      //               // _addToYoutube();
                      //               //utube(utubeController.text);
                      //             }),
                      //       ],
                      //     )),

                      // data == null
                      //     ? Container()
                      //     : Padding(
                      //         padding: const EdgeInsets.all(16.0),
                      //         child: Container(
                      //           color: Colors.grey[100],
                      //           child: Padding(
                      //             padding: const EdgeInsets.all(8.0),
                      //             child: Row(
                      //               children: <Widget>[
                      //                 Image.network(
                      //                   data['image'],
                      //                   height: 100,
                      //                   width: 100,
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //                 Flexible(
                      //                     child: Padding(
                      //                   padding: const EdgeInsets.all(8.0),
                      //                   child: Column(
                      //                     crossAxisAlignment:
                      //                         CrossAxisAlignment.start,
                      //                     children: <Widget>[
                      //                       Text(
                      //                         data['title'],
                      //                         style: TextStyle(
                      //                             fontWeight: FontWeight.bold,
                      //                             color: Colors.black),
                      //                       ),
                      //                       SizedBox(
                      //                         height: 4,
                      //                       ),
                      //                       Text(
                      //                         data['description'],
                      //                       ),
                      //                       SizedBox(
                      //                         height: 4,
                      //                       ),
                      //                       Row(
                      //                         children: <Widget>[
                      //                           Image.network(
                      //                             data['favIcon'],
                      //                             height: 12,
                      //                             width: 12,
                      //                           ),
                      //                           SizedBox(
                      //                             width: 4,
                      //                           ),
                      //                           Text(url,
                      //                               style: TextStyle(
                      //                                   color: Colors.grey,
                      //                                   fontSize: 12))
                      //                         ],
                      //                       )
                      //                     ],
                      //                   ),
                      //                 )),
                      //               ],
                      //             ),
                      //           ),
                      //         ),
                      //       ),

                      // YoutubePlayer(
                      //   controller: _ucontroller,
                      //   showVideoProgressIndicator: false,
                      //   //progressIndicatorColor: Colors.blueAccent,
                      //   topActions: <Widget>[
                      //     SizedBox(width: 8.0),
                      //   ],
                      //   onReady: () {
                      //     // print("dfsifugsdf");
                      //     if (_sound == "") {
                      //       setState(() {
                      //         _isPlayerReady = true;
                      //       });
                      //     } else if (_sound == "no") {
                      //       setState(() {
                      //         _isPlayerReady = false;
                      //         print("no sound for paly");
                      //       });
                      //     }

                      //     // print(_isPlayerReady);
                      //   },
                      // )
                    ],
                  ),
                ),
              )
            ]),
    );
  }

  Future<Null> _showLogoutDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 0),
                        child: Text(
                          "Do you want to logout?",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.w400),
                        )),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    left: 0, right: 5, top: 20, bottom: 0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color: Colors.grey, width: 0.2),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: Text(
                                  "No",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 17,
                                    fontFamily: 'BebasNeue',
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                        Expanded(
                          child: GestureDetector(
                            onTap: logout,
                            child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    left: 5, right: 0, top: 20, bottom: 0),
                                decoration: BoxDecoration(
                                    color: header,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: Text(
                                  "Yes",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'BebasNeue',
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future logout() async {
    Navigator.of(context).pop();
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    localStorage.remove('token');
    localStorage.remove('user');
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
    page1 = 0;
    page2 = 0;
    page3 = 0;
    page4 = 0;
  }

  Future<Null> _showCompleteDialog() async {
    return showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        margin: EdgeInsets.only(top: 12),
                        child: Text(
                          "Please verify your profile first",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black54,
                              fontSize: 14,
                              fontFamily: 'Oswald',
                              fontWeight: FontWeight.w400),
                        )),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Container(
                                padding: EdgeInsets.all(10),
                                margin: EdgeInsets.only(
                                    left: 0, right: 0, top: 20, bottom: 0),
                                decoration: BoxDecoration(
                                    color: header,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'BebasNeue',
                                  ),
                                  textAlign: TextAlign.center,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
