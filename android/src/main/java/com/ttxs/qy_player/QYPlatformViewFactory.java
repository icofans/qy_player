package com.ttxs.qy_player;



import android.app.Application;
import android.content.Context;

import androidx.annotation.NonNull;

import com.wholeally.qysdk.QYSDK;

import org.jetbrains.annotations.NotNull;

import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;

public class QYPlatformViewFactory extends PlatformViewFactory implements MethodChannel.MethodCallHandler {
    @NonNull private final BinaryMessenger messenger;
    private Application application;

    public QYPlatformViewFactory(@NonNull BinaryMessenger messenger,Application application) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.application = application;
        new MethodChannel(messenger, "qy_player/plugin").setMethodCallHandler(this);
    }

    @Override
    public PlatformView create(Context context, int id, Object args) {
        final Map<String, Object> creationParams = (Map<String, Object>) args;
        return new QYPlatformView(context, id, creationParams,this.messenger, this.application);
    }

    @Override
    public void onMethodCall(@NotNull MethodCall call, @NotNull MethodChannel.Result result) {
        if (call.method.equals("init_sdk")) {
            String version = QYSDK.getInstance().getVersion();
            Log.d("QYPlugin","初始化SDK :" + version);
            result.success(version);
        }  else if (call.method.equals("destroy_sdk")) {
            Log.d("QYPlugin","销毁SDK");
            result.success(true);
        } else {
            result.notImplemented();
        }
    }
}
