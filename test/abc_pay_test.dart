import 'package:flutter_test/flutter_test.dart';
import 'package:abc_pay/abc_pay.dart';
import 'package:abc_pay/abc_pay_platform_interface.dart';
import 'package:abc_pay/abc_pay_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAbcPayPlatform
    with MockPlatformInterfaceMixin
    implements AbcPayPlatform {
  @override
  Future<bool> isAvaiable() => Future.value(true);
  
  @override
  void doPay(String callbackId, String tokenId, String? appId) {}
  
  @override
  Future<String?> getResult() {
    throw UnimplementedError();
  }
}

void main() {
  final AbcPayPlatform initialPlatform = AbcPayPlatform.instance;

  test('$MethodChannelAbcPay is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAbcPay>());
  });

  test('isAvaiable', () async {
    MockAbcPayPlatform fakePlatform = MockAbcPayPlatform();
    AbcPayPlatform.instance = fakePlatform;

    expect(await AbcPay.isAvaiable(), true);
  });
}
