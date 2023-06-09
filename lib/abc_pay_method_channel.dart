import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'abc_pay_platform_interface.dart';

/// An implementation of [AbcPayPlatform] that uses method channels.
class MethodChannelAbcPay extends AbcPayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('abc_pay');

  @override
  Future<bool> isAvaiable() async {
    final version = await methodChannel.invokeMethod<bool>('isAvaiable');
    return version ?? false;
  }

  @override
  void doPay(callbackId, tokenId, appId) {
    methodChannel.invokeMethod(
      'doPay',
      {'callbackId': callbackId, 'tokenId': tokenId, 'appId': appId},
    );
  }

  @override
  Future<String?> getResult() async {
    final result = await methodChannel.invokeMethod<String>('getResult');
    return result;
  }
}
