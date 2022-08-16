package com.ttxs.qy_player;

import android.app.Application;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** QyPlayerPlugin */
public class QYPlayerPlugin implements FlutterPlugin {

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
    binding
            .getPlatformViewRegistry()
            .registerViewFactory("qy_player/videoView", new QYPlatformViewFactory(
                    binding.getBinaryMessenger(), (Application)binding.getApplicationContext()));
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {}

}
