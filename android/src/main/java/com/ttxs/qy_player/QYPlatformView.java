package com.ttxs.qy_player;

import android.app.Application;
import android.content.Context;
import android.view.View;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.wholeally.qysdk.QyPlayer;
import com.wholeally.qysdk.QySession;
import com.wholeally.qysdk.event.QyPlayerEvent;
import com.wholeally.qysdk.implement.QyPlayerImplement;
import com.wholeally.qysdk.implement.QySessionImplement;
import com.wholeally.yuv.GLFrameRenderer;
import com.wholeally.yuv.GLFrameSurface;

import java.util.Map;

import io.flutter.Log;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;

public class QYPlatformView implements PlatformView, MethodChannel.MethodCallHandler {
    @NonNull
    private final BinaryMessenger messenger;
    private static final String CHANNEL = "qy_player";
    private static final String PLUGIN_TAG = "QYPlugin";
    private Application application;
    private GLFrameSurface surfaceView;
    private GLFrameRenderer glFrameRenderer;
    private QySession session;
    private QyPlayer player;
    private QyPlayer talker;
    BasicMessageChannel<Object> messageChannel;

    public QYPlatformView(@NonNull Context context, int id, @Nullable Map<String, Object> creationParams, BinaryMessenger messenger, Application application) {
        this.messenger = messenger;
//        this.context = context;
        this.application = application;
        new MethodChannel(messenger, CHANNEL).setMethodCallHandler(this);
        messageChannel = new BasicMessageChannel<>(messenger, "qy_player/message", new StandardMessageCodec());


        surfaceView = new GLFrameSurface(context);
        surfaceView.setEGLContextClientVersion(2);
        glFrameRenderer = new GLFrameRenderer(surfaceView, context);
        surfaceView.setRenderer(glFrameRenderer);

        session = new QySessionImplement(application);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
         if (call.method.equals("preview")) {
            /// 通过URL预览
            String viewUrl = call.argument("viewUrl");
            previewWithUrl(viewUrl);
        } else if (call.method.equals("stop_preview")) {
             if (player != null) {
                 player.Close();
                 player = null;
             }
            result.success("success");
        } else if (call.method.equals("talk")) {
            /// 通过URL预览
            String viewUrl = call.argument("viewUrl");
            talkWithUrl(viewUrl);
        } else if (call.method.equals("stop_talk")) {

             if (talker != null) {
                 talker.Talk(false);
                 talker.Close();
                 talker = null;
             }
            result.success("success");
        } else if (call.method.equals("ctrolSound")) {
            Boolean soud = call.argument("isOpen");
            if (soud) {
                player.CtrlAudio(true);
            } else {
                player.CtrlAudio(false);
            }
            result.success("success");
        } else {
            result.notImplemented();
        }
    }



    public void previewWithUrl(String viewUrl) {
        Log.d(PLUGIN_TAG,"开始预览 :" + viewUrl);
        player = new QyPlayerImplement(application);
        player.SetCanvas(glFrameRenderer);
        player.SetPlayerEvent(new QyPlayerEvent() {
            @Override
            public void onVideoDataCallBack(int videoType, int iframe, long timeStamp,
                                            final byte[] data, int dataLength) {
                System.out.println("===wholeally_111_onVideoDataCallBack_iframe=======:"+iframe
                        +";=timeStamp=:"+timeStamp+";=videoType=:"+videoType);
            }
            @Override
            public void onYuvDataCallBack(int iframe, long timeStamp, byte[] data, int
                    dataLength, int width, int height) {
                System.out.println("===wholeally_111_onYuvDataCallBack===:"+width+
                        ";=height=:"+height);
//                                                Log.e(TAG_PLAYER, "_____Yuv数据____:" + iframe + ";;" + timeStamp + ";;" +
//                                                        "" + data + ";;" + dataLength + ";;" + width + ";;" + height);
            }
            @Override
            public void onAudioDataCallBack(int type, int audiotype, int smaple, int
                    chn, int bit, byte[] data, int dataLength) {
                Log.e(PLUGIN_TAG, "_____Audio数据____:" + type + ";;" + audiotype + ";;" +
                        "" + smaple + ";;" + chn + ";;" + bit + ";;" + data + ";;" +
                        dataLength);
            }
            @Override
            public void onDisConnect() {
//                                                Log.e(TAG_PLAYER, "_____断开通知____");
            }
        });
        player.Connect(viewUrl, new QyPlayer
                .OnCommonCallBack() {
            @Override
            public void on(int ret) {
                if (ret == 0) {
                    Log.d(PLUGIN_TAG,  "预览成功");
                } else {
                    Log.d(PLUGIN_TAG,  "预览失败:" );
                }
            }
        });
    }

    public void talkWithUrl(String viewUrl) {
        Log.d(PLUGIN_TAG,"开始对讲 :" + viewUrl);
        talker = new QyPlayerImplement(application);
        talker.SetCanvas(glFrameRenderer);
        talker.SetPlayerEvent(new QyPlayerEvent() {
            @Override
            public void onVideoDataCallBack(int videoType, int iframe, long timeStamp,
                                            final byte[] data, int dataLength) {
                System.out.println("===wholeally_111_onVideoDataCallBack_iframe=======:"+iframe
                        +";=timeStamp=:"+timeStamp+";=videoType=:"+videoType);
            }
            @Override
            public void onYuvDataCallBack(int iframe, long timeStamp, byte[] data, int
                    dataLength, int width, int height) {
                System.out.println("===wholeally_111_onYuvDataCallBack===:"+width+
                        ";=height=:"+height);
//                                                Log.e(TAG_PLAYER, "_____Yuv数据____:" + iframe + ";;" + timeStamp + ";;" +
//                                                        "" + data + ";;" + dataLength + ";;" + width + ";;" + height);
            }
            @Override
            public void onAudioDataCallBack(int type, int audiotype, int smaple, int
                    chn, int bit, byte[] data, int dataLength) {
                Log.e(PLUGIN_TAG, "_____Audio数据____:" + type + ";;" + audiotype + ";;" +
                        "" + smaple + ";;" + chn + ";;" + bit + ";;" + data + ";;" +
                        dataLength);
            }
            @Override
            public void onDisConnect() {
//                                                Log.e(TAG_PLAYER, "_____断开通知____");
            }
        });
        talker.Connect(viewUrl, new QyPlayer
                .OnCommonCallBack() {
            @Override
            public void on(int ret) {
                if (ret == 0) {
                    talker.Talk(true);
                    Log.d(PLUGIN_TAG,  "预览成功");
                } else {
                    Log.d(PLUGIN_TAG,  "预览失败:" );
                }
            }
        });
    }


    @Override
    public View getView() {
        return surfaceView;
    }

    @Override
    public void dispose() {
        if (null != player) {
            player.Close();
        }
        if (null != talker) {
            talker.Close();
        }
    }
}
