package com.zx.flutter_plugin_cal;

import org.liquidplayer.webkit.javascriptcore.JSContext;
import org.liquidplayer.webkit.javascriptcore.JSValue;

import java.util.Map;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterPluginCalPlugin */
public class FlutterPluginCalPlugin implements MethodCallHandler {
  private JSContext jsContext ;
  private FlutterPluginCalPlugin(){
    jsContext = new JSContext();
  }
  /** Plugin registration. */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "flutter_plugin_cal");
    channel.setMethodCallHandler(new FlutterPluginCalPlugin());
  }

  @Override
  public void onMethodCall(MethodCall call, Result result) {
    if (call.method.equals("getPlatformVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE);
    } else if(call.method.equals("calculate")){
      Map arg = call.arguments();
      final String infoData = arg.get("infodata").toString();
      if(infoData.isEmpty()){
        result.success(null);
        return;
      }
      if(jsContext!=null){
        JSValue jsValue = null;
        try {
          jsValue = jsContext.evaluateScript(infoData);
        }catch (Exception e){
        }
        result.success(jsValue != null ? jsValue.toString() : null);
      }else {
        result.success(null);
      }
    }else {
      result.notImplemented();
    }
  }
}
