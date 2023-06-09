import 'abc_pay_platform_interface.dart';

class AbcPay {
  /// 获取农行掌银是否存在且可用
  static Future<bool> isAvaiable() {
    return AbcPayPlatform.instance.isAvaiable();
  }

  /// 发起支付
  /// 
  /// [callbackId] 支付完成后回调用的id。iOS为第三方app的schema，Android 为第三方APP目标页面的activity。
  /// 
  /// [tokenId] 支付订单号
  /// 
  /// [appId] 第三方APP的应用标识。iOS无此项内容，值为空；Android为第三方apk的包名。
  static void doPay({required String callbackId, required String tokenId, String? appId}) {
    AbcPayPlatform.instance.doPay(callbackId, tokenId, appId);
  }

  /// 获取支付结果
  static Future<String?> getResult() async {
    return AbcPayPlatform.instance.getResult();
  }

}
