import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'abc_pay_method_channel.dart';

abstract class AbcPayPlatform extends PlatformInterface {
  /// Constructs a AbcPayPlatform.
  AbcPayPlatform() : super(token: _token);

  static final Object _token = Object();

  static AbcPayPlatform _instance = MethodChannelAbcPay();

  /// The default instance of [AbcPayPlatform] to use.
  ///
  /// Defaults to [MethodChannelAbcPay].
  static AbcPayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AbcPayPlatform] when
  /// they register themselves.
  static set instance(AbcPayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// 获取农行掌银是否存在且可用
  Future<bool> isAvaiable() {
    throw UnimplementedError('isAvaiable() has not been implemented.');
  }

  /// 发起支付
  ///
  /// [callbackId] 支付完成后回调用的id。iOS为第三方app的schema，Android 为第三方APP目标页面的activity。
  ///
  /// [tokenId] 支付订单号
  ///
  /// [appId] 第三方APP的应用标识。iOS无此项内容，值为空；Android为第三方apk的包名。
  void doPay(String callbackId, String tokenId, String? appId) {
    throw UnimplementedError('doPay() has not been implemented.');
  }

  /// 获取支付结果
  Future<String?> getResult() {
    throw UnimplementedError('getResult() has not been implemented.');
  }
}
