import 'package:flutter/material.dart';
import '../model/asset.dart';
import 'dart:async';
import 'dart:io';
import 'asset_card.dart';
import 'package:dio/dio.dart';
import '../common/base_scaffold.dart';
import 'package:scoped_model/scoped_model.dart';
import '../model/current_user_model.dart';
import '../common/sign_in_page.dart';

BaseOptions options = new BaseOptions(
    baseUrl: "http://47.219.174.153:8085/api/v1",
    connectTimeout: 5000,
    receiveTimeout: 3000,
    headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImQ1M2U1YmFhYjQ2MDJmNTJjNDEyNjJkZGFlZWU1YTk2YTk4OTMwNGFjYTczMGE4MjZkZmI2ZDcyYjdhYzA1YTgxM2I2YzA5MzA1NDIxZDQyIn0.eyJhdWQiOiIzIiwianRpIjoiZDUzZTViYWFiNDYwMmY1MmM0MTI2MmRkYWVlZTVhOTZhOTg5MzA0YWNhNzMwYTgyNmRmYjZkNzJiN2FjMDVhODEzYjZjMDkzMDU0MjFkNDIiLCJpYXQiOjE1NDkzMjc0NzcsIm5iZiI6MTU0OTMyNzQ3NywiZXhwIjoxNTgwODYzNDc3LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.cy4j4xQ-p380SHktKJ87Bi3BIWUDxOb1jztb5CFSJgfZfDP7TalT2CRp4X8OP9EF1ZsmxwxiLfnqT0D9ZY639rYkOugQqVJfVQsucxF8DmguT8Xyo7GN9JfyAEvd6w1I47W9nPJkEGQ4mffiqYSiKrpHxBU1wh7Pdhxwd18OQtLTvXHtmYXH_csM928O8xzfGzn9AbkptqAs3i0c_t0JraAfjC7U8jTBZMwGUk8GdiU60VVPC_TXk8pcsdCyj1iVEOx1q8brx2KzdyXD6Jn1P7zfLj76O12az0sck7RYuOs38h4HIRj4QOZ5rRepyPiDS8Y5NdCipwxcW22iq9Ue35LCf1_H15pSuedV5UjO3APCLdXrNkAU5SVwI7sxi0OJsUOUPaePgOwdk8QonxycePKGSkbTBSskwNaUn26wci19rqSSiC1Uo5nq_lPNVl1MeNmtAesPzsDn3dUl4eajJfC8nV_AzJyWzHPevn5lNEBEUezeHDyBQ7lxJ_bLGMZUyIZCUZHp-5NY4MbfglYmW9ORPKswZUyN18PiljAGkjnVq1DOpmDhLzRN4OMWD5UKIH3-lcTbFrEmLJQ2o9YhWrDARY0rSdSoIOLL2l3E2chR9wI09ws9VHqySh9VoS1kkpXGIIFyXfE4e9mYrX5NJsP_152fTJU6ondg0dNek-0',
    });

Dio snipeit = new Dio(options);

class Feed extends StatefulWidget {
  _Feed createState() => new _Feed();
}

class _Feed extends State<Feed> {
  List<AssetCard> feedData;

  @override
  void initState() {
    super.initState();
    this._loadFeed();
  }

  buildFeed() {
    if (feedData != null) {
      return new ListView(
        children: feedData,
      );
    } else {
      return new Container(
          alignment: FractionalOffset.center,
          child: new CircularProgressIndicator());
    }
  }

  final _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final currentUserModel =
        ScopedModel.of<CurrentUserModel>(context, rebuildOnChange: true);
    return
        // (currentUserModel.user == null)
        //     ? const SignInPage()
        //     :
        BaseScaffold(
            // backGroundColor: Colors.grey.shade100,
            // backGroundColor: Colors.grey.shade200,
            // actionFirstIcon: null,
            appTitle: "Product Detail",
            currentEmployee: currentUserModel.employee,
            centerDocked: true,
            floatingIcon: Icons.add,
            alerts: false,
            showFAB: true,
            scaffoldKey: _scaffoldState,
            // callback: () => _addTaskPressed(),
            // showDrawer: false,

            showBottomNav: true,
            // appBar: new AppBar(
            //   title: const Text('Fluttergram',
            //       style: const TextStyle(
            //           fontFamily: "Billabong", color: Colors.black, fontSize: 35.0)),
            //   centerTitle: true,
            // backgroundColor: Colors.white,
            bodyData: ListView(children: <Widget>[
              _getToolbar(context),
              new Column(children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'Asset',
                                style: new TextStyle(
                                    fontSize: 30.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'List',
                                style: new TextStyle(
                                    fontSize: 28.0, color: Colors.grey),
                              )
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Colors.grey,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
              RefreshIndicator(
                  onRefresh: _refresh,
                  child: Padding(
                      padding: EdgeInsets.only(top: 50.0),
                      child: Container(
                          height: 860.0,
                          padding: EdgeInsets.only(bottom: 25.0),
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowGlow();
                            },
                            child: buildFeed(),
                          ))))
            ]));
  }

  Padding _getToolbar(BuildContext context) {
    return new Padding(
      padding: EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
      child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        new Image(
            width: 40.0,
            height: 40.0,
            fit: BoxFit.cover,
            image: new AssetImage('assets/icon.png')),
      ]),
    );
  }

  Future<Null> _refresh() async {
    await _getFeed();
    setState(() {});
    return;
  }

  _loadFeed() async {
    _getFeed();
    // }
  }

  _getFeed() async {
    // var url = 'http://47.219.174.153:8085/hardware';

    var httpClient = new HttpClient();

    List<AssetCard> listOfPosts;
    String result;
    try {
      // var request = await httpClient.getUrl(Uri.parse(url));
      // var response = await request.close();
      // String jsons = await response.transform(utf8.decoder).join();
      var r = await snipeit.get('/hardware');
      if (r.statusCode == HttpStatus.OK) {
        print(r.data['rows']);
        List<Map<String, dynamic>> list = new List();
        for (var item in r.data['rows']) {
          list.add(item);
          print(item);
        }
        listOfPosts = _generateFeed(list);
      } else {
        result = 'Error getting a feed:\nHttp status ${r.statusCode}';
      }
    } catch (exception) {
      result = 'Failed invoking the getFeed function. Exception: $exception';
    }
    print(result);

    setState(() {
      feedData = listOfPosts;
    });
  }

  List<AssetCard> _generateFeed(List<Map<String, dynamic>> feedData) {
    List<AssetCard> listOfPosts = [];
    for (var postData in feedData) {
      print(postData['image']);
      listOfPosts.add(new AssetCard(AssetSerializer().fromMap(postData)));
    }
    return listOfPosts;
  }
}
