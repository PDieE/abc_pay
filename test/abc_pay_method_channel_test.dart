import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:abc_pay/abc_pay_method_channel.dart';

void main() {
  MethodChannelAbcPay platform = MethodChannelAbcPay();
  const MethodChannel channel = MethodChannel('abc_pay');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isAvaiable', () async {
    expect(await platform.isAvaiable(), '42');
  });
}
