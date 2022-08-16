import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QYPlayer {
  static const MethodChannel _channel = MethodChannel('qy_player');
  static const _pluginChannel = MethodChannel("qy_player/plugin");

  static const BasicMessageChannel<dynamic> _messageChannel =
      BasicMessageChannel("qy_player/message", StandardMessageCodec());
  static final Map<int, Function> _callBackFuncMap = {};

  static void initMessageHandler() {
    _messageChannel.setMessageHandler((message) {
      Map<String, dynamic> data = json.decode(message);
      return message;
    });
  }

//  *  @param appKey 账号appKey
  static Future<String> initSdk() async {
    QYPlayer.initMessageHandler();
    String version = await _pluginChannel.invokeMethod("init_sdk");
    return version;
  }

  /// SDK Session登录
  static Future<bool> sessionLogin({
    required String ip,
    required int port,
    required String account,
    required String pwd,
  }) async {
    await _channel.invokeMethod("session_login", {
      'ip': ip,
      'port': port,
      'account': account,
      'pwd': pwd,
    });
    return true;
  }

  /// 播放
  static Future<void> startPlay(
      {required String channelId, String? viewContext}) async {
    Map<String, dynamic> params = {
      'channelId': channelId,
    };
    if (viewContext != null) params['viewContext'] = viewContext;
    await _channel.invokeMethod(
        "start_play", {'channelId': channelId, 'viewContext': viewContext});
    return;
  }

  /// 停止
  static Future<void> stopPlay() async {
    await _channel.invokeMethod("stop_play");
    return;
  }

  static Future<void> dispose() async {
    await _channel.invokeMethod("dispose");
    return;
  }

  /// 控制声音
  ///
  /// isOpen：true开启/false关闭
  static Future<void> ctrolSound({required bool isOpen}) async {
    await _channel.invokeMethod("ctrolSound", {'isOpen': isOpen});
    return;
  }

  /// 开启对讲
  ///
  /// isPlay：true播放/false暂停
  static Future<bool> openTalk({required bool isTalk}) async {
    String? result =
        await _channel.invokeMethod("openTalk", {'isTalk': isTalk});
    debugPrint("控制播放: $result");
    return Future.value(result == null);
  }

  /// 控制对讲
  ///
  /// isOpen：true开启/false关闭
  static Future<void> ctrolTalk({required bool isOpen}) async {
    await _channel.invokeMethod("ctrolTalk", {'isOpen': isOpen});
    return;
  }

  /// 销毁Sdk
  static Future<void> destroySdk() async {
    await _channel.invokeMethod("destroy_sdk");
    return;
  }

  /// 通过Url预览
  static Future<void> previewWithUrl({required String viewUrl}) async {
    await _channel.invokeMethod("preview", {'viewUrl': viewUrl});
    return;
  }

  /// 结束预览
  static Future<void> stopPreview() async {
    await _channel.invokeMethod("stop_preview");
    return;
  }

  /// 通过Url预览
  static Future<void> talkWithUrl({required String viewUrl}) async {
    await _channel.invokeMethod("talk", {'viewUrl': viewUrl});
    return;
  }

  /// 结束预览
  static Future<void> stopTalk() async {
    await _channel.invokeMethod("stop_talk");
    return;
  }
}
