# 中国农业银行支付

用于安卓、IOS APP 进行农行掌银支付

| Android | iOS  |
|---------|------|
| SDK 16+ | 9.0+ |

## 使用

```yaml
dependencies:
  abc_pay: ^1.0.0
```

### 示例

``` dart
import 'package:abc_pay/abc_pay.dart';

/// 进行农行掌银支付
void doAbcPay() async {
  final canuse = await AbcPay.isAvaiable();

  if (!canuse) {
    /// 农业银行掌上银行未安装
    return;
  }

  AbcPay.doPay(
    callbackId: "callbackId",
    tokenId: "tokenId",
    appId: "appId", // 安卓必传
  );
}
```

## 配置

### iOS

在工程 `Info.plist` 文件内添加如下配置项
```` plist
<key>LSApplicationQueriesSchemes</key>
<array>
  <string>bankabc</string>
</array>
````

### Android

在工程 `AndroidManifest.xml` 文件内添加如下配置项
``` xml
<queries>
  <package android:name="com.android.bankabc" />
</queries>
```
