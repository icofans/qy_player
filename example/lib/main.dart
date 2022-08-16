// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:qy_player/qy_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class RequestError {
  int? code;
  String msg;

  RequestError(this.code, this.msg);
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final _qyPlayerPlugin = QYPlayer();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    // try {
    //   platformVersion = await _qyPlayerPlugin.getPlatformVersion() ??
    //       'Unknown platform version';
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      // _platformVersion = platformVersion;
    });
  }

  Dio tokenDio = Dio();

  /// 获取直播URL
  Future<String> getLiveUrl({
    String? channelId,
    String? channelNo,
  }) async {
    Completer<String> completer = Completer<String>();
    tokenDio.options.baseUrl = "https://xxx.xxx.xxx.xxx:8080/webapi";
    var params = {
      // "user": "admin",
      // "password": "xxx",
      // "force": 0,
      // "login_mode": 0
    };

    try {
      var response = await tokenDio.post(
        "/login",
        data: params,
      );
      int ret = response.data["ret"];
      if (ret == 0) {
        String sessionId = response.data["session_id"];
        var res = await tokenDio.post("/v4/preview/view", data: {
          "chan_serial": "$channelId:$channelNo",
          "type": 1
        }, queryParameters: {
          "tk": sessionId,
        });
        int code = res.data["ret"];
        if (code == 0) {
          String viewContext = res.data["view_context"];
          completer.complete(viewContext);
        } else {
          completer.completeError(RequestError(0, "获取Url失败"));
        }
      } else {
        completer.completeError(RequestError(0, "获取Token失败"));
      }
    } catch (e) {
      completer.completeError(RequestError(0, "获取Url失败"));
    }
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: [
            const SizedBox(height: 100),
            Text('Running on: $_platformVersion\n'),
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.green,
              child: const QYVideoView(),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    QYPlayer.initSdk();
                  },
                  child: const Text("初始化SDK"),
                ),
                const SizedBox(width: 16),
                // ElevatedButton(
                //   onPressed: () {
                //     QYPlayer.sessionLogin(
                //       ip: "36.137.178.70",
                //       port: 39200,
                //       account: "ttxs",
                //       pwd: "Ttxs@96333",
                //     );
                //   },
                //   child: Text("Session登录"),
                // ),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      String url = await getLiveUrl(
                          channelId: "A11920910J", channelNo: "1");
                      print("直播Url地址为: $url");
                      QYPlayer.initSdk();
                      QYPlayer.previewWithUrl(viewUrl: url);
                    } catch (e) {
                      String errMsg = "";
                      if (e is RequestError) {
                        errMsg = e.msg;
                      } else {
                        errMsg = "未知错误";
                      }
                      print("errMsg = $errMsg");
                    }
                    // QYPlayer.startPlay(channelId: "A11920910J:1");
                  },
                  child: const Text("开始预览"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    QYPlayer.stopPreview();
                  },
                  child: const Text("停止预览"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    QYPlayer.ctrolSound(isOpen: true);
                  },
                  child: const Text("开启声音"),
                ),
                ElevatedButton(
                  onPressed: () async {
                    QYPlayer.ctrolSound(isOpen: false);
                  },
                  child: const Text("关闭声音"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
