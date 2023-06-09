package com.example.abc_pay

import android.app.Activity
import android.content.Intent
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

import com.example.caller.BankABCCaller

/** AbcPayPlugin  */
class AbcPayPlugin : FlutterPlugin, MethodCallHandler, ActivityAware {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  /// app Activity
  private var activity: Activity? = null

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "abc_pay")
    channel.setMethodCallHandler(this)
  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
  }

  override fun onDetachedFromActivity() {}
  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {}
  override fun onDetachedFromActivityForConfigChanges() {}

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "isAvaiable") {
      // 获取农行掌银是否存在且可用
      Log.d("Tag", BankABCCaller.isBankABCAvaiable(activity).toString())
      result.success(BankABCCaller.isBankABCAvaiable(activity))
    } else if (call.method == "doPay") {
      // 发起支付
      val arguments: Map<String, String> = call.arguments as Map<String, String>
      Log.d("callbackId", arguments["callbackId"]!!)
      Log.d("tokenId", arguments["tokenId"]!!)
      Log.d("appId", arguments["appId"]!!)

      Log.d("callbackId", activity.toString())
      BankABCCaller.startBankABC(
        activity,
        arguments["appId"],
        activity.toString(),
        "pay",
        arguments["tokenId"]
      )
    }  else if (call.method == "getResult") {
      // 获取结果
//      getIntent()
      Log.d("callbackId1", activity.toString())
      val intent: Intent = activity!!.intent
      Log.d("intent", intent.toString())
      val str: String? = intent.getStringExtra("from_bankabc_param")
//      val intent: String? = Intent.getIntent().getStringExtra("from_bankabc_param")
//      val i: Intent= Intent.parseUri().getStringExtra("from_bankabc_param")
      Log.d("from_bankabc_param", str.toString())
      result.success(str.toString())
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}